require 'tic_tac_toe_rz'

class MatchContent
  def data(match_manager)
    input_choices = match_manager.input_choices
    data = {
    "match1" => {"option" => input_choices[0].to_s, "player1_type" => match_manager.matches[0].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[0].player2_type.selected_option.to_s},
    "match2" => {"option" => input_choices[1].to_s, "player1_type" => match_manager.matches[1].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[1].player2_type.selected_option.to_s},
    "match3" => {"option" => input_choices[2].to_s, "player1_type" => match_manager.matches[2].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[2].player2_type.selected_option.to_s}
  }
  end
end

