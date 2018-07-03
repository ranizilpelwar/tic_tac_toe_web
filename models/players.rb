require 'tic_tac_toe_rz'

module Models
  class Players
    def initialize(game)
      @game = game
    end

    def next_player
      current_player_symbol = @game[:current_player_symbol]
      if current_player_symbol == @game[:player1_symbol]
        @game[:current_player_symbol] = @game[:player2_symbol]
      elsif current_player_symbol == @game[:player2_symbol]
        @game[:current_player_symbol] = @game[:player1_symbol]
      else
        raise TicTacToeRZ::Exceptions::InvalidValueError, "current_player_symbol: #{current_player_symbol}"
      end
      @game
    end
  end
end
