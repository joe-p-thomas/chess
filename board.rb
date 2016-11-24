require_relative 'piece_requires.rb'

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
      color = idx < 3 ? :black : :white
      row.each_with_index do |tile, idx2|
        if idx == 0 || idx == 7
          if idx2 == 0 || idx2 == 7
            @grid[idx][idx2] = Rook.new(color, [idx, idx2], self)
          elsif idx2 == 1 || idx2 == 6
            @grid[idx][idx2] = Knight.new(color, [idx, idx2], self)
          elsif idx2 == 2 || idx2 == 5
            @grid[idx][idx2] = Bishop.new(color, [idx, idx2], self)
          elsif idx2 == 3
            @grid[idx][idx2] = King.new(color, [idx, idx2], self)
          else
            @grid[idx][idx2] = Queen.new(color, [idx, idx2], self) ####
          end
        elsif idx == 1 || idx == 6
          @grid[idx][idx2] = Pawn.new(color, [idx, idx2], self)
        else
          @grid[idx][idx2] = NullPiece.instance
        end
      end
    end
  end

  def in_bounds?(pos)
    row, col = pos
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
          copy[[idx, idx2]] = NullPiece.instance
        else
          copy[[idx, idx2]] =
            tile.class.new(tile.color, [idx, idx2], copy)
        end
      end
    end
    copy
  end

  def in_check?(color)
    opposite_color = color == :white ? :black : :white
    opposite_pieces = []
    king_pos = nil
    @grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        opposite_pieces << tile if tile.color == opposite_color
        if tile.color == color && tile.is_a?(King)
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
    @grid.each do |row|
      row.each do |tile|
        pieces << tile if tile.color == color
      end
    end
    pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

end
