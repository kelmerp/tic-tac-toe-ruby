require 'spec_helper'

describe Rules do
  before(:each) do
    @board = Board.new
    @rules = Rules.new(:board => @board)
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
end