require_relative 'piece'
require_relative 'sliding_pieces'

class Queen < Piece
  include SlidingPieces

  def initialize(value, color, position,board)
    super
  end

  def move_dir
    [:up, :down, :left, :right,
     :left_up, :left_down, :right_up, :right_down]
  end


end
