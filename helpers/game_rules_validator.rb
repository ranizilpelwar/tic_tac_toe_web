require 'tic_tac_toe_rz'

class GameRulesValidator
  def self.legal_move?(game)
    @game = game
    legal = false
    available_tiles = remaining_spaces(game[:board])
    if (available_tiles > 0)
      current_player_symbol = game[:current_player_symbol]
      if current_player_symbol == game[:player1_symbol]
        legal = odd?(available_tiles)
      elsif current_player_symbol == game[:player2_symbol]
        legal = even?(available_tiles)
      else
        raise TicTacToeRZ::InvalidValueError, "current_player_symbol: #{current_player_symbol}"
      end
    end
    legal
  end

  def self.remaining_spaces(board)
    TicTacToeRZ::AvailableSpacesValidator.get_available_spaces(board).length
  end

  def self.even?(number)
    number % 2 == 0
  end

  def self.odd?(number)
    number % 2 != 0
  end
end