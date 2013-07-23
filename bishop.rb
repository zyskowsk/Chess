class Bishop < Slider
  def initialize(color, board, pos)
    super(color, board, pos)

    @directions = [[-1,-1], [1,1],
                   [-1,1], [1,-1]]
  end

  def to_s
    "B".colorize(@color)
  end
end