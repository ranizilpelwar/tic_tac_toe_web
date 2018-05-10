require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'

put '/game_status' do
  error_message = ""
  tie_game = false
  game_over = false
  winner = ""
  begin
    board = DataParser.parse(@request_data, 'game', 'board')
    player1_symbol = DataParser.parse(@request_data, 'game', 'player1_symbol')
    player2_symbol = DataParser.parse(@request_data, 'game', 'player2_symbol')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    status 400
  else
    if TicTacToeRZ::TieGameValidator.tie_game?(board)
      game_over = true
      tie_game = true
    elsif TicTacToeRZ::GameOverValidator.win_for_player?(player1_symbol, board)
      game_over = true
      winner = player1_symbol
    elsif TicTacToeRZ::GameOverValidator.win_for_player?(player2_symbol, board)
      game_over = true
      winner = player2_symbol
    end
  end
  data = {:error_message => error_message, :tie_game => tie_game, 
          :game_over => game_over, :winner => winner}
  ResponseGenerator.generate_game_status(data)
end