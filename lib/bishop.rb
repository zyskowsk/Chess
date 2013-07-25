# encoding: UTF-8

class Bishop < Slider

  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = DIAGONAL_DIRECTIONS
  end

  def to_s
    "♝"
  end
end