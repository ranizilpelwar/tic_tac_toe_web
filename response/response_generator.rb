require 'tic_tac_toe_rz'
require 'json'

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

  def self.generate_all_messages
    messenger = TicTacToeRZ::MessageGenerator
    data = { "messages": {
                  "welcome": messenger.welcome,
                  "language_configuration_prompt": messenger.language_configuration_prompt, 
                  "language_configuration_option": messenger.language_configuration_option,
                  "language_selection_prompt": messenger.language_selection_prompt,
                  "player_setup_prompt": messenger.player_setup_prompt,
                  "player_symbol_prompt": messenger.player_symbol_prompt(""),
                  "player_symbol_option": messenger.player_symbol_option,
                  "continue_prompt": messenger.continue_prompt,
                  "undo_last_move_option": messenger.undo_last_move_option,
                  "game_over": messenger.game_over,
                  "tie_game": messenger.tie_game,
                  "exit_game": messenger.exit_game,
                  "player_won": messenger.player_won(""),
                  "players_intro": messenger.players_intro("", "", "", ""),
                  "board_intro": messenger.board_intro,
                  "board_square_selection": messenger.board_square_selection("", ""),
                  "undo_completion_for_one_player": messenger.undo_completion_for_one_player,
                  "undo_completion_for_both_players": messenger.undo_completion_for_both_players,
                  "thinking_process_for_computers_turn": messenger.thinking_process_for_computers_turn(""),
                  "thinking_process_incrementor": messenger.thinking_process_incrementor,
                  "next_move_prompt": messenger.next_move_prompt(""),
                  "first_player_of_game_prompt": messenger.first_player_of_game_prompt("", ""),
                  "match_selection_prompt": messenger.match_selection_prompt,
                  "match_option_description": messenger.match_option_description("", ""),
                  "option_number": messenger.option_number(""),
                  "title_of_player_setup_screen": messenger.title_of_player_setup_screen,
                  "title_of_language_options_screen": messenger.title_of_language_options_screen,
                  "argument_error": messenger.argument_error("", "", ""),
                  "uniqueness_error": messenger.uniqueness_error,
                  "invalid_selection_error": messenger.invalid_selection_error,
                  "invalid_selection_error_for": messenger.invalid_selection_error_for(""),
                  "language_defaults_error": messenger.language_defaults_error,
                  "no_moves_to_undo_error": messenger.no_moves_to_undo_error,
                  "line_spacer": messenger.line_spacer
                  }
    }
    data.to_json
  end
end