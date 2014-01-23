require 'spec_helper'

describe ComputerPlayer do
  describe "#move" do
    it 'marks the board' do
      @computer_player = ComputerPlayer.new(:ai_level => 'e', :mark => 'x')
      @board = Board.new
      @computer_player.move(:board => @board, :current_player => @computer_player)
      expect(@board.content).to include "x"
    end
  end
end