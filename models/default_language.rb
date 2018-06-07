require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class DefaultLanguage

    attr_reader :language_tag

    def initialize
      @language_adapter = ObjectCreator.language_adapter
      @original_tag = @language_adapter.default_language_tag
      @language_tag = @original_tag
    end

    def parse(language_request_content)
      new_language_tag = language_request_content["language_tag"]
      raise TicTacToeRZ::InvalidValueError if !@language_adapter.valid?(new_language_tag)
      @language_tag = new_language_tag
    end

    def construct
      @language_adapter.default_language_tag!(@language_tag)
    end

    def reset
      @language_adapter.default_language_tag!(@original_tag) if @language_tag != @original_tag
    end
  end
end
