require 'rails'
require 'bundler/setup'
require 'active_record_setting'
Bundler.require

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end
