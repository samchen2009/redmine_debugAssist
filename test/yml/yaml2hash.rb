require 'yaml'
require 'erb'


#base = YAML.load(IO.read("overide.yml"))
#erb = ERB.new(IO.read("myconfig.yml")).result
#puts YAML::load(erb)

def compile_yaml(file)
  text = ""
  path = File.dirname(File.expand_path(file))
  File.open(file) do |f|
    f.each_line do |line|
      match = /^\s*!include\s+"(.*?)"\s*/.match(line)
      if !match.nil? and !match[1].nil?
        text << compile_yaml("#{path}/#{match[1]}")
      else
        text << line
      end
    end
    return text
  end
end

def puts_array(array,level)
    tab = '  '*level
#    puts "#{tab}-"
    array.each do |a|
        if a.is_a?(Array)
            put_array(a,level+1)
        elsif a.is_a?(Hash)
            puts_hash(a,level+1)
        else
            puts "#{tab}  -#{a.to_s}"
        end
    end
end

def puts_hash(hash,level)
    tab = '  '*level
    hash.each do |k,v|
        if v.is_a?(Array)
            puts "#{tab}#{k}:"
            puts_array(v,level+1)
        elsif v.is_a?(Hash)
            puts "#{tab}#{k}:"
            puts_hash(v,level+1)
        else
            puts "#{tab}#{k}:#{v.to_s}"
        end
    end
end

def yaml_to_hash(yaml,key)
  data = YAML::load(yaml)[key]
  while /<%=.*%>/.match(data.to_s) != nil
    template = ERB.new(data.to_yaml)
    data = YAML::load(template.result(binding))
  end
  data
end

if ($0 == __FILE__)
  usage = "usage: ruby yaml2hash.rb path/to/*.yml"

  if (!ARGV[0])
    puts usage
    exit 1
  end

  file = ARGV[0]

  text = ""
  text =  compile_yaml(file)
  hash = yaml_to_hash(text,"filter")
  puts hash
  puts_hash(hash,0)
end
