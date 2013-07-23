class Pawn < Piece
  def initialize(color, board, pos)
    super(color, board, pos)
    @direction = get_direction
    @moved = false
  end

  def threatened_opponents
    #use direction to determine which diagonals to check
    kill_positions = kill_directions.map { |dir| vector_add(dir, @position) }
    kill_positions.select { |pos| @board.opponent_piece?(pos, @color) }
  end

  def available_moves
    move_two = @direction.map { |num| num * 2 }
    moves = []
    moves << vector_add(@position, @direction)
    moves << vector_add(@position, move_two) unless @moved
    moves.select! { |pos| valid_move?(pos) }

    moves + threatened_opponents
  end

  def get_direction
    @color == :white ? [-1,0] : [1,0]
  end

  def kill_directions
    [[0,1], [0,-1]].map { |side| vector_add(side, @direction) }
  end

  def to_s
    "P".colorize(@color)
  end

  def valid_move?(pos)
    pos.all? { |coord| (0...8).include?(coord) } && @board.open?(pos)
  end

end