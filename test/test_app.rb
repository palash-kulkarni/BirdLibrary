require_relative '../app'
require 'test/unit'
require 'rack/test'

set :environment, :test

# AppTest class to perform unit testing on application
class AppTest < Test::Unit::TestCase
  # included all the methods of Rack::Test to use
  include Rack::Test::Methods

  # make application available for unit testing
  def app
    App
  end
end
