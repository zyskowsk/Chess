class Pawn < Piece
  def initialize(color, board, pos)
    super(color, board, pos)
    @direction = get_direction
    @moved = false
  end

  def threatened_opponents
    #use direction to determine which diagonals to check
    threatened_positions = [[0,1], [0,-1]].map do |side|
      vector_add(side, @direction)
    end

    threatened_positions.select { |pos| @board.opponent_piece?(pos, @color) }
  end

  def available_moves

  end

  def get_direction
    @color == :white ? [-1,0] : [1,0]
  end

  def to_s
    "P".colorize(@color)
  end
end