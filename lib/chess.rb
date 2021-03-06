#!/usr/bin/env ruby

require './pieces.rb'
require './knight.rb'
require './rook.rb'
require './bishop.rb'
require './queen.rb'
require './king.rb'
require './pawn.rb'
require './board.rb'
require 'colorize'

class Chess
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def run
    system "clear"
    puts @board
    player = @board.colors.first
    until @board.find_king(player).in_checkmate?
      puts "You are in check!" if @board.find_king(player).in_check?
      play_turn(player)
      player = @board.other_color(player)
    end

    puts "#{@board.other_color(player)} won!"
  end

  private

    def get_castle_command
      puts "Do you want to castle? (left/right/no)"
      input = gets.chomp
      unless ["left", "right", "no"].include?(input)
        raise InvalidInputError.new
      end
      input
    end

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
      puts "What piece do you want to move, #{player}? (row col)"
      pos = get_coordinates
      piece = @board[pos]

      unless piece.is_a?(Piece) && piece.color == player
        raise NotYourPieceError.new
      end

      raise InvalidPieceSelectionError.new unless piece.has_move?

      piece
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

    # Too long
    def play_turn(player)
      begin
        if @board.find_king(player).can_castle?
          response = get_castle_command
          unless response == "no"
            @board.find_king(player).castle(response)
            system "clear"
            puts @board
            return
          end
        end
        piece = get_piece_position(player)
        pos = get_move_position(piece)
        make_move(piece, pos)
      rescue StandardError => e
        puts e.message
        retry
      end
      system "clear"
      puts @board
    end
end

class InvalidMoveError < RuntimeError
end

class InvalidPieceSelectionError < RuntimeError
  def initialize(msg = "That piece has no legal moves")
    super(msg)
  end
end

class InvalidInputError < RuntimeError
  def initialize(msg = "Invalid input format, try again.")
    super(msg)
  end
end

class NotYourPieceError < RuntimeError
  def initialize(msg = "That's not one of your pieces.")
    super(msg)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.run
end