require_relative 'piece'
require_relative 'sliding_pieces'

class Bishop < Piece
  include SlidingPieces

  def initialize(*args)
    super
  end

  def display
    if @color == :white
      " ♗ "
    else
      " ♝ "
    end
  end

  def move_dir
    [:left_up, :left_down, :right_up, :right_down]
  end

end
