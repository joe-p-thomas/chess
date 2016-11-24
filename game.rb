require_relative 'display'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(board)
  end

  def play
    until game_over?
      take_turn
    end
  end

  def take_turn
    
  end

  def game_over?
    @board.checkmate?(:black) || @board.checkmate(:white)
  end

end
