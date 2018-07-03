require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'
require_relative '../helpers/object_creator.rb'
require_relative '../models/language.rb'
require_relative '../models/default_language.rb'
require_relative '../models/all_messages.rb'
require_relative '../models/match_types.rb'

get '/default_language_tag' do
  data = {}
  error_message = ""
  data[:error_message] = error_message
  begin
    language = Models::Language.new
    data[:language_tag] = language.language_tag
  rescue TicTacToeRZ::Exceptions::NilReferenceError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  ResponseGenerator.generate_language_tag(data)
end

put '/default_language_tag' do
  begin
    default_language = Models::DefaultLanguage.new
    default_language.parse(@request_data)
    default_language.construct
    messages = Models::AllMessages.new
    messages.construct
    matches = Models::MatchTypes.new
    matches.construct
    languages = Models::Language.new
    languages.construct
  rescue NoMethodError, TicTacToeRZ::Exceptions::InvalidValueError, TicTacToeRZ::Exceptions::NilReferenceError => error
    messages.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    begin
      messages.construct
    rescue NoMethodError, TicTacToeRZ::Exceptions::InvalidValueError => error
      messages.error_message = "#{ error.class.name }: #{ error.message }"
      status 400  
    end
  end
  ResponseGenerator.generate_all_messages(messages.content, matches.content, languages.content)
end