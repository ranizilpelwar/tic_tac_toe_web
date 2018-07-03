require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../models/players.rb'

put '/current_player' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      players = Models::Players.new(game)
      game = players.next_player
    rescue TicTacToeRZ::Exceptions::InvalidValueError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end