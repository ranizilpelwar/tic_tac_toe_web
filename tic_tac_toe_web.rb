require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'

before do
	headers 'Content-Type' => 'application/json'
  if request.body.size > 0
    request.body.rewind
    @request_data = JSON.parse request.body.read
    puts "request data: #{@request_data}"
  end
end

get '/match_types' do
  match_manager = TicTacToeRZ::MatchTypeManager.new
  data = { "matches": [
      {"player1_type": match_manager.player_type(1,1), "player2_type": match_manager.player_type(1,2)},
      {"player1_type": match_manager.player_type(2,1), "player2_type": match_manager.player_type(2,2)},
      {"player1_type": match_manager.player_type(3,1), "player2_type": match_manager.player_type(3,2)}
      ]}
  puts "response data = #{data}"
  data.to_json
end

put '/game_status' do
  board = @request_data['game']['board']
  player1_symbol = @request_data['game']['player1_symbol']
  player2_symbol = @request_data['game']['player2_symbol']

  tie_game = TicTacToeRZ::TieGameValidator.tie_game?(board)
  game_over = false
  winner = ""
  if TicTacToeRZ::GameOverValidator.win_for_player?(player1_symbol, board)
    game_over = true
    winner = player1_symbol
  elsif TicTacToeRZ::GameOverValidator.win_for_player?(player2_symbol, board)
    game_over = true
    winner = player2_symbol
  end
  data = {
    "game_over": game_over,
    "tie_game": tie_game,
    "winner": winner
  }
  data.to_json
end

post '/game' do
  #language_adapter = TicTacToeRZ::LanguageOptionsAdapter.new(directory)
  language_tag = "en"
  match_number = @request_data['match_number'].to_i
  match_manager = TicTacToeRZ::MatchTypeManager.new
  player1_symbol = @request_data['first_player_symbol']
  player2_symbol = @request_data['second_player_symbol']
  player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), player1_symbol)
  player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), player2_symbol)
  player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
  game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
  player_movement_manager = TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))
  data = { "game": {
         "language_tag": language_tag,
         "match_number": match_number,
         "player1_symbol": player1_symbol, 
         "player2_symbol": player2_symbol,
         "current_player_symbol": player_manager.current_player.symbol,
         "board": game_board.board,
         "record_moves": player_movement_manager.moves_recordable?(match_number),
         "last_move_for_player1": -1,
         "last_move_for_player2": -1}
       }
  puts "response data = #{data}"
  data.to_json
end

put '/human_players_turn' do
  current_player_symbol = @request_data['game']['current_player_symbol']
  tile_on_board = @request_data['actions']['tile_on_board']
  board = @request_data['game']['board']
  game_board = TicTacToeRZ::GameBoard.new(board)
  return_result = TicTacToeRZ::GamePlayValidator.evaluate_move(game_board, tile_on_board)
  valid_move = return_result.is_valid_move
  spot = return_result.index_of_board
  game = {}
  success = false
  puts "valid_move = #{valid_move}"
  player1_symbol = @request_data['game']['player1_symbol']
  player2_symbol = @request_data['game']['player2_symbol']
  current_player_symbol = @request_data['game']['current_player_symbol']
  last_move_for_player1 = @request_data['game']['last_move_for_player1']
  last_move_for_player2 = @request_data['game']['last_move_for_player2']
  record_moves = @request_data['game']['record_moves']
  if !valid_move
    data = { "game": {
           "language_tag": @request_data['game']['language_tag'],
           "match_number": @request_data['game']['match_number'],
           "player1_symbol": player1_symbol,
           "player2_symbol": player2_symbol,
           "current_player_symbol": current_player_symbol,
           "board": board,
           "record_moves": record_moves,
           "last_move_for_player1": last_move_for_player1,
           "last_move_for_player2": last_move_for_player2
         }
    }
  else
    if record_moves
        if current_player_symbol == player1_symbol
          last_move_for_player1 = spot
        elsif current_player_symbol == player2_symbol
          last_move_for_player2 = spot
        end
    end
    game_board.update_board(spot.to_i, current_player_symbol)
    success = true
    data = { "game": {
           "language_tag": @request_data['game']['language_tag'],
           "match_number": @request_data['game']['match_number'],
           "player1_symbol": player1_symbol, 
           "player2_symbol": player2_symbol,
           "current_player_symbol": current_player_symbol,
           "board": game_board.board,
           "record_moves": @request_data['game']['record_moves'],
           "last_move_for_player1": last_move_for_player1,
           "last_move_for_player2": last_move_for_player2
           }
    }
  end
  puts "response data = #{data}"
  data.to_json
end
