require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'

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
    language_adapter = ObjectCreator.language_adapter
    language_tag = language_adapter.default_language_tag
    match_number = DataParser.parse(@request_data, nil, 'match_number').to_i
    player1_symbol = DataParser.parse(@request_data, nil, 'first_player_symbol')
    player2_symbol = DataParser.parse(@request_data, nil, 'second_player_symbol')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    begin
      player_data = {:match_number => match_number, :player1_symbol => player1_symbol, :player2_symbol => player2_symbol}
      player_manager = ObjectCreator.player_manager(player_data)
      game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
      player_movement_manager = ObjectCreator.player_movement_manager(player_data)
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