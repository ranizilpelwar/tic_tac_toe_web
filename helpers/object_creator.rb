require 'tic_tac_toe_rz'

module ObjectCreator

  def self.match_manager(args)
    match_number = args[:match_number]
    TicTacToeRZ::MatchTypeManager.new
  end

  def self.player_manager(args)
    player1_symbol = args[:player1_symbol]
    player2_symbol = args[:player2_symbol]
    match_number = args[:match_number]
    match_manager = match_manager(args)
    player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), player1_symbol)
    player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), player2_symbol)
    TicTacToeRZ::PlayerManager.new(player1, player2)
  end

  def self.player_movement_manager(args)
    match_manager = match_manager(args)
    match_number = args[:match_number]
    TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))
  end
end