require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../models/message.rb'

put '/message_content' do
  begin
    default_language = Models::DefaultLanguage.new
    current_default_tag = default_language.language_tag
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
      default_language.reset
    rescue NoMethodError, TicTacToeRZ::Exceptions::InvalidValueError => error
      messages.error_message = "#{ error.class.name }: #{ error.message }"
      status 400  
    end
  end
  ResponseGenerator.generate_all_messages(messages.content, matches.content, languages.content)
end

get '/message_content' do
  begin
    messages = Models::AllMessages.new
    messages.construct
    matches = Models::MatchTypes.new
    matches.construct
    languages = Models::Language.new
    languages.construct
  rescue TicTacToeRZ::Exceptions::InvalidValueError, NoMethodError, ArgumentError => error
    messages.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  ResponseGenerator.generate_all_messages(messages.content, matches.content, languages.content)
end