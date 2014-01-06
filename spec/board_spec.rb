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
end