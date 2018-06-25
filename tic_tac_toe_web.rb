require 'openssl'
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
require_relative 'routes/current_player.rb'
require_relative 'helpers/object_creator.rb'

before do
	headers \
  'Content-Type' => 'application/json',
  'Access-Control-Allow-Origin' => '*'
  if request.body.size > 0
    request.body.rewind
    @request_data = JSON.parse request.body.read
    puts "request_data = #{@request_data}"
  end
end

options '*' do
  response.headers["Access-Control-Allow-Methods"] = "GET,PUT,POST,OPTIONS"
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Headers"] = "Access-Control-Allow-Origin, Content-Type, Cache-Control, Accept"
  status 200
end

get '/' do
  "Welcome to Tic Tac Toe!"
end