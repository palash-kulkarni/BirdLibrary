root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')

# Bootstraping an application by rackup file
run App.new
