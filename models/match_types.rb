require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'
require_relative '../helpers/object_creator.rb'

module Models
  class MatchTypes

    attr_accessor :error_message

    def initialize
      @match1_player1_type = ""
      @match1_player2_type = ""
      @match2_player1_type = ""
      @match2_player2_type = ""
      @match3_player1_type = ""
      @match3_player2_type = ""
      @error_message = ""
    end

    def construct
      match_manager = TicTacToeRZ::MatchTypeManager.new
      @match1_player1_type = match_manager.player_type(1,1)
      @match1_player2_type = match_manager.player_type(1,2)
      @match2_player1_type = match_manager.player_type(2,1)
      @match2_player2_type = match_manager.player_type(2,2)
      @match3_player1_type = match_manager.player_type(3,1)
      @match3_player2_type = match_manager.player_type(3,2)
    end

    def content
      data = {:match1_player1_type => @match1_player1_type, 
              :match1_player2_type => @match1_player2_type,
              :match2_player1_type => @match2_player1_type, 
              :match2_player2_type => @match2_player2_type,
              :match3_player1_type => @match3_player1_type, 
              :match3_player2_type => @match3_player2_type,
              :error_message => error_message}
    end
  end
end