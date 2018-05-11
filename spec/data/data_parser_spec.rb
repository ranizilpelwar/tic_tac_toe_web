require 'rspec'
require 'json'
require 'tic_tac_toe_rz'
require './data/data_parser.rb'

RSpec.describe "A data_parser" do
  context "method called parse" do
    it "raises a NilReferenceError if the property is not found within a given category" do
      sample = { "input": {
                    "match_number": 2,
                    "first_player_symbol": "X",
                    "second_player_symbol": "Y"
                  }
      }
      data = sample.to_json
      expect{output = DataParser.parse(data, "input", "fake_property")}.to raise_error(TicTacToeRZ::NilReferenceError)
    end
  end
end