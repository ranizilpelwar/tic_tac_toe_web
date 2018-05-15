require 'tic_tac_toe_rz'
require './helpers/game_rules_validator.rb'

module Models
  class ComputerPlayer
    def initialize(game)
      @game = game
      @depth = 5 # The most # of actions that can be taken before a tie or win can occur in the game.
      @best_max_move = -20000
      @best_min_move = 20000
    end

    def play_turn
      raise TicTacToeRZ::GameRuleViolationError if !GameRulesValidator.legal_move?(@game)
      player_manager = ObjectCreator.player_manager(@game)
      game_board = TicTacToeRZ::GameBoard.new(@game[:board])
      computer_action = TicTacToeRZ::ComputerActions.new(game_board, player_manager)
      current_player_symbol = @game[:current_player_symbol]
      spot = computer_action.get_best_move(game_board.board, current_player_symbol, @depth, @best_max_move, @best_min_move).index
      game_board.update_board(spot.to_i, current_player_symbol)
      @game[:board] = game_board.board
      if @game[:record_moves]
        if current_player_symbol == @game[:player1_symbol]
          @game[:last_move_for_player1] = spot
        elsif current_player_symbol == @game[:player2_symbol]
          @game[:last_move_for_player2] = spot
        end
      end
      @game
    end
  end
end