require 'spec_helper'

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#new" do
    it "creates a Game object" do
      expect(@game).to be_an_instance_of Game
    end

    it "should initialize an empty board" do
      expect(@game.board).to eq(["","","","","","","","",""])
    end

    it "should have a current player" do
      expect(@game.current_player).to be_a Symbol
    end
  end

  describe "#get_random_player" do
    it "should return a player" do
      expect(@game.get_random_player).to be_a Symbol
    end
  end

  describe "#to_s" do
    it "should output the board" do
      expect(@game.to_s).to include "|"
    end
  end

  describe "#over?" do
    it "should be true when all 9 squares are filled" do
      @game.board = ["o","o","x","x","x","o","o","x","x"]
      expect(@game.over?).to be_true
    end

    it "should be true when a player wins" do
      @game.board = ["o","","x","o","x","","o","x",""]
      expect(@game.over?).to be_true
    end

    it "should be false if the board isn't full and no one has won" do
      expect(@game.over?).to be_false
    end
  end

  describe "#winner?" do
    it "should return true if there is a winner" do
      @game.board = ["o","","x","o","x","","o","x",""]
      expect(@game.winner?).to be_true
    end

    it "should return false if there is no winner" do
      expect(@game.winner?).to be_false
    end
  end

  describe "#get_computer_mark" do
    it "should return an x or o" do
      expect(@game.get_computer_mark).to be_a String
    end
  end

  describe "#computer_move" do
    it "plays a turn for the computer player" do
      @game.computer_move
      expect(@game.board.empty?).to be_false
    end
  end
end