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
        expect(@game.current_player).to be_a Symbol
      end
    end    

    context "with a board size of 4" do
      it "should have an empty 4 X 4 board" do
        @game = Game.new(:board_size => 4)
        expect(@game.board.content).to eq(["","","","","","","","","","","","","","","",""])
      end
    end
  end

  describe "#get_random_player" do
    it "should return a player" do
      expect(@game.get_random_player).to be_a Symbol
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

  describe "#winner?" do
    it "should return true if there is a winner" do
      @game.board.content = ["o","","x","o","x","","o","x",""]
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
    before :each do
      @game.stub(:first_player => :computer)
      @game.current_player = :computer
      @game.stub(:computer_mark => "x")
      @game.stub(:human_mark => "0")
    end

    it "makes a winning move (3 in a row) for the computer player" do
      @game.board.content = ["x","x","","","","","","",""]
      expect(@game.winning_move).to eq 2
    end
  end

  describe "#blocking_move" do
    it "blocks human player from winning" do
      @game.board.content = ["x","x","","","","","","",""]
      @game.stub(:first_player => :human)
      @game.current_player = :computer
      @game.stub(:computer_mark => "o")
      @game.stub(:human_mark => "x")
      expect(@game.blocking_move).to eq 2
    end
  end

  describe "#best_move" do
    context "when blocking 'L'-shaped traps" do

      before :each do
        @game.stub(:first_player => :human)
        @game.current_player = :computer
        @game.stub(:computer_mark => "o")
        @game.stub(:human_mark => "x")
      end

      it "blocks the trap when human player takes position 0 and 7" do
        @game.board.content = ["x","","","","o","","","x",""]
        expect(@game.best_move).to eq 6
      end

      it "blocks the trap when human player takes position 0 and 5" do
        @game.board.content = ["x","","","","o","x","","",""]
        expect(@game.best_move).to eq 2
      end

      it "blocks the trap when human player takes position 1 and 6" do
        @game.board.content = ["","x","","","o","","x","",""]
        expect(@game.best_move).to eq 0
      end
          
      it "blocks the trap when human player takes position 1 and 8" do
        @game.board.content = ["","x","","","o","","","","x"]
        expect(@game.best_move).to eq 2
      end
          
      it "blocks the trap when human player takes position 2 and 3" do
        @game.board.content = ["","","x","x","o","","","",""]
        expect(@game.best_move).to eq 0
      end
          
      it "blocks the trap when human player takes position 2 and 7" do
        @game.board.content = ["","","x","","o","","","x",""]
        expect(@game.best_move).to eq 8
      end
          
      it "blocks the trap when human player takes position 3 and 8" do
        @game.board.content = ["","","","x","o","","","","x"]
        expect(@game.best_move).to eq 6
      end
          
      it "blocks the trap when human player takes position 5 and 6" do
        @game.board.content = ["","","","","o","x","x","",""]
        expect(@game.best_move).to eq 8
      end
    end
  end
end