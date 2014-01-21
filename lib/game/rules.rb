require_relative 'board'

class Rules
  attr_reader :board, :num_needed_to_win
  
  def initialize(args = {})
    @board = args[:board]
    @num_needed_to_win = @board.size
    @winning_lines = get_winning_lines
  end

  def get_winning_lines
    board.get_lines
  end
  
  def winner?(player1, player2)
    [player1.mark, player2.mark].each do |mark|
      @winning_lines.each do |line|
        counter = 0
        line.each do |position|
          counter += 1 if board.content[position] == mark
          return true if counter == board.size
        end
      end
    end

    false
  end

  def get_winner(player1, player2)
    [player1.mark, player2.mark].each do |mark|
      @winning_lines.each do |line|
        counter = 0
        line.each do |position|
          counter += 1 if board.content[position] == mark
          return mark if counter == board.size
        end
      end
    end

    nil
  end
end