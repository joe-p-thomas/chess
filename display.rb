require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
    @selected_pos = []
  end

  def render
    @board.grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        if @cursor.cursor_pos == [idx, idx2]
          print "C "
        elsif @board[[idx, idx2]].color.nil?
          print "0 "
        elsif @board.selected == [idx, idx2]
          print "S ".colorize(:yellow)
        else
          if tile.color == "black"
            print tile.display.colorize(:red) + " "
          elsif tile.color == "white"
            print tile.display.colorize(:green) + " "
          end
        end
      end
      puts ""
    end
  end

  def render_loop
    input = nil

    while @selected_pos.count < 2
      input = @cursor.get_input
      if !input.nil?
        if @selected_pos.include?(input)
          @selected_pos = []
        else
          @selected_pos << input
        end
      end
      system("clear")
      render
    end

    @board.move_piece(@selected_pos.first, @selected_pos.last)
    @selected_pos = []
    render_loop
  end


end

board = Board.new
board.populate
display = Display.new(board)
# display.render
display.render_loop
