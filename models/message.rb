require 'tic_tac_toe_rz'
require_relative '../data/data_parser.rb'
require_relative '../helpers/object_creator.rb'

module Models
  class Message

    attr_accessor :error_message

    def initialize
      @language_tag = ""
      @type = ""
      @text = []
      @error_message = ""
    end

    def parse(request_data)
      @language_tag = DataParser.parse(request_data, 'message','language_tag')
      @type = DataParser.parse(request_data, 'message','type')
    end

    def construct
      language_adapter = ObjectCreator.language_adapter
      language_adapter.default_language_tag!(@language_tag)
      method = @type.to_sym
      message_content = TicTacToeRZ::MessageGenerator.send method
      if message_content.class != Array
        @text << message_content
      else
        @text = message_content
      end
    end

    def content
      data = { :language_tag => @language_tag,
               :type => @type,
               :text => @text, 
               :error_message => @error_message}
    end
  end
end
