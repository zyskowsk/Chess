class Queen < Slider
  def initialize(color)
    super(color)
    @directions = [[-1,-1], [-1,0], [-1,1]
                   [0,-1], [0,1],
                   [1,-1], [1,0], [1,1]]
  end

  def to_s
    "Q".colorize(@color)
  end
end