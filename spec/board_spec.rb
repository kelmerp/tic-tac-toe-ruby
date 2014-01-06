require 'spec_helper'
require 'stringio'

describe Board do
  before :each do
    @board = Board.new
  end

  describe '#show' do
    it "should output the board" do
      original_stdout = $stdout
      $stdout = fake = StringIO.new
      @board.show
      $stdout = original_stdout
      expect(fake.string).to include "|"
    end
  end

  describe '#full?' do
    it "when the board is full should respond true" do
      @board.content = ["x","o","x","x","o","x","o","x","x"]
      expect(@board.full?).to be true
    end
  end

  describe '#mark' do
    it 'marks the board at the given index' do
      @board.mark(0, "x")
      expect(@board.content).to eq ["x","","","","","","","",""]
    end
  end

  describe '#empty?' do
    it 'with an empty board should be true' do
      expect(@board.empty?).to be true
    end
  end
end