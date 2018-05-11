require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../response/response_generator.rb'
require_relative '../models/match_types.rb'

get '/match_types' do
  begin
    match_types = Models::MatchTypes.new
    match_types.construct
  rescue TicTacToeRZ::InvalidValueError => error
    match_types.error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  end
  ResponseGenerator.generate_matches(match_types.content)
end
