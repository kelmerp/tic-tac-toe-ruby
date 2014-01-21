class AI
  def self.generate(ai_level = nil)
    ProceduralAI.new
  end
end

class ProceduralAI
  # def get_move(winning_lines, board, computer_mark, human_mark, first_player)
  def get_move(game_state)
    next_move = false

    if next_move = winning_move(game_state.winning_lines, game_state.board, game_state.current_player.mark) #returns index of winning move or false
      next_move
    elsif next_move = blocking_move(game_state.winning_lines, game_state.board, game_state.current_player_opponent.mark) #returns index of blocking move or false
      next_move
    else
      best_move(game_state.winning_lines, game_state.board, game_state.current_player, game_state.current_player_opponent, game_state.first_player)
    end
  end

  def winning_move(winning_lines, board, current_player_mark)
    winning_lines.each do |a, b, c|
      if board.content[a] == current_player_mark && board.content[b] == current_player_mark && board.content[c] == ""
        return c
      elsif board.content[b] == current_player_mark && board.content[c] == current_player_mark && board.content[a] == ""
        return a
      elsif board.content[a] == current_player_mark && board.content[c] == current_player_mark && board.content[b] == ""
        return b
      end
    end

    false
  end

  def blocking_move(winning_lines, board, opponent_mark)
    winning_lines.each do |a, b, c|
      if board.content[a] == opponent_mark && board.content[b] == opponent_mark && board.content[c] == ""
        return c
      elsif board.content[b] == opponent_mark && board.content[c] == opponent_mark && board.content[a] == ""
        return a
      elsif board.content[a] == opponent_mark && board.content[c] == opponent_mark && board.content[b] == ""
        return b
      end
    end

    false
  end

  def best_move(winning_lines, board, current_player, opponent_player, first_player)
    c = current_player.mark
    o = opponent_player.mark

    if first_player == current_player && board.content[0] == ""
      0
    elsif first_player == opponent_player  && board.content[4] == ""
      4
    elsif first_player == current_player && board.content[4] == ""
      4
    elsif board.content[0] == c && board.content[4] == o && board.content[8] == ""
      8
    elsif board.content[0] == o && board.content[8] == o && board.content[1] == ""
      1
    elsif board.content[2] == o && board.content[6] == o && board.content[1] == ""
      1
    elsif board.content[0] == c && board.content[4] == c && board.content[1] == o && board.content[6] == ""
      6
    elsif board.content[4] == o && board.content[8] == o && board.content[2] == ""
      2
    elsif board.content[0] == o && board.content[7] == o && board.content[6] == ""
      6    
    elsif board.content[6] == o && board.content[5] == o && board.content[8] == ""
      8    
    elsif board.content[8] == o && board.content[1] == o && board.content[2] == ""
      2    
    elsif board.content[2] == o && board.content[3] == o && board.content[0] == ""
      0
    elsif board.content[1] == o && board.content[6] == o && board.content[0] == ""
      0 
    elsif board.content[3] == o && board.content[8] == o && board.content[6] == ""
      6   
    elsif board.content[7] == o && board.content[2] == o && board.content[8] == ""
      8
    elsif board.content[5] == o && board.content[0] == o && board.content[2] == ""
      2
    else
      board.content.index("")
    end
  end
end
