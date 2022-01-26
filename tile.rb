require 'colorize'

class Tile

    
    attr_accessor :value, :given 

    def initialize(value)
        @value = value
        value == "0" ? @given = false : @given = true 
    end

    #Overides the to_s method to return the value of the tile when rendering with 
    #appropriate color. 
    def to_s
        return " " if value == "0"
        if value!= "0" 
            return value.colorize(:blue) if given
            return value.colorize(:white) if !given
        end   
    end 
end
