require_relative 'piece'
require_relative 'stepping_pieces'

class Knight < Piece
  include SteppingPieces

  def initialize(*args)
    super(*args)
  end

  def move_dir
    [:up_right, :up_left, :left_up, :left_down, :down_left, :down_right,
     :right_down, :right_up]
  end

end
