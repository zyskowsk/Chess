class Board
  attr_reader :colors

  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @grid = (0...8).map { |row| [" "] * 8 }
    @colors = [:blue, :red]
    populate
  end

  def []=(pos, piece)
    @grid[pos.first][pos.last] = piece
  end

  def [](pos)
    @grid[pos.first][pos.last]
  end

  def dup
    new_board = Board.new
    each_with_index do |row, i, piece, j|
      pos = [i,j]
      if piece.is_a?(Piece)
        new_piece = piece.class.new(piece.color, new_board, pos)
        new_piece.moved = piece.moved if new_piece.is_a?(Pawn)
        new_piece.side = piece.side if new_piece.is_a?(Rook)
        new_board[pos] = new_piece
      else
        new_board[pos] = " "
      end
    end

    new_board
  end

  def find_king(color)
    each do |row, piece|
      return piece if piece.is_a?(King) && piece.color == color
    end

    nil
  end

  def find_rook(side, color)
    each do |row, piece|
      if piece.is_a?(Rook) && piece.side == side && piece.color == color
        return piece
      end
    end
  end

  def get_all_pieces(color)
    pieces = []
    each do |row, piece|
      pieces << piece if piece.is_a?(Piece) && piece.color == color
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
    banner = " CHESS MASTER 90000\n " + "=" * 18 + "\n"
    top_row = "   #{("0"..."8").to_a.join(" ")}\n"
    ret_str = ""
    @grid.each_with_index do |row, i|
      ret_str << "#{i} #{row_string(row, i)} #{i}\n"
    end

    banner + top_row + ret_str + top_row
  end

  private

    def back_color(num)
      num == 0 ? :white : :black
    end

    def back_line(color, row)
      BACK_ROW.map.with_index do |klass, idx|
        piece = klass.new(color, self, [row, idx])
        piece.side = :left if idx == 0
        piece.side = :right if idx == 7
        piece
      end
    end

    def each(&block)
      @grid.each do |row|
        row.each do |piece|
          block.call(row, piece)
        end
      end
    end

    def each_with_index(&block)
      @grid.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          block.call(row, i, piece, j)
        end
      end
    end

    def populate
      set_white_pieces
      set_black_pieces
    end

    # Refactor
    def row_string(row, row_num)
      row.map.with_index do |space, idx|
        if space.is_a?(Piece)
          "#{space} ".colorize(:color => space.color,
                                :background => back_color((row_num + idx) % 2))
        else
          "#{space} ".colorize(:background => back_color((row_num + idx) % 2))
        end
      end.join
    end

    def set_black_pieces
      @grid[0] = back_line(@colors.last, 0)
      @grid[1].map!.with_index do |_, idx|
        Pawn.new(@colors.last, self, [1, idx])
      end
    end

    def set_white_pieces
      @grid[7] = back_line(@colors.first, 7)
      @grid[6].map!.with_index do |_, idx|
        Pawn.new(@colors.first, self, [6, idx])
      end
    end
end