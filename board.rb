
require_relative "tile.rb"
require "colorize"

VALUES = ("1".."9").to_a

class Board 

    #Takes in a file name and splits the data into an array of strings representing the rows. 
    #Iterates through each character in the rows and assigns it to its corresponding place in the grid using the row_num and col_num. 
    For each row of data it will 
    def self.from_file(file_name)
        grid = Array.new(9) {Array.new(9)}
        file_data = File.read(file_name).split
        file_data.each_with_index do |row_string, row_num|
            row_string.each_char.each_with_index do |char,col_num| 
                grid[row_num][col_num] = Tile.new(char)
            end 
        end 
        grid 
    end

    #Getters for grid and size 
    attr_reader :grid ,:size

    #Initializes Board with two instance variables, the board and the size which is the number of rows.  
    def initialize
        @grid = Board.from_file("sudoku1.txt")
        @size = @grid.length 
    end 

    #Defines the position method for board. 
    def [](position)
        row,col = position 
        @grid[row][col]
    end  

    def update(position, value)
        if self[position].given == false  #if the position hasn't been given then we can update it
            self[position].value = value 
        else 
            raise "this tile is already given"
        end 
    end 

    def render
        system("clear") #everytime its called the system clears for the updated board 
        puts "  " + ("0"..."9").to_a.join(" ").colorize(:black) #indexes the board 
        grid.each_with_index do |row, i|
            puts "#{i.to_s.colorize(:black)} #{row.map(&:to_s).join(" ")}"  # starts each row with the row number and then adds in the values of the tiles next to each other
        end 
        true 
    end 

    #It is solved if the rows are solved, the coloumns and the squares are all solved. 
    def solved?
        rows_solved?(grid) && cols_solved? && squares_solved?
    end 

    #Checks each rows by sorting it and comparing it to the values array, which has the values 1 - 9. 
    def rows_solved?(grid)
        grid.all? do |row|
            VALUES == row.map(&:value).sort
        end 
    end 

    #Check if the columns are solved by calling the rows_solved method on the grid transposed.
    def cols_solved? 
        rows_solved?(grid.transpose)
    end 
    
    def squares_solved?
        squares = self.all_squares #returns an array of each 3X3 square items 
        rows_solved?(squares)
    end 

    
    def all_squares
        result = [] 
        iterators.each do |row|
            iterators.each do |col|
                result << one_square(row,col)
            end 
        end 
        
        result  
    end 

    #Returns the [0,3,6] array. Maybe should just hardcode since sudoku board is always 9 by 9
    def iterators
        square_side = Math.sqrt(size).to_i 
        result = []
        i = 0 
        while i < grid.length
            result<< i
            i += square_side 
        end 
        result
    end 

    def one_square(row,col)
        result = []
        (row...row+3).each do |row|
            (col...col+3).each do |col|
                result << grid[row][col]
            end 
        end 

        result 

    end 



end 