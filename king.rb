class King < Stepper

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = DIAGONAL_DIRECTIONS + CARDINAL_DIRECTIONS
    @moved = false
  end

  def can_castle_with?(rook)
    !@moved && !self.in_check? && !rook.moved? &&
    castle_defends_king(rook) && #nothing between me and rook


  end

  def castle_left(rook)

  end

  def castle_right

  end

  def castle(side)
    side = side.to_sym
    rook = @board.find_rook(side, @color)
    if can_castle_with?(rook)

    end
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
    "K".colorize(@color)
  end
end