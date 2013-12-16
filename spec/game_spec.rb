require 'spec_helper'
require 'stringio'

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

  describe "#print_board" do

    it "should output the board" do
      original_stdout = $stdout
      $stdout = fake = StringIO.new
      @game.print_board
      $stdout = original_stdout
      expect(fake.string).to include "|"
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

  describe "#winning_move" do
    it "makes a winning move (3 in a row) for the computer player" do
      @game.board = ["x","x","","","","","","",""]
      @game.stub(:first_player => :computer)
      @game.current_player = :computer
      @game.stub(:computer_mark => "x")
      expect(@game.winning_move).to eq 2
    end
  end
end