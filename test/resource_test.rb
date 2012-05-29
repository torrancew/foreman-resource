require 'test_helper'

class Foreman::ResourceTest < Test::Unit::TestCase

  def test_should_have_path
    assert_equal Foreman::Resource.path, "resources"
  end

  def test_should_respond_to_all
    assert Foreman::Resource.respond_to?(:all)
  end

  def test_search_url_should_not_contain_spaces
    assert Foreman::Resource.send(:search,"a = b") =~ /^\?search=/
  end


end
