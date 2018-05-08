module ResponseGenerator
  def self.generate_game_status(args)
    data = {
          "statuses": {
              "game_over": args[:game_over],
              "tie_game": args[:tie_game],
              "winner": args[:winner]
          },
          "errors": {
            "message": args[:error_message]
          }
      }
      data.to_json
  end

  def self.generate_matches(args)
    data = { "matches": [
          {"player1_type": args[:match1_player1_type], "player2_type": args[:match1_player2_type]},
          {"player1_type": args[:match2_player1_type], "player2_type": args[:match2_player2_type]},
          {"player1_type": args[:match3_player1_type], "player2_type": args[:match3_player2_type]}
          ],
            "errors": {
              "error_message": args[:error_message]
            }}
      data.to_json
  end

  def self.generate_game(args)
    data = { "game": {
         "language_tag": args[:language_tag],
         "match_number": args[:match_number],
         "player1_symbol": args[:player1_symbol], 
         "player2_symbol": args[:player2_symbol],
         "current_player_symbol": args[:current_player_symbol],
         "board": args[:board],
         "record_moves": args[:record_moves],
         "last_move_for_player1": args[:last_move_for_player1],
         "last_move_for_player2": args[:last_move_for_player2]}, 
         "errors":{
          "error_message": !args[:error_message].nil? ? args[:error_message] : "",
          "stack_trace": !args[:stack_trace].nil? ? args[:stack_trace] : ""
         }
       }
    data.to_json
  end
end