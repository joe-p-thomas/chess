require 'byebug'
class Piece

  attr_accessor :position
  attr_reader :value, :color, :board

  def initialize(value = nil, color = nil, position = nil, board = nil)
    @value = value
    @color = color
    @position = position
    @board = board
  end

  def display
    @value[0]
  end

  def valid_move?(end_pos)
    moves.include?(end_pos)
  end
end
