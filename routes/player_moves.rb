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
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      player = Models::HumanPlayer.new(game)
      game = player.play_turn(tile_on_board)
      players = Models::Players.new(game)
      game = players.next_player
    rescue TicTacToeRZ::Exceptions::NilReferenceError, TicTacToeRZ::Exceptions::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  game_response = ResponseGenerator.generate_game(game)
  begin
    game_status = Models::GameStatus.new
    game_status.parse(JSON.parse(game_response))
    game_status.construct
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game_status.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  status_response = ResponseGenerator.generate_game_status(game_status.content)
  ResponseGenerator.merge(game_response, status_response)
end

put '/computer_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      player = Models::ComputerPlayer.new(game)
      game = player.play_turn
      players = Models::Players.new(game)
      game = players.next_player
    rescue TicTacToeRZ::Exceptions::InvalidValueError, TicTacToeRZ::Exceptions::NilReferenceError, TicTacToeRZ::Exceptions::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  game_response = ResponseGenerator.generate_game(game)
  begin
    game_status = Models::GameStatus.new
    game_status.parse(JSON.parse(game_response))
    game_status.construct
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game_status.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  status_response = ResponseGenerator.generate_game_status(game_status.content)
  ResponseGenerator.merge(game_response, status_response)
end

put '/undo_move' do
  game = {}
  begin
    puts "before parse"
    game = DataParser.parse_game(@request_data)
    puts "after parse"
  rescue SyntaxError, NoMethodError, TicTacToeRZ::Exceptions::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    begin
      puts "before initialize"
      game_movement = Models::GameMovement.new(game)
      puts "after initialize"
      game = game_movement.undo_move
      puts "after undo"
    rescue TicTacToeRZ::Exceptions::InvalidValueError, TicTacToeRZ::Exceptions::NilReferenceError, TicTacToeRZ::Exceptions::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      game[:stack_trace] = "#{ error.backtrace.join("\n") }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end