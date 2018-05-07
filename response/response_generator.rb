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
end