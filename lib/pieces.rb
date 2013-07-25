class Piece
  attr_reader :color, :position

  DIAGONAL_DIRECTIONS = [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  CARDINAL_DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  def self.vector_add(pos, disp)
    pos.map.with_index { |coord, idx| coord + disp[idx] }
  end

  def self.scalar_multiply(disp, factor)
    disp.map { |coord| coord * factor }
  end

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def add_displacement(direction, distance)
    Piece.vector_add(@position, Piece.scalar_multiply(direction, distance))
  end

  def has_move?
    not self.available_moves.select do |move|
       move_defends_king?(move)
     end.empty?
  end

  def move(pos)
    @board[pos] = self
    @board[@position] = " "
    @position = pos
  end

  def move_defends_king?(pos)
    new_board = @board.dup
    king = new_board.find_king(@color)
    new_board[@position].move(pos)

    not king.in_check?
  end

  def valid_move?(pos)
    pos.all? { |coord| (0...8).include?(coord) } &&
      (@board.open?(pos) || @board.opponent_piece?(pos, @color))
  end
end

class Slider < Piece
  def initialize(*args)
    super(*args)
  end

  def available_moves
    moves = []
    @directions.each do |direction|
      curr_pos = Piece.vector_add(@position, direction)

      while valid_move?(curr_pos)
        moves << curr_pos
        break if @board.opponent_piece?(curr_pos, @color)
        curr_pos = Piece.vector_add(curr_pos, direction)
      end
    end

    moves
  end
end

class Stepper < Piece
  def initialize(*args)
    super(*args)
  end

  def available_moves
    moves = []
    @directions.each do |direction|
      moves << Piece.vector_add(@position, direction)
    end

    moves.select { |pos| valid_move?(pos) }
  end
end
