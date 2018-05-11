require 'rspec'
require 'json'
require 'tic_tac_toe_rz'
require './data/data_parser.rb'

RSpec.describe "A data_parser" do
  context "method called parse" do
    it "returns the property value as a string when the category and string-valued property are found" do
      request = '{ "input": {
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
                  }
      }'
      data = JSON.parse(request)
      output = DataParser.parse(data, 'input', 'first_player_symbol')
      expect(output).to eq("X")
    end

    it "returns the property value as a number when the category and numeric property are found" do
      request = '{ "input": {
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
                  }
      }'
      data = JSON.parse(request)
      output = DataParser.parse(data, 'input', 'match_number')
      expect(output).to eq(2)
    end

    it "returns the property value as a number when there is no category and the numeric property is still found" do
      request = '{ 
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
      }'
      data = JSON.parse(request)
      output = DataParser.parse(data, nil, 'match_number')
      expect(output).to eq(2)
    end

    it "raises a NilReferenceError if the property is not found within a given category" do
      request = '{ "input": {
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
                  }
      }'
      data = JSON.parse(request)
      expect{output = DataParser.parse(data, "input", "fake_property")}.to raise_error(TicTacToeRZ::NilReferenceError)
    end

    it "raises a NilReferenceError if the property is not found when there is no category" do
      request = '{
                  "match_number": 2,
                  "first_player_symbol": "X",
                  "second_player_symbol": "Y"
      }'
      data = JSON.parse(request)
      expect{output = DataParser.parse(data, nil, "fake_property")}.to raise_error(TicTacToeRZ::NilReferenceError)
    end

    it "raises a NilReferenceError if the category is not found" do
      request = '{ "input": {
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
                  }
      }'
      data = JSON.parse(request)
      expect{output = DataParser.parse(data, "category", "fake_property")}.to raise_error(TicTacToeRZ::NilReferenceError)
    end
  end

  context "method called parse_game" do
    it "returns an array with the expected property content" do
      request = '{"game":{"language_tag": "en",
                    "match_number": 2,
                    "player1_symbol": "X", 
                    "player2_symbol": "Y",
                    "current_player_symbol": "X",
                    "board": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                    "record_moves": false,
                    "last_move_for_player1":-1,
                    "last_move_for_player2":-1}}'
      data = JSON.parse(request)
      output = DataParser.parse_game(data)
      game = {}
      game[:board] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      game[:language_tag] = "en"
      game[:match_number] = 2
      game[:player1_symbol] = "X"
      game[:player2_symbol] = "Y"
      game[:current_player_symbol] = "X"
      game[:last_move_for_player1] = -1
      game[:last_move_for_player2] = -1
      game[:record_moves] = false
      game[:error_message] = ""
      expect(output).to eq(game)
    end

    it "raises a NilReferenceError if the input is missing an expected property" do
      request = '{"game":{"language_tag": "en",
                    "player1_symbol": "X", 
                    "player2_symbol": "Y",
                    "current_player_symbol": "X",
                    "board": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                    "record_moves": false,
                    "last_move_for_player1":-1,
                    "last_move_for_player2":-1}}'
      data = JSON.parse(request)
      expect{ output = DataParser.parse_game(data) }.to raise_error(TicTacToeRZ::NilReferenceError)
    end

    it "ignores the extra non-game-related property that was passed in as a parameter to the method" do
      request = '{"game":{"language_tag": "en",
                    "extra_property": "extra property value",
                    "match_number": 2,
                    "player1_symbol": "X", 
                    "player2_symbol": "Y",
                    "current_player_symbol": "X",
                    "board": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                    "record_moves": false,
                    "last_move_for_player1":-1,
                    "last_move_for_player2":-1}}'
      data = JSON.parse(request)
      output = DataParser.parse_game(data)
      game = {}
      game[:board] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      game[:language_tag] = "en"
      game[:match_number] = 2
      game[:player1_symbol] = "X"
      game[:player2_symbol] = "Y"
      game[:current_player_symbol] = "X"
      game[:last_move_for_player1] = -1
      game[:last_move_for_player2] = -1
      game[:record_moves] = false
      game[:error_message] = ""
      expect(output).to eq(game)
    end
  end
end