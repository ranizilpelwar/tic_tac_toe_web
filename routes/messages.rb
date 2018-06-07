require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../models/message.rb'

put '/message_content' do
  begin
    message = Models::Message.new
    message.parse(@request_data)
  rescue NoMethodError, TicTacToeRZ::InvalidValueError, TicTacToeRZ::NilReferenceError => error
    message.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    begin
      message.construct
    rescue NoMethodError, TicTacToeRZ::InvalidValueError => error
      message.error_message = "#{ error.class.name }: #{ error.message }"
      status 400  
    end
  end
  ResponseGenerator.generate_message(message.content)
end

get '/message_content' do
  begin
    messages = Models::AllMessages.new
    messages.construct
    matches = Models::MatchTypes.new
    matches.construct
    languages = Models::Language.new
    languages.construct
  rescue TicTacToeRZ::InvalidValueError, NoMethodError, ArgumentError => error
    messages.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  ResponseGenerator.generate_all_messages(messages.content, matches.content, languages.content)
end