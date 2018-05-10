require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'

put '/human_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
    tile_on_board = DataParser.parse(@request_data, 'actions', 'tile_on_board')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    game_board = TicTacToeRZ::GameBoard.new(game[:board])
    return_result = TicTacToeRZ::GamePlayValidator.evaluate_move(game_board, tile_on_board)
    valid_move = return_result.is_valid_move
    spot = return_result.index_of_board
    current_player_symbol = game[:current_player_symbol]
    if valid_move
      if game[:record_moves]
          if current_player_symbol == game[:player1_symbol]
            game[:last_move_for_player1] = spot
          elsif current_player_symbol == game[:player2_symbol]
            game[:last_move_for_player2] = spot
          end
      end
      game_board.update_board(spot.to_i, current_player_symbol)
      game[:board] = game_board.board
    else
      game[:error_message] = "TicTacToeRZ::GameRuleViolationError: invalid move."
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
    depth = 5 # The most # of actions that can be taken before a tie or win can occur in the game.
    best_max_move = -20000
    best_min_move = 20000
    begin
      match_manager = TicTacToeRZ::MatchTypeManager.new
      player1 = TicTacToeRZ::Player.new(match_manager.player_type(game[:match_number],1), game[:player1_symbol])
      player2 = TicTacToeRZ::Player.new(match_manager.player_type(game[:match_number],2), game[:player2_symbol])
      player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
      game_board = TicTacToeRZ::GameBoard.new(game[:board])
      computer_action = TicTacToeRZ::ComputerActions.new(game_board, player_manager)
      current_player_symbol = game[:current_player_symbol]
      spot = computer_action.get_best_move(game_board.board, current_player_symbol, depth, best_max_move, best_min_move).index
      if game[:record_moves]
        if current_player_symbol == game[:player1_symbol]
          game[:last_move_for_player1] = spot
        elsif current_player_symbol == game[:player2_symbol]
          game[:last_move_for_player2] = spot
        end
      end
      game_board.update_board(spot.to_i, current_player_symbol)
      game[:board] = game_board.board
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
      # Setting up the data
      match_manager = TicTacToeRZ::MatchTypeManager.new
      match_number = game[:match_number]
      player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), game[:player1_symbol])
      player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), game[:player2_symbol])
      player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
      current_player_symbol = game[:current_player_symbol]
      player_manager.update_current_player if current_player_symbol == player2.symbol
      game_board = TicTacToeRZ::GameBoard.new(game[:board])
      player_movement_manager = TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))
      player_movement_manager.update_last_move_for_player(1, game[:last_move_for_player1])
      player_movement_manager.update_last_move_for_player(2, game[:last_move_for_player2])
      
      # Perform the action
      player_movement_manager.undo_last_move(game_board, player_manager)
      
      # Get updated data
      game[:last_move_for_player1] = player_movement_manager.player1_last_move
      game[:last_move_for_player2] = player_movement_manager.player2_last_move
      game[:board] = game_board.board
    rescue TicTacToeRZ::InvalidValueError, TicTacToeRZ::NilReferenceError, TicTacToeRZ::GameRuleViolationError => error
      game[:error_message] = "#{ error.class.name }: #{ error.message }"
      game[:stack_trace] = "#{ error.backtrace.join("\n") }"
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end