require 'rspec'
require 'tic_tac_toe_rz'
require './helpers/game_rules_validator.rb'

RSpec.describe "A GameRulesValidator" do
  context "method called remaining_spaces" do
    it "returns 0 when there are no available spaces on the board" do
      board = ["X", "Y", "X", "Y", "X", "Y", "X", "Y", "X"]
      result = GameRulesValidator.remaining_spaces(board)
      expect(result).to eq(0)
    end

    it "returns 9 when there are all available spaces on the board" do
      board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
      result = GameRulesValidator.remaining_spaces(board)
      expect(result).to eq(9)
    end

    it "returns 5 when there are five available spaces on the board" do
      board = ["1", "X", "3", "X", "X", "6", "7", "8", "X"]
      result = GameRulesValidator.remaining_spaces(board)
      expect(result).to eq(5)
    end
  end

  context "method called even?" do
    it "returns true when the input is 2" do
      number = 2
      result = GameRulesValidator.even?(number)
      expect(result).to be true
    end

    it "returns true when the input is 0" do
      number = 2
      result = GameRulesValidator.even?(number)
      expect(result).to be true
    end

    it "returns false when the input is 1" do
      number = 1
      result = GameRulesValidator.even?(number)
      expect(result).to be false
    end

    it "returns false when the input is 3" do
      number = 1
      result = GameRulesValidator.even?(number)
      expect(result).to be false
    end
  end

  context "method called odd?" do
    it "returns true when the input is 3" do
      number = 3
      result = GameRulesValidator.odd?(number)
      expect(result).to be true
    end

    it "returns true when the input is 1" do
      number = 1
      result = GameRulesValidator.odd?(number)
      expect(result).to be true
    end

    it "returns false when the input is 0" do
      number = 0
      result = GameRulesValidator.odd?(number)
      expect(result).to be false
    end

    it "returns false when the input is 2" do
      number = 2
      result = GameRulesValidator.odd?(number)
      expect(result).to be false
    end
  end

  context "method called legal_move?" do
      shared_examples "legal move check" do |player1_symbol, player2_symbol, current_player_symbol, current_player, board, remaining_spaces, result|
        it "returns #{result} when current player is #{current_player} and remaining_spaces is #{remaining_spaces}" do
          game = {:board => board, :player1_symbol => player1_symbol, :player2_symbol => player2_symbol, :current_player_symbol => player1_symbol}
          expect(GameRulesValidator.legal_move?(game)).to be result
        end
      end

      include_examples "legal move check", "X", "Y", "X", "player1", ["1", "2", "3", "4", "5", "6", "7", "8", "9"], 9, true
      include_examples "legal move check", "X", "Y", "X", "player1", ["1", "X", "Y", "4", "5", "6", "7", "8", "9"], 7, true
      include_examples "legal move check", "X", "Y", "X", "player1", ["1", "X", "Y", "X", "Y", "6", "7", "8", "9"], 5, true
      include_examples "legal move check", "X", "Y", "X", "player1", ["1", "X", "Y", "X", "Y", "X", "Y", "8", "9"], 3, true
      include_examples "legal move check", "X", "Y", "X", "player1", ["1", "X", "Y", "X", "Y", "X", "Y", "X", "Y"], 1, true
      
      include_examples "legal move check", "X", "Y", "X", "player1", ["X", "2", "3", "4", "5", "6", "7", "8", "9"], 8, false
      include_examples "legal move check", "X", "Y", "X", "player1", ["X", "X", "Y", "4", "5", "6", "7", "8", "9"], 6, false
      include_examples "legal move check", "X", "Y", "X", "player1", ["X", "X", "Y", "4", "5", "6", "7", "Y", "X"], 4, false
      include_examples "legal move check", "X", "Y", "X", "player1", ["X", "X", "Y", "X", "5", "6", "Y", "Y", "X"], 2, false
      include_examples "legal move check", "X", "Y", "X", "player1", ["X", "X", "Y", "4", "5", "6", "7", "Y", "X"], 0, false
  end
end