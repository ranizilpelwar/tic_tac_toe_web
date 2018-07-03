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
      @parameters = []
    end

    def parse(request_data)
      @language_tag = DataParser.parse(request_data, 'message','language_tag')
      @type = DataParser.parse(request_data, 'message','type')
      @parameters = DataParser.parse(request_data, 'message','parameters')
    end

    def construct
      language_adapter = ObjectCreator.language_adapter
      language_adapter.default_language_tag!(@language_tag)
      case @parameters.length
      when 0
        message_content = TicTacToeRZ::Languages::MessageGenerator.send(@type)
      when 1..4
        message_content = TicTacToeRZ::Languages::MessageGenerator.send(@type, *@parameters)
      else
        raise TicTacToeRZ::Exceptions::InvalidValueError, "unknown parameter"
      end
      if message_content.class != Array
        @text << message_content
      else
        @text = message_content
      end
    end

    def content
      data = { :language_tag => @language_tag,
               :type => @type,
               :parameters => @parameters,
               :text => @text, 
               :error_message => @error_message}
    end
  end
end
