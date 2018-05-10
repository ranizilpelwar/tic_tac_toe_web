require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative 'data/data_parser.rb'
require_relative 'response/response_generator.rb'
require_relative 'routes/messages.rb'
require_relative 'routes/matches.rb'
require_relative 'routes/game_status.rb'
require_relative 'routes/player_moves.rb'

before do
	headers 'Content-Type' => 'application/json'
  if request.body.size > 0
    request.body.rewind
    @request_data = JSON.parse request.body.read
    puts "request data: #{@request_data}"
  end
end

post '/game' do
  language_tag = "" 
  match_number = ""
  player1_symbol = ""
  player2_symbol = ""
  current_player_symbol = "" 
  board = ""
  record_moves = false
  last_move_for_player1 = -1
  last_move_for_player2 = -1
  error_message = ""
  begin
    #language_adapter = TicTacToeRZ::LanguageOptionsAdapter.new(directory)
    language_tag = "en"
    match_number = DataParser.parse(@request_data, nil, 'match_number').to_i
    player1_symbol = DataParser.parse(@request_data, nil, 'first_player_symbol')
    player2_symbol = DataParser.parse(@request_data, nil, 'second_player_symbol')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      match_manager = TicTacToeRZ::MatchTypeManager.new
      player1 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,1), player1_symbol)
      player2 = TicTacToeRZ::Player.new(match_manager.player_type(match_number,2), player2_symbol)
      player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
      game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
      player_movement_manager = TicTacToeRZ::PlayerMovementManager.new(match_manager.get_match_type(match_number))
      current_player_symbol = player_manager.current_player.symbol
      board = game_board.board
      record_moves = player_movement_manager.moves_recordable?(match_number)
    rescue TicTacToeRZ::NilReferenceError, TicTacToeRZ::InvalidValueError => error
      error_message = "#{ error.class.name }: #{ error.message }"
      status 400
    end
  end
  data = {:language_tag => language_tag, 
          :match_number => match_number, 
          :player1_symbol => player1_symbol, 
          :player2_symbol => player2_symbol,
          :current_player_symbol => current_player_symbol, 
          :board => board, 
          :record_moves => record_moves, 
          :last_move_for_player1 => -1, 
          :last_move_for_player2 => -1,
          :error_message => error_message}
  ResponseGenerator.generate_game(data)
end