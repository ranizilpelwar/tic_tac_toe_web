require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'

get '/match_types' do
  error_message = ""
  match_manager = TicTacToeRZ::MatchTypeManager.new
  begin
    data = {:match1_player1_type => match_manager.player_type(1,1), :match1_player2_type => match_manager.player_type(1,2),
        :match2_player1_type => match_manager.player_type(2,1), :match2_player2_type => match_manager.player_type(2,2),
        :match3_player1_type => match_manager.player_type(3,1), :match3_player2_type => match_manager.player_type(3,2),
        :error_message => error_message}
  rescue TicTacToeRZ::InvalidValueError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    data[:error_message] = error
    status 400
  end
  ResponseGenerator.generate_matches(data)
end
