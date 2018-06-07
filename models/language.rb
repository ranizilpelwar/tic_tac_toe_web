require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class Language
    
    attr_reader :language_tag

    def initialize
      @languages = {}
      @language_adapter = ObjectCreator.language_adapter
      @language_tag = @language_adapter.default_language_tag
    end

    def construct
      @languages = @language_adapter.all_languages
    end

    def content
      convert_to_symbols = []
      @languages.each do |language|
        record = {:description => language["description"], :language_tag => language["tag"]}
        convert_to_symbols << record
      end
      convert_to_symbols
    end
  end
end
