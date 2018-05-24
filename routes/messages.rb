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
