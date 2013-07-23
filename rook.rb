class Rook < Slider
  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = [[-1,0], [1,0],
                   [0,-1], [0,1]]
  end

  def to_s
    "R".colorize(@color)
  end
end