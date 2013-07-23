require 'colorize'

class Piece
  attr_reader :color, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def move(pos)
    @board[pos] = self
    @board[@position] = " "
    @position = pos
  end

  def valid_move?(pos)
    # p "on board? #{pos.all? { |coord| (0...8).include?(coord) }}"
    # p "piece there? "
    pos.all? { |coord| (0...8).include?(coord) } &&
      (@board.open?(pos) || @board.opponent_piece?(pos, @color))
  end

  def vector_add(pos, disp)
    pos.map.with_index { |coord, idx| coord + disp[idx] }
  end

end

class Slider < Piece
  def initialize(*args)
    super(*args)
  end

  def available_moves
    moves = []
    @directions.each do |direction|
      curr_pos = vector_add(@position, direction)

      while valid_move?(curr_pos)
        moves << curr_pos
        break if @board.opponent_piece?(curr_pos, @color)
        curr_pos = vector_add(curr_pos, direction)
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
      moves << vector_add(@position, direction)
    end

    moves.select { |pos| valid_move?(pos) }
  end
end
