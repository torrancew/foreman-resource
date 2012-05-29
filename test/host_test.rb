require 'test_helper'

class Foreman::HostTest < Test::Unit::TestCase
  def setup
    super
    @host = Foreman::Host.new(:name => "test", :id => 1)
  end

  def test_path
    assert_equal Foreman::Host.path, "hosts"
  end

  def test_all_should_create_host_objects
    assert Foreman::Host.all.first.is_a?(Foreman::Host)
  end

  def test_should_have_a_name
    assert_equal @host.name, "test"
  end

  def test_should_have_list_of_hosts
    assert Foreman::Host.all.first.hosts.first.is_a? Foreman::Host
  end

end

