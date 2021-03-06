class Board
  attr_accessor :content
  attr_reader :lines, :size

  def initialize(args = {})
    @size = args[:board_size] || 3
    @content = Array.new(@size ** 2, "")
    @lines = get_lines
  end

  def get_lines
    get_rows + get_columns + get_diagonals
  end

  def get_rows
    rows = []
    numbers = (0..(@size ** 2 - 1)).to_a
    numbers.each_slice(@size) { |line| rows << line }

    rows
  end

  def get_columns
    get_rows.transpose
  end

  def get_diagonals
    diagonals = []
    down_right_diagonal = []
    0.upto(@size - 1) do |num|
      down_right_diagonal << num * (@size + 1)
    end

    diagonals << down_right_diagonal

    down_left_diagonal = []
    0.upto(@size - 1) do |num|
      down_left_diagonal << (num + 1) * (@size - 1)
    end

    diagonals << down_left_diagonal

    diagonals
  end

  def full?
    @content.include?("") == false
  end

  def mark(index, player_mark)
    @content[index] = player_mark
  end

  def empty?
    @content == Array.new(@size * @size, "")
  end
end