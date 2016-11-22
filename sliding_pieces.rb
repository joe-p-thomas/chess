module SlidingPieces
  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    left_up: [-1, -1],
    right_up: [-1, 1],
    left_down: [1, -1],
    right_down: [1, 1]
  }

  def moves
    possible_moves = []
    directions = self.move_dir

    directions.each do |direction|
      row_change = MOVES[direction][0]
      col_change = MOVES[direction][1]
      added_pos = @position.dup
      added_pos = [added_pos[0] + row_change, added_pos[1] + col_change]
      while @board.in_bounds?(added_pos) && @board[added_pos].is_a?(NullPiece)
        possible_moves << added_pos
        added_pos = [added_pos[0] + row_change, added_pos[1] + col_change]
      end

      if @board.in_bounds?(added_pos) && @board[added_pos].color != @color
        possible_moves << added_pos
      end

    end

    possible_moves
  end

end
