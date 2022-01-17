require 'colorize'

class Tile

    
    attr_accessor :value, :given 

    def initialize(value)
        @value = value
        value == "0" ? @given = false : @given = true 
    end

    def to_s
        return " " if value == "0"
        if value!= "0" 
            return value.colorize(:blue) if given
            return value.colorize(:black) if !given
        end   
    end 
end

#tile = Tile.new("4")
#puts tile.to_s