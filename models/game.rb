require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class Game

    attr_accessor :error_message

    def initialize
      @language_tag = "" 
      @match_number = ""
      @player1_symbol = ""
      @player2_symbol = ""
      @current_player_symbol = ""
      @board = ""
      @record_moves = false
      @last_move_for_player1 = -1
      @last_move_for_player2 = -1
      @error_message = ""
    end

    def parse(request_data)
      language_adapter = ObjectCreator.language_adapter
      @language_tag = language_adapter.default_language_tag
      @match_number = DataParser.parse(request_data, nil, 'match_number').to_i
      @player1_symbol = DataParser.parse(request_data, nil, 'first_player_symbol')
      @player2_symbol = DataParser.parse(request_data, nil, 'second_player_symbol')
    end

    def construct
      player_data = { :match_number => @match_number, 
                      :player1_symbol => @player1_symbol, 
                      :player2_symbol => @player2_symbol}
      player_manager = ObjectCreator.player_manager(player_data)
      game_board = TicTacToeRZ::GameBoard.new(TicTacToeRZ::GameBoard.create_board)
      player_movement_manager = ObjectCreator.player_movement_manager(player_data)
      @current_player_symbol = player_manager.current_player.symbol
      @board = game_board.board
      @record_moves = player_movement_manager.moves_recordable?(@match_number)
    end

    def content
      data = {:language_tag => @language_tag, 
              :match_number => @match_number, 
              :player1_symbol => @player1_symbol, 
              :player2_symbol => @player2_symbol,
              :current_player_symbol => @current_player_symbol, 
              :board => @board, 
              :record_moves => @record_moves, 
              :last_move_for_player1 => @last_move_for_player1, 
              :last_move_for_player2 => @last_move_for_player2,
              :error_message => @error_message}
    end
  end
end