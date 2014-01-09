
require 'spec_helper'
require 'stringio'

describe UI do
  before(:each) do
    @original_stdout = $stdout
    $stdout = @fake = StringIO.new
  end

  after(:each) do
    $stdout = @original_stdout
  end

  describe '.show_board' do
    context "with a 3 X 3 board" do
      it "should output a 3 X 3 board" do
        board = double("board")
        board.stub(:content) { Array.new(9, "") }
        board.stub(:size) { 3 }
        UI.show_board(board)
        expect(@fake.string).to eq "0|1|2\n3|4|5\n6|7|8\n"
      end
    end

    context "with a 4 X 4 board" do
      it "should output a 4 X 4 board" do
        board = double("board")
        board.stub(:content) { Array.new(16, "") }
        board.stub(:size) { 4 }
        UI.show_board(board)
        expect(@fake.string).to eq "0|1|2|3\n4|5|6|7\n8|9|10|11\n12|13|14|15\n"
      end
    end
  end
end