class Rook < Slider

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = CARDINAL_DIRECTIONS
  end

  def to_s
    "R".colorize(@color)
  end
end