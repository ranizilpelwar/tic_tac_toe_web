require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'
require_relative '../helpers/object_creator.rb'
require_relative '../models/language.rb'

get '/default_language_tag' do
  data = {}
  error_message = ""
  data[:error_message] = error_message
  begin
    language = Models::Language.new
    data[:language_tag] = language.language_tag
  rescue TicTacToeRZ::NilReferenceError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  ResponseGenerator.generate_language_tag(data)
end
