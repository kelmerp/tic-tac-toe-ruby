require 'spec_helper'

describe ProceduralAI do
  before :each do
    @ai = ProceduralAI.new
    @winning_lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
    [2, 5, 8], [0, 4, 8], [2, 4, 6]] 
  end

  describe "#winning_move" do
    before :each do
      @board = double(:content => ["x","x","","","","","","",""])
      @player1_mark = 'x'
    end

    it "makes a winning move (3 in a row) for the computer player" do
      move = @ai.winning_move(@winning_lines, @board, @player1_mark)
      expect(move).to eq 2
    end
  end

  describe "#blocking_move" do
    before :each do
      @board = double(:content => ["o","o","","","","","","",""])
      @player2_mark = 'o'
    end

    it "blocks human player from winning" do
      move = @ai.blocking_move(@winning_lines, @board, @player2_mark)
      expect(move).to eq 2
    end
  end

  describe "#best_move" do
    context "when blocking 'L'-shaped traps" do
      before :each do
        @current_player = double(:mark => 'o')
        @opponent_player = double(:mark => 'x')
        @first_player = @opponent_player
      end

      it "blocks the trap when human player takes position 0 and 7" do
        @board = double(:content => ["x","","","","o","","","x",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 6
      end

      it "blocks the trap when human player takes position 0 and 5" do
        @board = double(:content => ["x","","","","o","x","","",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 2
      end

      it "blocks the trap when human player takes position 1 and 6" do
        @board = double(:content => ["","x","","","o","","x","",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 0
      end

      it "blocks the trap when human player takes position 1 and 8" do
        @board = double(:content => ["","x","","","o","","","","x"])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 2
      end

      it "blocks the trap when human player takes position 2 and 3" do
        @board = double(:content => ["","","x","x","o","","","",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 0
      end

      it "blocks the trap when human player takes position 2 and 7" do
        @board = double(:content => ["","","x","","o","","","x",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 8
      end

      it "blocks the trap when human player takes position 3 and 8" do
        @board = double(:content => ["","","","x","o","","","","x"])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 6
      end

      it "blocks the trap when human player takes position 5 and 6" do
        @board = double(:content => ["","","","","o","x","x","",""])
        move = @ai.best_move(@winning_lines, @board, @current_player, 
                              @opponent_player, @first_player)
        expect(move).to eq 8
      end
    end
  end
end