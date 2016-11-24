require_relative 'piece'

class Pawn < Piece

  def initialize(*args)
    super
  end

  def display
    if @color == :white
      " ♙ "
    else
      " ♟ "
    end
  end

  MOVES = {up_up: [-2, 0],
           up: [-1,0],
           up_left: [-1,-1],
           up_right: [-1, 1]}



  def moves
    if (@position[0] != 1 && @color == :black) ||
       (@position[0] != 6 && @color == :white)
      MOVES.delete_if {|k,v| v == [-2,0]}
    end
    possible_moves = []
    MOVES.each do |direction,arr|
      row_change = arr[0]
      col_change = arr[1]
      row_change = -1 * row_change if @color == :black

      added_pos = @position.dup

      added_pos = [added_pos[0] + row_change, added_pos[1] + col_change]
      if @board.in_bounds?(added_pos) && @board[added_pos].color != @color
        if col_change != 0
          possible_moves << added_pos if @board[added_pos].color != nil
        else col_change == 0
          possible_moves << added_pos if @board[added_pos].color.nil?
        end
      end
    end

    possible_moves
  end
end
