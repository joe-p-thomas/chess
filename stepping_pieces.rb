module SteppingPieces
  KNIGHT_MOVES = {
    up_right: [-2, 1],
    up_left: [-2, -1],
    left_up: [-1, -2],
    left_down: [1, -2],
    down_left: [2, -1],
    down_right: [2, 1],
    right_down: [1, 2],
    right_up: [-1, 2]
  }

  KING_MOVES = {
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
    if self.move_dir.include?(:left)
      possible_moves = []
      directions = self.move_dir

      directions.each do |direction|
        row_change = KING_MOVES[direction][0]
        col_change = KING_MOVES[direction][1]
        added_pos = @position.dup
        added_pos = [added_pos[0] + row_change, added_pos[1] + col_change]

        if @board.in_bounds?(added_pos) && @board[added_pos].color != @color
          possible_moves << added_pos
        end
      end

    else
      possible_moves = []
      directions = self.move_dir

      directions.each do |direction|
        row_change = KNIGHT_MOVES[direction][0]
        col_change = KNIGHT_MOVES[direction][1]
        added_pos = @position.dup
        added_pos = [added_pos[0] + row_change, added_pos[1] + col_change]

        if @board.in_bounds?(added_pos) && @board[added_pos].color != @color
          possible_moves << added_pos
        end
      end
    end

    possible_moves
  end


end
