require "test/unit"
$LOAD_PATH.unshift *Dir["#{File.dirname(__FILE__)}/../lib"]
require "foreman"

class Test::Unit::TestCase
  def setup
    opts = {
      :url      => ENV['FOREMAN_SERVER']   || 'http://localhost:3000',
      :user     => ENV['FOREMAN_USER']     || '',
      :password => ENV['FOREMAN_PASSWORD'] || '',
    }
    Foreman::Resource.connect(opts)
  end
end
