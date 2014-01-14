class ProceduralAI
  def get_move(winning_lines, board, computer_mark, human_mark, first_player)
    next_move = false

    if next_move = winning_move(winning_lines, board, computer_mark) #returns index of winning move or false
      next_move
    elsif next_move = blocking_move(winning_lines, board, human_mark) #returns index of blocking move or false
      next_move
    else
      best_move(winning_lines, board, computer_mark, human_mark, first_player)
    end
  end

  def winning_move(winning_lines, board, computer_mark)
    winning_lines.each do |a, b, c|
      if board.content[a] == computer_mark && board.content[b] == computer_mark && board.content[c] == ""
        return c
      elsif board.content[b] == computer_mark && board.content[c] == computer_mark && board.content[a] == ""
        return a
      elsif board.content[a] == computer_mark && board.content[c] == computer_mark && board.content[b] == ""
        return b
      end
    end

    false
  end

  def blocking_move(winning_lines, board, human_mark)
    winning_lines.each do |a, b, c|
      if board.content[a] == human_mark && board.content[b] == human_mark && board.content[c] == ""
        return c
      elsif board.content[b] == human_mark && board.content[c] == human_mark && board.content[a] == ""
        return a
      elsif board.content[a] == human_mark && board.content[c] == human_mark && board.content[b] == ""
        return b
      end
    end

    false
  end

  def best_move(winning_lines, board, computer_mark, human_mark, first_player)
    h = human_mark
    c = computer_mark

    if first_player.type == :computer && board.content[0] == ""
      0
    elsif first_player.type == :human  && board.content[4] == ""
      4
    elsif first_player.type == :computer && board.content[4] == ""
      4
    elsif board.content[0] == c && board.content[4] == h && board.content[8] == ""
      8
    elsif board.content[0] == h && board.content[8] == h && board.content[1] == ""
      1
    elsif board.content[2] == h && board.content[6] == h && board.content[1] == ""
      1
    elsif board.content[0] == c && board.content[4] == c && board.content[1] == h && board.content[6] == ""
      6
    elsif board.content[4] == h && board.content[8] == h && board.content[2] == ""
      2
    elsif board.content[0] == h && board.content[7] == h && board.content[6] == ""
      6    
    elsif board.content[6] == h && board.content[5] == h && board.content[8] == ""
      8    
    elsif board.content[8] == h && board.content[1] == h && board.content[2] == ""
      2    
    elsif board.content[2] == h && board.content[3] == h && board.content[0] == ""
      0
    elsif board.content[1] == h && board.content[6] == h && board.content[0] == ""
      0 
    elsif board.content[3] == h && board.content[8] == h && board.content[6] == ""
      6   
    elsif board.content[7] == h && board.content[2] == h && board.content[8] == ""
      8
    elsif board.content[5] == h && board.content[0] == h && board.content[2] == ""
      2
    else
      board.content.index("")
    end
  end
end
