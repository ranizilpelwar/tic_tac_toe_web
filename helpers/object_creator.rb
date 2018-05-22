require 'tic_tac_toe_rz'

module ObjectCreator

  def self.player_manager(player_and_match_data)
    player1_symbol = player_and_match_data[:player1_symbol]
    player2_symbol = player_and_match_data[:player2_symbol]
    match_number = player_and_match_data[:match_number]
    match_manager = TicTacToeRZ::MatchTypeManager.new
    player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), player1_symbol)
    player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), player2_symbol)
    TicTacToeRZ::PlayerManager.new(player1, player2)
  end

  def self.player_movement_manager(match_data)
    match_manager = TicTacToeRZ::MatchTypeManager.new
    match_number = match_data[:match_number]
    TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))
  end

  def self.language_adapter
    TicTacToeRZ::LanguageOptionsAdapter.new(TicTacToeRZ::MessageGenerator.directory)
  end
end