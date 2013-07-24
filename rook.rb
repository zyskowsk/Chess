class Rook < Slider
  attr_accessor :side, :moved

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = CARDINAL_DIRECTIONS
    @moved = false
    @side = nil
  end

  def move(pos)
    @moved = true
    super(pos)
  end

  def to_s
    "R".colorize(@color)
  end
end