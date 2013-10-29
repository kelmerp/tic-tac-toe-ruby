require 'spec_helper'

describe TicTacToe do
  before :each do
    @game = TicTacToe.new
  end

  describe "#new" do
    it "creates a TicTacToe object" do
      expect(@game).to be_an_instance_of TicTacToe
    end
  end
end