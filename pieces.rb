require 'colorize'

class Piece
  def initialize(color)
    @color = color
  end
end

class Pawn < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "P".colorize(@color)
  end
end

class Rook < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "R".colorize(@color)
  end
end

class Bishop < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "B".colorize(@color)
  end
end

class Knight < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "N".colorize(@color)
  end
end

class Queen < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "Q".colorize(@color)
  end
end

class King < Piece
  def initialize(color)
    super(color)
  end

  def to_s
    "K".colorize(@color)
  end
end