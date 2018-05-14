require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class GameMovement
    def initialize(game)
      @game = game
    end
  
    def undo_move
      match_manager = TicTacToeRZ::MatchTypeManager.new
      match_number = @game[:match_number]
      player_manager = ObjectCreator.player_manager(@game)
      current_player_symbol = @game[:current_player_symbol]
      player_manager.update_current_player if current_player_symbol == @game[:player2_symbol]
      game_board = TicTacToeRZ::GameBoard.new(@game[:board])
      player_movement_manager = ObjectCreator.player_movement_manager(@game)
      player_movement_manager.update_last_move_for_player(1, @game[:last_move_for_player1])
      player_movement_manager.update_last_move_for_player(2, @game[:last_move_for_player2])
      
      player_movement_manager.undo_last_move(game_board, player_manager)
      
      @game[:last_move_for_player1] = player_movement_manager.player1_last_move
      @game[:last_move_for_player2] = player_movement_manager.player2_last_move
      @game[:board] = game_board.board
      @game
    end
  end
end