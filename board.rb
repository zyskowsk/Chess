load './pieces.rb'
load './pawn.rb'
load './knight.rb'
load './rook.rb'
load './bishop.rb'
load './queen.rb'
load './king.rb'
require 'colorize'

class Board
  def initialize
    @grid = (0...8).map { |row| [" "] * 8 }
    populate
  end

  def populate
    @grid[7] = back_line(:white, 7)
    @grid[6] = Array.new(8).map.with_index do |_, idx|
      Pawn.new(:white, self, [6, idx])
    end
    @grid[0] = back_line(:blue, 0)
    @grid[1] = Array.new(8).map.with_index do |_, idx|
      Pawn.new(:blue, self, [1, idx])
    end
  end


  def back_line(color, row)
    back_line = [Rook.new(color, self, [row, 0]),
                 Knight.new(color, self, [row, 1]),
                 Bishop.new(color, self, [row, 2]),
                 Queen.new(color, self, [row, 3]),
                 King.new(color, self, [row, 4]),
                 Bishop.new(color, self, [row, 5]),
                 Knight.new(color, self, [row, 6]),
                 Rook.new(color, self, [row, 7])]
    back_line
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def occupied?(pos)
    self[pos].is_a?(Piece)
  end

  def open?(pos)
    !occupied?(pos)
  end

  def opponent_piece?(pos, color)
    self.occupied?(pos) && (self[pos].color != color)
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