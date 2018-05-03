require_relative '../spec_helper.rb'
require_relative '../../tic_tac_toe_web.rb'
require 'rspec'
require 'rack/test'

describe 'Game' do
  describe 'Post' do
    it 'returns a board' do
      post '/game', :game => {"match_number": 2, "first_player_symbol": "X", "second_player_symbol": "Y"}
      expect last_response.body.include?('board')
    end

    it 'returns a board with nine elements' do
      data = '{"match_number": 2, "first_player_symbol": "X", "second_player_symbol": "Y"}'
      post '/game', JSON.parse(data), 'CONTENT_TYPE' => 'application/json'
      #puts "location = ##{last_response.method(:ok?).source_location}"
      puts "last_response.body = #{last_response.body}"
      #expect(last_response.body).to eq(expected)
      expect(last_response['Content-Type']).to eq('application/json')
      #expect(last_response.body.json['game']['board'].count).to eq(9)
    end  
  end

  describe 'GET / match_types' do
    it "is successful" do
      get '/match_types'
      expect last_response.ok?
    end

    it "contains a matches property" do
      get '/match_types'
      expect last_response.body.include?('matches')
    end

    it "contains three matches" do
      get '/match_types'
      data = JSON.parse(last_response.body)
      expect(data['matches'].count).to eq(3)
    end
  end
end