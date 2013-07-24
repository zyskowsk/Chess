class Board
  def initialize
    @grid = (0...8).map { |row| [" "] * 8 }
    @colors = [:white, :blue]
    populate
  end

  # Add instance variable for colors
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

  #refactor
  def dup
    new_board = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        pos = [i,j]
        if piece.is_a?(Piece)
          new_piece = piece.class.new(piece.color, new_board, pos)
          new_piece.moved = piece.moved if new_piece.is_a?(Pawn)
          new_board[pos] = new_piece
        else
          new_board[pos] = " "
        end
      end
    end

    new_board
  end

  def find_king(color)
    @grid.each do |row|
      row.each do |piece|
        return piece if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def get_all_pieces(color)
    pieces = []
    @grid.each do |row|
      row.each do |piece|
        pieces << piece if piece.is_a?(Piece) && piece.color == color
      end
    end

    pieces
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

  def other_color(color)
    @colors.first == color ? @colors.last : @colors.first
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