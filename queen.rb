class Queen < Slider
  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = [[-1,-1], [-1,0], [-1,1],
                   [0,-1], [0,1],
                   [1,-1], [1,0], [1,1]]
  end

  def to_s
    "Q".colorize(@color)
  end
end