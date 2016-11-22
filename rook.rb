require_relative 'piece'
require_relative 'sliding_pieces'

class Rook < Piece
  include SlidingPieces

  def initialize(*args)
    super(*args)
  end

  def move_dir
    [:up, :down, :left, :right]
  end


end
