require 'spec_helper'
require 'stringio'

describe "#show" do
  before :each do
    @game = Game.new
  end

  it "should output the board" do
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    @game.board.show
    $stdout = original_stdout
    expect(fake.string).to include "|"
  end
end