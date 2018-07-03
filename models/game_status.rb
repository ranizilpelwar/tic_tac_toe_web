require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class GameStatus

    attr_accessor :error_message

    def initialize
      @tie_game = false
      @game_over = false
      @winner = ""
      @error_message = ""
      @board = []
      @player1_symbol = ""
      @player2_symbol = ""
    end

    def parse(request_data)
      @board = DataParser.parse(request_data, 'game', 'board')
      @player1_symbol = DataParser.parse(request_data, 'game', 'player1_symbol')
      @player2_symbol = DataParser.parse(request_data, 'game', 'player2_symbol')
    end

    def construct
      if TicTacToeRZ::GameRules::TieGameRules.tie_game?(@board)
        @game_over = true
        @tie_game = true
      elsif TicTacToeRZ::GameRules::GameOverRules.win_for_player?(@player1_symbol, @board)
        @game_over = true
        @winner = @player1_symbol
      elsif TicTacToeRZ::GameRules::GameOverRules.win_for_player?(@player2_symbol, @board)
        @game_over = true
        @winner = @player2_symbol
      end
    end

    def content
      data = {
              :tie_game => @tie_game, 
              :game_over => @game_over, 
              :winner => @winner,
              :error_message => @error_message
             }
    end
  end
end