class Rook < Slider
  def initialize(color)
    super(color)
    @directions = [[-1,0], [1,0],
                   [0,-1], [0,1]]
  end

  def to_s
    "R".colorize(@color)
  end
end