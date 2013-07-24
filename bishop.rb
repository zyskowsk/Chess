class Bishop < Slider

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = DIAGONAL_DIRECTIONS
  end

  def to_s
    "B".colorize(@color)
  end
end