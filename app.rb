require 'sinatra'
require 'mongoid'
require 'json'

require_relative './routes/init'

# Main App Class where database routes are registered and mongoid is configured.
# And application can be bootstrap if running application directly by executing
# app.rb file
class App < Sinatra::Application
  use BirdsRoute

  # DB Setup
  Mongoid.load! './config/mongoid.yml'

  # start the server if ruby file executed directly
  run! if app_file == $0
end
