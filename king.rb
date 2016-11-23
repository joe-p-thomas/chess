require_relative 'piece'
require_relative 'stepping_pieces'

class King < Piece
  include SteppingPieces

  def initialize(*args)
    super
  end

  def move_dir
    [:up, :down, :left, :right,
     :left_up, :left_down, :right_up, :right_down]
  end

end
