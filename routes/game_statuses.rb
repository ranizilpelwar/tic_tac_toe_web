require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'
require_relative '../models/game_status.rb'

put '/game_status' do
  game_status = Models::GameStatus.new
  begin
    game_status.parse(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game_status.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    game_status.construct
  end
  ResponseGenerator.generate_game_status(game_status.content)
end