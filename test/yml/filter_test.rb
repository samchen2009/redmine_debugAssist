#require File.expand_path('../../test_helper', __FILE__)
require 'test/unit'
require File.expand_path('../../../lib/filter/filter', __FILE__)

class TestFilter < Test::Unit::TestCase
  def test_base_init
    fbase = FilterBase.new("filter_example.yml",'filter')
    assert(fbase.name == "filter_example")
    assert(fbase.configs)
  end

  def test_filter_init
    filter = Filter.new("filter_example.yml")
    assert(filter.name == "filter_example")
    assert(filter.configs)
  end

  def test_filter_perform
    filter = Filter.new("filter_example.yml")
    assert(filter.perform("adfasdf kernel panic asdfafd"))
    assert(filter.perform("adfasdf fatal exception asdfafd"))
    assert(!filter.perform("adfasdf fatal asdfafd"))

  end

  def test_rule_init
    rule = Rule.new("rule_example.yml")
    assert(rule.name == "rule_example")
    assert(rule.configs)
  end

  def test_rule_perform
    rule = Rule.new("rule_example.yml")
    assert(rule.perform("ANR at anr_function: asdfasdf"))
    assert(!rule.perform("ANR at function: asdfasdf"))
  end
end
