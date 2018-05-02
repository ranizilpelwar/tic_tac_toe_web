require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'

before do
	headers 'Content-Type' => 'json'
end

get '/match_types' do
  match_manager = TicTacToeRZ::MatchTypeManager.new
  data = { "matches": [
      {"player1_type": match_manager.player_type(1,1), "player2_type": match_manager.player_type(1,2)},
      {"player1_type": match_manager.player_type(2,1), "player2_type": match_manager.player_type(2,2)},
      {"player1_type": match_manager.player_type(3,1), "player2_type": match_manager.player_type(3,2)}
      ]}
  data.to_json
end

put '/language' do
end

post '/game' do
  #language_adapter = TicTacToeRZ::LanguageOptionsAdapter.new(directory)
  language_tag = "en"
  match_number = params[:match_number].to_i
  match_manager = TicTacToeRZ::MatchTypeManager.new
  player1_symbol = params[:first_player_symbol]
  player2_symbol = params[:second_player_symbol]
  player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), player1_symbol)
  player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), player2_symbol)
  player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
  game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
  player_movement_manager = TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))

  game = { "language_tag": language_tag,
           "match_number": match_number,
           "player1_symbol": player1_symbol, 
           "player2_symbol": player2_symbol,
           "current_player_symbol": player_manager.current_player.symbol,
           "board": game_board.board,
           "record_moves": player_movement_manager.moves_recordable?(match_number)
  }
  game.to_json
end
