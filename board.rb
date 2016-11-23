require_relative 'piece_requires.rb'
require_relative 'nullpiece'
require 'byebug'
class Board

  attr_accessor :selected
  attr_reader :grid
  def initialize
    @selected = nil
    @grid = Array.new(8) { Array.new(8) }
  end

  def move_piece(start_pos, end_pos)
    if @grid[start_pos[0]][start_pos[1]].is_a?(NullPiece)
      raise "There is no piece at #{start_pos}"
    elsif @grid[start_pos[0]][start_pos[1]].valid_move?(end_pos)
      @grid[end_pos[0]][end_pos[1]] = @grid[start_pos[0]][start_pos[1]]
      @grid[end_pos[0]][end_pos[1]].position = [end_pos[0],end_pos[1]]
      @grid[start_pos[0]][start_pos[1]] = NullPiece.instance
    else
      # raise "invalid move"
    end
  end

  def move_piece!(start_pos, end_pos)
    @grid[end_pos[0]][end_pos[1]] = @grid[start_pos[0]][start_pos[1]]
    @grid[start_pos[0]][start_pos[1]] = NullPiece.instance
  end

  def populate
    @grid.each_with_index do |row, idx|
      color = idx < 3 ? "black"  : "white"
      row.each_with_index do |tile, idx2|
        if idx == 0
          if idx2 == 0 || idx2 == 7
            @grid[idx][idx2] = Rook.new("rook", color, [idx, idx2], self)
          elsif idx2 == 1 || idx2 == 6
            @grid[idx][idx2] = Knight.new("knight", color, [idx, idx2], self)
          elsif idx2 == 2 || idx2 == 5
            @grid[idx][idx2] = Bishop.new("bishop", color, [idx, idx2], self)
          elsif idx2 == 3
            @grid[idx][idx2] = King.new("King", color, [idx, idx2], self)
          else
            @grid[idx][idx2] = Queen.new("Queen", color, [idx, idx2], self) ####
          end
        elsif idx == 1
          @grid[idx][idx2] = Pawn.new("pawn", color, [idx, idx2], self)
        # elsif idx == 6
        #   @grid[idx][idx2] = Pawn.new("pawn", "white", [idx, idx2], self)
        # elsif idx == 7
        #   if idx2 == 0 || idx2 == 7
        #     @grid[idx][idx2] = Rook.new("rook", "white", [idx, idx2], self)
        #   elsif idx2 == 1 || idx2 == 6
        #     @grid[idx][idx2] = Knight.new("knight", "white", [idx, idx2], self)
        #   elsif idx2 == 2 || idx2 == 5
        #     @grid[idx][idx2] = Bishop.new("bishop", "white", [idx, idx2], self)
        #   elsif idx2 == 3
        #     @grid[idx][idx2] = King.new("King", "white", [idx, idx2], self)
        #   else
        #     @grid[idx][idx2] = Queen.new("Queen", "white", [idx, idx2], self)
        #   end
        else
          @grid[idx][idx2] = NullPiece.instance
        end
      end
    end
  end

  def in_bounds?(pos)
    row, col = pos[0], pos[1]
    if row.between?(0, 7) && col.between?(0, 7)
      return true
    end
    false
  end

  def board_dup
    copy = Board.new
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        if tile.is_a?(NullPiece)
          copy[[idx,idx2]] = NullPiece.instance
        else
          copy[[idx, idx2]] = tile.class.new(tile.value,tile.color,[idx,idx2],copy)
        end
      end
    end
    copy
  end

  def in_check?(color)
    opposite_color = (color == "white") ? "black" : "white"
    opposite_pieces = []
    king_pos = nil
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        opposite_pieces << tile if tile.color == opposite_color
        if tile.color == color && tile.value == "King"
          king_pos = [idx, idx2]
        end
      end
    end

    opposite_pieces.each do |piece|
      return true if piece.moves.include?(king_pos)
    end

    false
  end

  def checkmate?(color)
    pieces = []
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        pieces << tile if tile.color == color
      end
    end
    pieces.all? {|piece| piece.valid_moves.empty?}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  king = King.new("King", "white", [3, 1], board)
  # queen = Queen.new("Queen", "black", [2, 0], board)
  queen = Queen.new("Queen", "black", [3, 0], board)
  # queen = Queen.new("Queen", "black", [4, 0], board)

  board[[3, 1]] = king
  # board[[2, 0]] = queen
  board[[3, 0]] = queen
  # board[[4, 0]] = queen
  board[[7, 3]] = queen
  p king.valid_moves
  p board.in_check?("white")
  p board.checkmate?("white")
end
