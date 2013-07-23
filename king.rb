class King < Stepper
  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = [[-1,-1], [-1,0], [-1,1],
                   [0,-1], [0,1],
                   [1,-1], [1,0], [1,1]]

  end

  def to_s
    "K".colorize(@color)
  end
end