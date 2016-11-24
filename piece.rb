require 'byebug'
class Piece

  attr_accessor :position
  attr_reader :value, :color, :board

  def initialize(color = nil, position = nil, board = nil)
    @color = color
    @position = position
    @board = board
  end

  def display
    " X "
  end

  def valid_moves #returns all moves that prevents check
    possible_moves = self.moves
    non_check_moves = []
    possible_moves.each do |possible_move|
      non_check_moves << possible_move unless move_into_check?(possible_move)
    end
    non_check_moves
  end

  def move_into_check?(end_pos)
    board_copy = @board.board_dup
    board_copy.move_piece!(@position, end_pos)
    board_copy.in_check?(@color)
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
