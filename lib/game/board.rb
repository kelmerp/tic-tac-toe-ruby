class Board
  attr_accessor :content

  def initialize
    @content = ["","","","","","","","",""]
  end

  def full?
    @content.include?("") == false
  end

  def show
    0.upto(8) do |n|
      if content[n] == "x" || content[n] == "o"
        print "#{content[n]}"
      else
        print "#{n}"
      end

      if n == 2 || n == 5 || n == 8
        print "\n"
      else
        print "|"
      end
    end
  end

  def mark(index, player_mark)
    if @content[index] != ""
      false
    else
      @content[index] = player_mark
    end
  end

  def empty?
    @content == ["","","","","","","","",""]
  end
end