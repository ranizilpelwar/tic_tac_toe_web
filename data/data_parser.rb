require 'tic_tac_toe_rz'

module DataParser
  def self.parse(request_data, category, property_name)
    if !category.nil?
      raise TicTacToeRZ::NilReferenceError, "#{property_name} in #{category} is missing" if !request_data[category].include?(property_name)
      request_data[category][property_name]
    else
      raise TicTacToeRZ::NilReferenceError, "#{property_name} is missing" if !request_data.include?(property_name)
      request_data[property_name]
    end
  end

  def self.parse_game(request_data)
    game = {}
    game[:board] = parse(request_data, 'game','board')
    game[:language_tag] = parse(request_data, 'game','language_tag')
    game[:match_number] = parse(request_data, 'game','match_number')
    game[:player1_symbol] = parse(request_data, 'game','player1_symbol')
    game[:player2_symbol] = parse(request_data, 'game','player2_symbol')
    game[:current_player_symbol] = parse(request_data, 'game', 'current_player_symbol')
    game[:last_move_for_player1] = parse(request_data, 'game', 'last_move_for_player1')
    game[:last_move_for_player2] = parse(request_data, 'game', 'last_move_for_player2')
    game[:record_moves] = parse(request_data, 'game', 'record_moves')
    game[:error_message] = ""
    game
  end
end