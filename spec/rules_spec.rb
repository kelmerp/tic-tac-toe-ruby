require 'spec_helper'

describe Rules do
  before(:each) do
    @board = Board.new
    @rules = Rules.new(:board => @board)
  end

  describe "#get_winning_lines" do
    it "should return an array of winning lines with 8 'lines'" do
      expect(@rules.get_winning_lines.size).to eq 8
    end
  end

  describe "#winner?" do
    it "should return true if there is a winner" do
      @board.content = ["o","","x","o","x","","o","x",""]
      expect(@rules.winner?).to be_true
    end

    it "should return false if there is no winner" do
      expect(@rules.winner?).to be_false
    end
  end

  describe "#get_winner" do
    context "when 'x' is the winner" do
      it "should return 'x'" do
        @board.content = ["x","x","x","","","","","",""]
        expect(@rules.get_winner).to eq "x"
      end
    end

    context "when 'o' is the winner" do
      it "should return 'x'" do
        @board.content = ["o","o","o","","","","","",""]
        expect(@rules.get_winner).to eq "o"
      end
    end

    context "when there is no winner" do
      it "should return nil" do
        @board.content = ["","","","","","","","",""]
        expect(@rules.get_winner).to be_nil
      end
    end
  end
end