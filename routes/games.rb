require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../models/game.rb'


post '/game' do
  begin
    game = Models::Game.new
    game.parse(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    begin
      game.construct
    rescue TicTacToeRZ::NilReferenceError, TicTacToeRZ::InvalidValueError => error
      game.error_message = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game.content)
end