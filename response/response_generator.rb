module ResponseGenerator
  def self.generate_game_status(game_status_data)
    data = {
          "statuses": {
              "game_over": game_status_data[:game_over],
              "tie_game": game_status_data[:tie_game],
              "winner": game_status_data[:winner]
          },
          "errors": {
            "message": game_status_data[:error_message]
          }
      }
      data.to_json
  end

  def self.generate_matches(match_data)
    data = { "matches": [
          {"player1_type": match_data[:match1_player1_type], "player2_type": match_data[:match1_player2_type]},
          {"player1_type": match_data[:match2_player1_type], "player2_type": match_data[:match2_player2_type]},
          {"player1_type": match_data[:match3_player1_type], "player2_type": match_data[:match3_player2_type]}
          ],
            "errors": {
              "error_message": match_data[:error_message]
            }}
      data.to_json
  end

  def self.generate_game(game_data)
    data = { "game": {
         "language_tag": game_data[:language_tag],
         "match_number": game_data[:match_number],
         "player1_symbol": game_data[:player1_symbol], 
         "player2_symbol": game_data[:player2_symbol],
         "current_player_symbol": game_data[:current_player_symbol],
         "board": game_data[:board],
         "record_moves": game_data[:record_moves],
         "last_move_for_player1": game_data[:last_move_for_player1],
         "last_move_for_player2": game_data[:last_move_for_player2]}, 
         "errors":{
          "error_message": !game_data[:error_message].nil? ? game_data[:error_message] : "",
          "stack_trace": !game_data[:stack_trace].nil? ? game_data[:stack_trace] : ""
         }
       }
    data.to_json
  end

  def self.generate_message(message_data)
    data = { "message": {
      "language_tag": message_data[:language_tag],
      "type": message_data[:type],
      "parameters": message_data[:parameters],
      "text": message_data[:text]
      },
      "errors": {
        "error_message": !message_data[:error_message].nil? ? message_data[:error_message] : ""
      }
    }
    data.to_json
  end

  def self.generate_language_tag(language_data)
    data = { "language": {
      "language_tag": language_data[:language_tag]},
      "errors": {
        "error_message": language_data[:error_message]}
    }
    data.to_json
  end
end