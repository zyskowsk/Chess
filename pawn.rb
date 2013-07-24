# encoding: UTF-8
class Pawn < Piece
  attr_accessor :moved
  PIECE_CLASSES = { "Queen" => Queen, "Bishop" => Bishop,
                    "Rook" => Rook, "Knight" => Knight }

  def initialize(color, board, pos)
    super(color, board, pos)
    @direction = get_direction
    @initial_row = pos.first
    @moved = false
  end

  # Refactor maybe
  def available_moves
    moves = []
    moves << Piece.vector_add(@position, @direction)
    unless @moved
      moves << add_displacement(@direction, 2)
    end
    moves.select! { |pos| valid_move?(pos) }

    moves + threatened_opponents
  end

  def promote
    puts "Which piece type would you like to promote to?"
    piece = gets.chomp.capitalize!
    unless PIECE_CLASSES.has_key?(piece)
      raise InvalidInputError.new("Not a piece type")
    end
    klass = PIECE_CLASSES[piece]
    @board[@position] = klass.new(@color, @board, @position)
  end

  def promotion_row
    @initial_row + @direction.first * 6
  end

  def move(pos)
    @moved = true
    super(pos)

    begin
      if @position.first == promotion_row
        promote
      end
    rescue InvalidInputError => e
      puts e.message
      retry
    end
  end

  def to_s
    "♟"
  end

  private

    def get_direction
      @color == @board.colors.first ? [-1,0] : [1,0]
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