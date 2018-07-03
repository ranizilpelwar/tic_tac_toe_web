require 'tic_tac_toe_rz'

module Models
  class HumanPlayer
    def initialize(game)
      @game = game
    end

    def play_turn(tile_on_board)
      game_board = TicTacToeRZ::GamePlay::GameBoard.new(@game[:board])
      return_result = TicTacToeRZ::GameRules::GamePlayRules.evaluate_move(game_board, tile_on_board)
      valid_move = return_result.is_valid_move
      spot = return_result.index_of_board
      current_player_symbol = @game[:current_player_symbol]
      if valid_move
        game_board.update_board(spot.to_i, current_player_symbol)
        @game[:board] = game_board.board
        if @game[:record_moves]
            if current_player_symbol == @game[:player1_symbol]
              @game[:last_move_for_player1] = spot
            elsif current_player_symbol == @game[:player2_symbol]
              @game[:last_move_for_player2] = spot
            end
        end
      else
        raise TicTacToeRZ::Exceptions::GameRuleViolationError, "valid_move = #{valid_move}"
      end
      @game
    end
  end
end