class Pawn < Piece
  attr_accessor :moved

  def initialize(color, board, pos)
    super(color, board, pos)
    @direction = get_direction
    @moved = false
  end

  # Refactor maybe
  def available_moves
    move_two = @direction.map { |num| num * 2 }
    moves = []
    moves << Piece.vector_add(@position, @direction)
    moves << Piece.vector_add(@position, move_two) unless @moved
    moves.select! { |pos| valid_move?(pos) }

    moves + threatened_opponents
  end

  def move(pos)
    @moved = true
    super(pos)
  end

  def to_s
    "P".colorize(@color)
  end

  private

    def get_direction
      @color == @board.color.first ? [-1,0] : [1,0]
    end

    def kill_directions
      [[0,1], [0,-1]].map { |side| Piece.vector_add(side, @direction) }
    end

    # Use direction to determine which diagonals to check.
    def threatened_opponents
      kill_directions.map do |dir|
        Piece.vector_add(dir, @position)
      end.select do |pos|
        @board.opponent_piece?(pos, @color)
      end
    end

    def valid_move?(pos)
      pos.all? { |coord| (0...8).include?(coord) } && @board.open?(pos)
    end
end