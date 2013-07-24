class King < Stepper
  def initialize(color, board, pos)
    super(color, board, pos)
    @directions = [[-1,-1], [-1,0], [-1,1],
                   [0,-1], [0,1],
                   [1,-1], [1,0], [1,1]]

  end

  def in_check?
    opponent_color = @board.other_color(@color)
    all_opponent_pieces = @board.get_all_pieces(opponent_color)
    all_opponent_pieces.any? do |piece|
      piece.available_moves.include?(@position)
    end
  end

  def to_s
    "K".colorize(@color)
  end
end