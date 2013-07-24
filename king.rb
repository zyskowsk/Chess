# encoding: UTF-8

class King < Stepper

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = DIAGONAL_DIRECTIONS + CARDINAL_DIRECTIONS
    @moved = false
  end

  def can_castle_with?(rook)
    !@moved &&
    !self.in_check? &&
    !rook.moved &&
    rook_visible?(rook.side) &&
    castle_defends_king?(rook.side)
  end

  def can_castle?
    can_castle_with?(@board.find_rook(:left, @color)) ||
    can_castle_with?(@board.find_rook(:right, @color))
  end

  def rook_visible?(side)
    intermediates = []
    case side
    when :left
      intermediates = (1..3).map { |col| [@position.first, col] }
    when :right
      intermediates = (5..6).map { |col| [@position.first, col] }
    end

    intermediates.all? { |pos| @board.open?(pos) }
  end

  def left
    [0, -1]
  end

  def right
    [0, 1]
  end

  def castle_left(rook)
    self.move(add_displacement(left, 2))
    rook.move(rook.add_displacement(right, 3))
  end

  def castle_right(rook)
    self.move(add_displacement(right, 2))
    rook.move(rook.add_displacement(left, 2))
  end

  def castle_left_or_right(rook)
    castle_left(rook) if rook.side == :left
    castle_right(rook) if rook.side == :right
  end

  def castle(side)
    side = side.to_sym
    rook = @board.find_rook(side, @color)
    if can_castle_with?(rook)
      castle_left_or_right(rook)
    else
      raise InvalidMoveError.new "You can't castle from this position"
    end

    @moved = true
    rook.moved = true
  end

  def castle_defends_king?(side)
    new_board = @board.dup
    king = new_board.find_king(@color)
    rook = new_board.find_rook(side, @color)
    king.castle_left_or_right(rook)
    not king.in_check?
  end

  def in_check?
    opponent_color = @board.other_color(@color)
    opponent_pieces = @board.get_all_pieces(opponent_color)
    opponent_pieces.any? do |piece|
      piece.available_moves.include?(@position)
    end
  end

  def in_checkmate?
    allied_pieces = @board.get_all_pieces(@color)
    allied_pieces.each do |piece|
      if piece.available_moves.any? do |move|
          piece.move_defends_king?(move)
        end

        return false
      end
    end

    true
  end

  def move(pos)
    @moved = true
    super(pos)
  end

  def to_s
    '♚'
  end
end