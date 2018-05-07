require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative 'data/data_parser.rb'
require_relative 'response/response_generator.rb'

before do
	headers 'Content-Type' => 'application/json'
  if request.body.size > 0
    request.body.rewind
    @request_data = JSON.parse request.body.read
    puts "request data: #{@request_data}"
  end
end

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

put '/human_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
    tile_on_board = DataParser.parse(@request_data, 'actions', 'tile_on_board')
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    game_board = TicTacToeRZ::GameBoard.new(game[:board])
    return_result = TicTacToeRZ::GamePlayValidator.evaluate_move(game_board, tile_on_board)
    valid_move = return_result.is_valid_move
    spot = return_result.index_of_board
    current_player_symbol = game[:current_player_symbol]
    if valid_move
      if game[:record_moves]
          if current_player_symbol == game[:player1_symbol]
            game[:last_move_for_player1] = spot
          elsif current_player_symbol == game[:player2_symbol]
            game[:last_move_for_player2] = spot
          end
      end
      game_board.update_board(spot.to_i, current_player_symbol)
      game[:board] = game_board.board
    else
      game[:error_message] = "This is not a valid move."
      status 400
    end
  end
  ResponseGenerator.generate_game(game)
end

put '/computer_players_turn' do
  game = {}
  begin
    game = DataParser.parse_game(@request_data)
  rescue SyntaxError, NoMethodError, TicTacToeRZ::NilReferenceError => error
    game[:error_message] = "#{ error.class.name }: #{ error.message }"
    status 400
  else 
    depth = 5 # The most # of actions that can be taken before a tie or win can occur in the game.
    best_max_move = -20000
    best_min_move = 20000
    match_manager = TicTacToeRZ::MatchTypeManager.new
    player1 = TicTacToeRZ::Player.new(match_manager.player_type(game[:match_number],1), game[:player1_symbol])
    player2 = TicTacToeRZ::Player.new(match_manager.player_type(game[:match_number],2), game[:player2_symbol])
    player_manager = TicTacToeRZ::PlayerManager.new(player1, player2)
    game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
    computer_action = TicTacToeRZ::ComputerActions.new(game_board, player_manager)
    current_player_symbol = game[:current_player_symbol]
    spot = computer_action.get_best_move(game_board.board, current_player_symbol, depth, best_max_move, best_min_move).index
    if game[:record_moves]
      if current_player_symbol == game[:player1_symbol]
        game[:last_move_for_player1] = spot
      elsif current_player_symbol == game[:player2_symbol]
        game[:last_move_for_player2] = spot
      end
    end
    game_board.update_board(spot.to_i, current_player_symbol)
    game[:board] = game_board.board
  end
  ResponseGenerator.generate_game(game)
end