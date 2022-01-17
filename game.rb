require_relative "board.rb"

class Game

    attr_reader :board

    def initialize
        @board = Board.new
    end 

    def get_value
        val = ""
        until val.length == 1 && valid_value?(val)
            puts "now type in the value you want to place in the position"
            val = gets.chomp
        end 
        val 
    end 

    def valid_position?(position)
        position.all? {|val| val.between?(0, board.size-1)}
    end 

    def valid_value?(value)
        value.to_i.between?(0,board.size)
    end 

    def get_position
        pos = []
        until pos.length == 2 && valid_position?(pos)
            puts "type the position first "
            pos = gets.chomp.split(",").map(&:to_i)
        end 
        pos 
    end 

    def prompt
        puts "Type a position in the grid that isn't already given e.g 1,2"
        puts "Then type in a value you want to place in that position "
    end 
    
    def play 
        until board.solved?
            board.render
            pos = get_position
            val = get_value
            board.update(pos, val)
        end 

        puts "congrats you finished!"
    end 
end 

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end 

