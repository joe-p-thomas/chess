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

  def valid_moves
    possible_moves = self.moves
    possible_moves.each do |possible_move|
      self.move_into_check?(possible_move)
    end
  end

  def move_into_check?(end_pos)
    board_copy = @board.board_dup
    board_copy.move_piece(@position, end_pos)
    board_copy.in_check?(@color)
  end

  def valid_move?(end_pos)
    moves.include?(end_pos)
  end
end
