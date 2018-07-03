require 'tic_tac_toe_rz'
require 'json'
require_relative '../models/all_messages.rb'

module ResponseGenerator

  def self.generate_game_status(game_status_data)
    data = {
          "statuses": {
              "game_over": game_status_data[:game_over],
              "tie_game": game_status_data[:tie_game],
              "winner": game_status_data[:winner]
          },
          "errors": {
            "error_message": game_status_data[:error_message]
          }
      }
      data.to_json
  end

  def self.merge(first_response_object, second_response_object)
    first = JSON.parse(first_response_object)
    second = JSON.parse(second_response_object)
    first_error_message = first["errors"]["error_message"]
    second_error_message = second["errors"]["error_message"]
    combined_error_message = first_error_message + ", " + second_error_message
    first["errors"]["error_message"] = combined_error_message
    merged_data = second.merge(first)
    merged_data.to_json
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

  def self.generate_all_messages(message_data, match_data, language_data)
    messenger = TicTacToeRZ::Languages::MessageGenerator
    data = { "messages": {
                  "welcome": message_data[:welcome],
                  "language_configuration_prompt": message_data[:language_configuration_prompt], 
                  "language_configuration_option": message_data[:language_configuration_option],
                  "language_selection_prompt": message_data[:language_selection_prompt],
                  "player_setup_prompt": message_data[:player_setup_prompt],
                  "player_symbol_prompt": message_data[:player_symbol_prompt],
                  "player_symbol_option": message_data[:player_symbol_option],
                  "continue_prompt": message_data[:continue_prompt],
                  "undo_last_move_option": message_data[:undo_last_move_option],
                  "game_over": message_data[:game_over],
                  "tie_game": message_data[:tie_game],
                  "exit_game": message_data[:exit_game],
                  "player_won": message_data[:player_won],
                  "players_intro": message_data[:players_intro],
                  "board_intro": message_data[:board_intro],
                  "board_square_selection": message_data[:board_square_selection],
                  "undo_completion_for_one_player": message_data[:undo_completion_for_one_player],
                  "undo_completion_for_both_players": message_data[:undo_completion_for_both_players],
                  "thinking_process_for_computers_turn": message_data[:thinking_process_for_computers_turn],
                  "thinking_process_incrementor": message_data[:thinking_process_incrementor],
                  "next_move_prompt": message_data[:next_move_prompt],
                  "first_player_of_game_prompt": message_data[:first_player_of_game_prompt],
                  "match_selection_prompt": message_data[:match_selection_prompt],
                  "match_option_description": message_data[:match_option_description],
                  "option_number": message_data[:option_number],
                  "title_of_player_setup_screen": message_data[:title_of_player_setup_screen],
                  "title_of_language_options_screen": message_data[:title_of_language_options_screen],
                  "argument_error": message_data[:argument_error],
                  "uniqueness_error": message_data[:uniqueness_error],
                  "invalid_selection_error": message_data[:invalid_selection_error],
                  "invalid_selection_error_for": message_data[:invalid_selection_error_for],
                  "language_defaults_error": message_data[:language_defaults_error],
                  "no_moves_to_undo_error": message_data[:no_moves_to_undo_error],
                  "line_spacer": message_data[:line_spacer],
                  "configure_language": message_data[:configure_language],
                  "start_game": message_data[:start_game],
                  "player": message_data[:player],
                  "go": message_data[:go],
                  "start_new_game": message_data[:start_new_game],
                  "replay_game_prompt": message_data[:replay_game_prompt],
                  "human": message_data[:human],
                  "computer": message_data[:computer],
                  "undo_move": message_data[:undo_move]
                  },
            "matches": [
              {"player1_type": match_data[:match1_player1_type], "player2_type": match_data[:match1_player2_type]},
              {"player1_type": match_data[:match2_player1_type], "player2_type": match_data[:match2_player2_type]},
              {"player1_type": match_data[:match3_player1_type], "player2_type": match_data[:match3_player2_type]}
              ],
            "languages": language_data,
            "errors": {
              "error_message": message_data[:error_message]
            }
    }
    data.to_json
  end
end