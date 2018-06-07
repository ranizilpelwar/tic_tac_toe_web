require 'tic_tac_toe_rz'
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
      @language_adapter = ObjectCreator.language_adapter
      @language_tag = @language_adapter.default_language_tag
      @language_adapter.default_language_tag!("en") if @language_tag != "en"
      @messenger = TicTacToeRZ::MessageGenerator
      @human_in_english = @messenger.human
      @computer_in_english = @messenger.computer
      @language_adapter.default_language_tag!(@language_tag) if @language_tag != "en"
      @messenger = TicTacToeRZ::MessageGenerator
    end

    def construct
      match_manager = TicTacToeRZ::MatchTypeManager.new
      @match1_player1_type = match_manager.player_type(1,1)
      @match1_player2_type = match_manager.player_type(1,2)
      @match2_player1_type = match_manager.player_type(2,1)
      @match2_player2_type = match_manager.player_type(2,2)
      @match3_player1_type = match_manager.player_type(3,1)
      @match3_player2_type = match_manager.player_type(3,2)
      if @language_tag != "en"
        @match1_player1_type = @messenger.human if @match1_player1_type == @human_in_english
        @match1_player1_type = @messenger.computer if @match1_player1_type == @computer_in_english
        @match1_player2_type = @messenger.human if @match1_player2_type == @human_in_english
        @match1_player2_type = @messenger.computer if @match1_player2_type == @computer_in_english
        @match2_player1_type = @messenger.human if @match2_player1_type == @human_in_english
        @match2_player1_type = @messenger.computer if @match2_player1_type == @computer_in_english
        @match2_player2_type = @messenger.human if @match2_player2_type == @human_in_english
        @match2_player2_type = @messenger.computer if @match2_player2_type == @computer_in_english
        @match3_player1_type = @messenger.human if @match3_player1_type == @human_in_english
        @match3_player1_type = @messenger.computer if @match3_player1_type == @computer_in_english
        @match3_player2_type = @messenger.human if @match3_player2_type == @human_in_english
        @match3_player2_type = @messenger.computer if @match3_player2_type == @computer_in_english
      end
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