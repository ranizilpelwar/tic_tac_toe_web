require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative 'data/data_parser.rb'
require_relative 'response/response_generator.rb'
require_relative 'routes/messages.rb'
require_relative 'routes/matches.rb'
require_relative 'routes/game_statuses.rb'
require_relative 'routes/player_moves.rb'
require_relative 'routes/languages.rb'
require_relative 'routes/games.rb'
require_relative 'helpers/object_creator.rb'

before do
	headers 'Content-Type' => 'application/json'
  if request.body.size > 0
    request.body.rewind
    @request_data = JSON.parse request.body.read
  end
end
