#require_relative File.join('..', 'app')
require 'sinatra'
require 'rack/test'

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end