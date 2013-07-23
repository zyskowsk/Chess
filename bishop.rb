class Bishop < Slider
  def initialize(color)
    super(color)
    @directions = [[-1,-1], [1,1],
                   [-1,1], [1,-1]]
  end

  def to_s
    "B".colorize(@color)
  end
end