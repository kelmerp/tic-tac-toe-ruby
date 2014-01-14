require 'spec_helper'

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#new" do
    context "with a default board size of 3" do
      it "creates a Game object" do
        expect(@game).to be_an_instance_of Game
      end

      it "should have an empty board" do
        expect(@game.board.content).to eq(["","","","","","","","",""])
      end

      it "should have a current player" do
        expect(@game.current_player).to be_a Player
      end
    end    

    context "with a board size of 4" do
      it "should have an empty 4 X 4 board" do
        @game = Game.new(:board_size => 4)
        expect(@game.board.content).to eq(["","","","","","","","","","","","","","","",""])
      end
    end
  end

  describe "#over?" do
    it "should be true when all 9 squares are filled" do
      @game.board.content = ["o","o","x","x","x","o","o","x","x"]
      expect(@game.over?).to be_true
    end

    it "should be true when a player wins" do
      @game.board.content = ["o","","x","o","x","","o","x",""]
      expect(@game.over?).to be_true
    end

    it "should be false if the board isn't full and no one has won" do
      expect(@game.over?).to be_false
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

  