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
end