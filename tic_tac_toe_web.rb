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
  match_manager = TicTacToeRZ::MatchTypeManager.new
  data = [
      {"player1_type" => match_manager.player_type(1,1), "player2_type" => match_manager.player_type(1,2)},
      {"player1_type" => match_manager.player_type(2,1), "player2_type" => match_manager.player_type(2,2)},
      {"player1_type" => match_manager.player_type(3,1), "player2_type" => match_manager.player_type(3,2)}]
  data.to_json
end

post '/player' do
  player = TicTacToeRZ::Player.new(TicTacToeRZ::PlayerType.new(:Human), params[:symbol])
  "success" if !player.nil?
end
