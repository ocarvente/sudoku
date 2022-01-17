
require_relative "tile.rb"
require "colorize"

VALUES = ("1".."9").to_a

class Board 

    def self.from_file(file_name)
        grid = Array.new(9) {Array.new(9)}
        file_data = File.read(file_name).split
        file_data.each_with_index do |row_str, row_num|
            row_str.each_char.each_with_index do |char,col_num| 
                grid[row_num][col_num] = Tile.new(char)
            end 
        end 
        grid 
    end

    attr_reader :grid ,:size

    def initialize
        @grid = Board.from_file("sudoku1.txt")
        @size = @grid.length 
    end 

    def [](position)
        row,col = position 
        @grid[row][col]
    end  

    def update(position, value)
        if self[position].given == false 
            self[position].value = value 
        else 
            raise "this tile is already given"
        end 
    end 

    def render
        system("clear")
        puts "  " + ("0"..."9").to_a.join(" ").colorize(:black)
        grid.each_with_index do |row, i|
            puts "#{i.to_s.colorize(:black)} #{row.map(&:to_s).join(" ")}"
        end 
        true 
    end 

    def solved?
        rows_solved?(grid) && cols_solved? && squares_solved?
    end 

    def rows_solved?(grid)
        grid.all? do |row|
            VALUES == row.map(&:value).sort
        end 
    end 

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

    def iterators
        size = Math.sqrt(grid.length).to_i 
        result = []
        i = 0 
        while i < grid.length
            result<< i
            i += size 
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