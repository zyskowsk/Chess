load './pieces.rb'
load './pawn.rb'
load './knight.rb'
load './rook.rb'
load './bishop.rb'
load './queen.rb'
load './king.rb'
load './board.rb'
require 'colorize'
class Chess

  def initialize
    @board = Board.new
  end

  def run
    player = :white
    until @board.find_king(player).in_checkmate?
      play_turn(player)
      player = @board.other_color(player)
    end

    puts "#{@board.other_color(player)} won!"
  end

  private

    def get_coordinates
      input = gets.chomp.split(" ").map { |coord| Integer(coord) }
      raise InvalidInputError.new unless input.length == 2
      input
    end

    def get_move_position(piece)
      puts "Where do you want to move " +
           "your #{piece.class.to_s.downcase}? (row col)"
      get_coordinates
    end

    def get_piece_position(player)
      puts "What piece do you want to move? (row col)"
      pos = get_coordinates
      piece = @board[pos]

      unless piece.is_a?(Piece) && piece.color == player
        raise NotYourPieceError.new
      end

      return piece
    end

    def make_move(piece, pos)
      unless piece.available_moves.include?(pos)
        raise InvalidMoveError.new "Position not valid."
      end
      unless piece.move_defends_king?(pos)
        raise InvalidMoveError.new "That puts you in check."
      end

      piece.move(pos)
    end

    def play_turn(player)
      begin
        puts @board
        piece, pos =  get_piece_position(player), get_move_position(piece)
        make_move(piece, pos)
      rescue StandardError => e
        puts e.message
        retry
      end
    end
end

class InvalidMoveError < RuntimeError
end

class InvalidInputError < RuntimeError
  def initialize(msg = "Invalid input format, try again.")
    @message = msg
  end
end

class NotYourPieceError < RuntimeError
  def initialize(msg = "That's not one of your pieces.")
    @message = msg
  end
end