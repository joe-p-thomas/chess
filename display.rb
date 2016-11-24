require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
    @selected_pos = []
    @current_player = :white
  end

  def render
    @board.grid.each_with_index do |row, idx|
      row.each_with_index do |tile, idx2|
        background_color = idx % 2 == idx2 % 2 ? :light_white : :default
        if @cursor.cursor_pos == [idx, idx2] || @board.selected == [idx, idx2]
          print tile.display.colorize(background: :light_green)
        else
          print tile.display.colorize(background: background_color)
        end
      end
      puts ""
    end
  end

  def render_loop
    input = nil
    system("clear")
    render
    while @selected_pos.count < 2
      input = @cursor.get_input
      if !input.nil?
        if @selected_pos.include?(input)
          @selected_pos = []
        elsif @board[input].color == @current_player || @board[input].color == nil
          @selected_pos << input
        end
      end
      system("clear")
      render
    end

    @board.move_piece(@selected_pos.first, @selected_pos.last)
    @selected_pos = []
    switch_current_player
    render_loop
  end

  def switch_current_player
    @current_player = @current_player == :white ? :black : :white
  end


end

board = Board.new
board.populate
display = Display.new(board)
# display.render
display.render_loop
