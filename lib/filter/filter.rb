require "yaml"
require 'erb'

class FilterBase
  attr_reader :name,:yml_name,:configs
   
  def preprocess_yaml(file)
    text = ""
    path = Dir.glob("**/#{file}")[0]
    return nil if path.nil?
    File.open(path) do |f|
      f.each_line do |line|
        match = /^\s*!include\s+"(.*?)"\s*/.match(line)
        if !match.nil? and !match[1].nil?
          text << compile_yaml("#{path}/#{match[1]}")
        else
          text << line
        end
      end
    end
    return text
  end

  def initialize (yml,key)
    if yml
      @yml_name = yml
      yml_text = preprocess_yaml(yml)
      return nil if yml_text.nil?
      data = YAML::load(yml_text)[key]
      while /<%=.*%>/.match(data.to_s) != nil
        template = ERB.new(data.to_yaml)
        data = YAML::load(template.result(binding))
      end
      @name = data["name"]
      @configs = data
    end
  end
end

class Rule < FilterBase
  def initialize(yml)
    super(yml,"rule")
    p "Rule #{yml}'s config"
    p @configs 
    p "\n"
  end

  def perform(log)
    filters = []

    @configs["filters"].each do |f|
      filters << {:name => f, :obj => Filter.new(f+".yml")}
    end if @configs["filters"]

    @configs["rules"].each do |r|
      filters << {:name => r, :obj => Rule.new(r+".yml")}
    end if @configs["rules"]

    if @configs["relation"]
      expr = @configs["relation"].dup
      filters.each_with_index do |f, i|
        ret = f[:obj].perform(log)
        expr.gsub!(/#{f[:name]}(\s+|$)/i, "#{ret} ")
      end
    else
      expr = "false"
      filters.each do |f|
        ret = f[:obj].perform(log)
        expr << " or #{ret} "
      end      
    end
    puts expr
    if eval(expr)
      p "Analyze result by rule #{@configs["name"]}: "
    else
      p "Nothing found by rule #{@configs["name"]}"  
    end
    return eval(expr)
  end
end



class Filter < FilterBase

  attr_reader :input, :output
  
  def initialize (yml)
    super(yml,"filter")
  end

  def match(pattern,input)
    !eval(pattern).match(input).nil?
  end

  def section(log)
    #get the interest section of input
    log
  end

  #Input are text or Logfile
  def perform(log)
    if input.is_a?(String)
      sputs("Input string: #{input}")
    elsif input.is_a?(File)
      file = log
      #puts("Input is a file")
    end

    sec = section(log)

    if @configs["matches"]["relations"]
      expr = @configs["matches"]["relations"].dup
      expr = @configs["matches"]["patterns"].inject(expr) do |e, pattern|
        e = e.gsub(/#{pattern["name"]}/,"#{match(pattern["regexp"],sec)}")
      end
      #p expr

      if eval(expr)
        p @configs["output"]
      else
      end
      return eval(expr)
    end
  end
end

