require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'

put '/message_content' do
  begin
    data = DataParser.parse_message(@request_data)
    language_adapter = TicTacToeRZ::LanguageOptionsAdapter.new(TicTacToeRZ::MessageGenerator.directory)
    language_adapter.default_language_tag!(data[:language_tag])
    type = data[:type]
    method = type.to_sym
    text = TicTacToeRZ::MessageGenerator.send method
    if text.class != Array
      data[:text] = []
      data[:text] << text
    else
      data[:text] = text
    end
  rescue NoMethodError, TicTacToeRZ::InvalidValueError => error
    error_message = "#{ error.class.name }: #{ error.message }"
    data[:error_message] = error_message
    data[:text] = []
    status 400
  end
  ResponseGenerator.generate_message(data)
end

