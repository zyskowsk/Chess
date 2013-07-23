class Pawn < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "P".colorize(@color)
  end
end