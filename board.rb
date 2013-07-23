require './pieces.rb'
require 'colorize'
class Board
  def initialize
    @grid = (0...8).map { |row| [" "] * 8 }
    populate
  end

  def populate
    @grid[7] = back_line(:white)
    @grid[6] = Array.new(8).map { |place| Pawn.new(:white) }
    @grid[0] = back_line(:black)
    @grid[1] = Array.new(8).map { |place| Pawn.new(:black) }
  end


  def back_line(color)
    back_line = [Rook.new(color),
                 Knight.new(color),
                 Bishop.new(color),
                 Queen.new(color),
                 King.new(color),
                 Bishop.new(color),
                 Knight.new(color),
                 Rook.new(color)]
    back_line[3], back_line[4] = back_line[4], back_line[3] if color == :black
    back_line
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def to_s
    ret_str = "#{"-" * 33}\n"
    @grid.each do |row|
      ret_str << "| #{row.map(&:to_s).join(" | ")} |\n"
      ret_str << "#{"-" * 33}\n"
    end

    ret_str
  end
end