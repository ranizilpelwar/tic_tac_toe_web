require 'tic_tac_toe_rz'
require_relative '../data/data_parser.rb'
require_relative '../helpers/object_creator.rb'

module Models
  class AllMessages

    attr_accessor :error_message

    def initialize
      @welcome = ""
      @language_configuration_prompt = "" 
      @language_configuration_option = ""
      @language_selection_prompt = ""
      @player_setup_prompt = ""
      @player_symbol_prompt = ""
      @player_symbol_option = ""
      @continue_prompt = ""
      @undo_last_move_option = ""
      @game_over = ""
      @tie_game = ""
      @exit_game = ""
      @player_won = ""
      @players_intro = ""
      @board_intro = ""
      @board_square_selection = ""
      @undo_completion_for_one_player = ""
      @undo_completion_for_both_players = ""
      @thinking_process_for_computers_turn = ""
      @thinking_process_incrementor = ""
      @next_move_prompt = ""
      @first_player_of_game_prompt = ""
      @match_selection_prompt = ""
      @match_option_description = ""
      @option_number = ""
      @title_of_player_setup_screen = ""
      @title_of_language_options_screen = ""
      @argument_error = ""
      @uniqueness_error = ""
      @invalid_selection_error = ""
      @invalid_selection_error_for = ""
      @language_defaults_error = ""
      @no_moves_to_undo_error = ""
      @line_spacer = "\n"
      @error_message = ""
      @configure_language = ""
      @start_game = ""
      @player = ""
      @go = ""
      @start_new_game = ""
      @replay_game_prompt = ""
      @human = ""
      @computer = ""
      @undo_move = ""
    end

    def construct
      messenger = TicTacToeRZ::MessageGenerator
      @welcome = messenger.welcome
      @language_configuration_prompt = messenger.language_configuration_prompt
      @language_configuration_option = messenger.language_configuration_option
      @language_selection_prompt = messenger.language_selection_prompt
      @player_setup_prompt = messenger.player_setup_prompt
      @player_symbol_prompt = messenger.player_symbol_prompt("")
      @player_symbol_option = messenger.player_symbol_option
      @continue_prompt = messenger.continue_prompt
      @undo_last_move_option = messenger.undo_last_move_option
      @game_over = messenger.game_over
      @tie_game = messenger.tie_game
      @exit_game = messenger.exit_game
      @player_won = messenger.player_won("")
      @players_intro = messenger.players_intro("", "", "", "")
      @board_intro = messenger.board_intro
      @board_square_selection = messenger.board_square_selection("", "")
      @undo_completion_for_one_player = messenger.undo_completion_for_one_player
      @undo_completion_for_both_players = messenger.undo_completion_for_both_players
      @thinking_process_for_computers_turn = messenger.thinking_process_for_computers_turn("")
      @thinking_process_incrementor = messenger.thinking_process_incrementor
      @next_move_prompt = messenger.next_move_prompt("")
      @first_player_of_game_prompt = messenger.first_player_of_game_prompt("", "")
      @match_selection_prompt = messenger.match_selection_prompt
      @match_option_description = messenger.match_option_description("", "")
      @option_number = messenger.option_number("")
      @title_of_player_setup_screen = messenger.title_of_player_setup_screen
      @title_of_language_options_screen = messenger.title_of_language_options_screen
      @argument_error = messenger.argument_error("", "", "")
      @uniqueness_error = messenger.uniqueness_error
      @invalid_selection_error = messenger.invalid_selection_error
      @invalid_selection_error_for = messenger.invalid_selection_error_for("")
      @language_defaults_error = messenger.language_defaults_error
      @no_moves_to_undo_error = messenger.no_moves_to_undo_error
      @line_spacer = messenger.line_spacer
      @configure_language = messenger.configure_language
      @start_game = messenger.start_game
      @player = messenger.player
      @go = messenger.go
      @start_new_game = messenger.start_new_game
      @replay_game_prompt = messenger.replay_game_prompt
      @human = messenger.human
      @computer = messenger.computer
      @undo_move = messenger.undo_move
    end

    def content
      data = { :welcome => @welcome,
        :language_configuration_prompt => @language_configuration_prompt,
        :language_configuration_option => @language_configuration_option,
        :language_selection_prompt => @language_selection_prompt,
        :player_setup_prompt => @player_setup_prompt,
        :player_symbol_prompt => @player_symbol_prompt,
        :player_symbol_option => @player_symbol_option,
        :continue_prompt => @continue_prompt,
        :undo_last_move_option => @undo_last_move_option,
        :game_over => @game_over,
        :tie_game => @tie_game,
        :exit_game => @exit_game,
        :player_won => @player_won,
        :players_intro => @players_intro,
        :board_intro => @board_intro,
        :board_square_selection => @board_square_selection,
        :undo_completion_for_one_player => @undo_completion_for_one_player,
        :undo_completion_for_both_players => @undo_completion_for_both_players,
        :thinking_process_for_computers_turn => @thinking_process_for_computers_turn,
        :thinking_process_incrementor => @thinking_process_incrementor,
        :next_move_prompt => @next_move_prompt,
        :first_player_of_game_prompt => @first_player_of_game_prompt,
        :match_selection_prompt => @match_selection_prompt,
        :match_option_description => @match_option_description,
        :option_number => @option_number,
        :title_of_player_setup_screen => @title_of_player_setup_screen,
        :title_of_language_options_screen => @title_of_language_options_screen,
        :argument_error => @argument_error,
        :uniqueness_error => @uniqueness_error,
        :invalid_selection_error => @invalid_selection_error,
        :invalid_selection_error_for => @invalid_selection_error_for,
        :language_defaults_error => @language_defaults_error,
        :no_moves_to_undo_error => @no_moves_to_undo_error,
        :line_spacer => @line_spacer,
        :error_message => @error_message,
        :configure_language => @configure_language,
        :start_game => @start_game,
        :player => @player,
        :go => @go,
        :start_new_game => @start_new_game,
        :replay_game_prompt => @replay_game_prompt,
        :human => @human,
        :computer => @computer, 
        :undo_move => @undo_move
      }
    end
  end
end
