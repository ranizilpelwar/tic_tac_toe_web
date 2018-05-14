require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../helpers/object_creator.rb'
require_relative '../models/game.rb'
require_relative '../models/human_player.rb'
require_relative '../models/computer_player.rb'
require_relative '../models/game_movement.rb'

put '/human_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
    tile_on_board = DataParser.parse(@request_data, 'actions', 'tile_on_board')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      player = Models::HumanPlayer.new(game)
      game = player.play_turn(tile_on_board)
    rescue TicTacToeRZ::NilReferenceError, TicTacToeRZ::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end

put '/computer_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      player = Models::ComputerPlayer.new(game)
      game = player.play_turn
    rescue TicTacToeRZ::InvalidValueError, TicTacToeRZ::NilReferenceError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end

put '/undo_move' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    begin
      game_movement = Models::GameMovement.new(game)
      game = game_movement.undo_move
    rescue TicTacToeRZ::InvalidValueError, TicTacToeRZ::NilReferenceError, TicTacToeRZ::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      game[:stack_trace] = "#{ error.backtrace.join("\n") }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end