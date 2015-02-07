require 'rails'
require 'bundler/setup'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Bundler.require

RSpec.configure do |config|
end
