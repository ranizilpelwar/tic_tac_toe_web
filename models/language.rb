require 'tic_tac_toe_rz'
require_relative '../helpers/object_creator.rb'

module Models
  class Language
    
    attr_reader :language_tag

    def initialize
      language_adapter = ObjectCreator.language_adapter
      @language_tag = language_adapter.default_language_tag
    end
  end
end
