# encoding: UTF-8

class Knight < Stepper

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = [[-1, -2], [-2, -1],
                   [-1, 2], [2, -1],
                   [1, -2], [-2, 1],
                   [1, 2], [2, 1]]
  end

  def to_s
    "♞"
  end
end