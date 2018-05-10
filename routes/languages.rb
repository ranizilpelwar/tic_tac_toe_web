require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'
require_relative '../helpers/object_creator.rb'

get '/default_language_tag' do
  language_adapter = ObjectCreator.language_adapter
  data = {:language_tag => language_adapter.default_language_tag}
  ResponseGenerator.generate_language_tag(data)
end
