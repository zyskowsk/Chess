require 'colorize'



class Piece
  def initialize(color)
    @color = color
  end
end

class Slider < Piece
  def initialize(*args)
    super(*args)
  end
end

class Stepper < Piece
  def initialize(*args)
    super(*args)
  end
end
