require 'sinatra'
require 'sinatra/reloader'
require 'tic_tac_toe_rz'
require 'json'
require_relative '../data/data_parser.rb'
require_relative '../response/response_generator.rb'

  put '/message_content' do
    # get request language tag
    data = DataParser.parse_message(@request_data)
    # build objects

    # get message string

    # create response
    ResponseGenerator.generate_message(data)
  end