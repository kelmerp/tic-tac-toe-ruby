require 'spec_helper'
require 'stringio'

describe Board do
  before :each do
    @board = Board.new
  end

  describe "#get_lines" do
    context "with a 3 X 3 board" do
      it "returns an array containing the 8 lines on the board" do
        expect(@board.get_lines.size).to eq 8
      end
    end    

    context "with a 4 X 4 board" do
      it "returns an array containing the 10 lines on the board" do
        @board = Board.new(:board_size => 4)
        expect(@board.get_lines.size).to eq 10
      end
    end
  end

  describe '#show' do
    context "with a 3 X 3 board" do
      it "should output a 3 X 3 board" do
        original_stdout = $stdout
        $stdout = fake = StringIO.new
        @board.show
        $stdout = original_stdout
        expect(fake.string).to eq "0|1|2\n3|4|5\n6|7|8\n"
      end
    end

    context "with a 4 X 4 board" do
      it "should output a 4 X 4 board" do
        original_stdout = $stdout
        $stdout = fake = StringIO.new
        @board = Board.new(:board_size => 4)
        @board.show
        $stdout = original_stdout
        expect(fake.string).to eq "0|1|2|3\n4|5|6|7\n8|9|10|11\n12|13|14|15\n"
      end
    end
  end

  describe '#full?' do
    it "when the board is full should respond true" do
      @board.content = ["x","o","x","x","o","x","o","x","x"]
      expect(@board.full?).to be true
    end    

    it "when the board is not full should respond false" do
      @board.content = ["x","o","x","x","o","x","o","x",""]
      expect(@board.full?).to be false
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

    it 'with a non-empty board should be false' do
      @board.content = ["x","","","","","","","",""]
      expect(@board.empty?).to be false
    end
  end
end