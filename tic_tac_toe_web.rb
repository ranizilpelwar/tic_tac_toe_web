require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'rubygems'
require 'json'
require './core/match_content.rb'

before do
	headers 'Content-Type' => 'json'
end

get '/match_types' do
  match_manager = MatchTypeManager.new
  data = {
    "match1" => {"option" => match_manager.input_choices[0].to_s, 
      "player1_type" => match_manager.matches[0].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[0].player2_type.selected_option.to_s},
    "match2" => {"option" => match_manager.input_choices[1].to_s, 
      "player1_type" => match_manager.matches[1].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[1].player2_type.selected_option.to_s},
    "match3" => {"option" => match_manager.input_choices[2].to_s, 
      "player1_type" => match_manager.matches[2].player1_type.selected_option.to_s,
      "player2_type" => match_manager.matches[2].player2_type.selected_option.to_s}
  }
  data.to_json
end

