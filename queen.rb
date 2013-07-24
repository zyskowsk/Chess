class Queen < Slider

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = DIAGONAL_DIRECTIONS + CARDINAL_DIRECTIONS
  end

  def to_s
    "Q".colorize(@color)
  end
end