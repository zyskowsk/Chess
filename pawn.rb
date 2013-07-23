class Pawn < Piece
  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def available_moves

  end

  def to_s
    "P".colorize(@color)
  end
end