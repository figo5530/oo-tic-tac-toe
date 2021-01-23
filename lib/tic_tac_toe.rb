# require 'pry'
class TicTacToe
    # attr_accessor :index

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
      end

      WIN_COMBINATIONS = [
          [0,1,2],[3,4,5],[6,7,8],
          [0,3,6],[1,4,7],[2,5,8],
          [0,4,8],[2,4,6]
      ]

      def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

      def input_to_index(str)
        index = str.to_i - 1
      end

      def move(index,token="X")
        @board[index] = token
      end

      def position_taken?(index)
        @board[index] != " "
      end

      def valid_move?(index)
        index.between?(0,8) && !position_taken?(index) 
      end

      def turn_count
        @board.count{|ele| ele != " "}
      end

      def current_player
        # first round count == 9
        turn_count % 2 == 1 ? "O" : "X"
      end

      def turn
        puts "Please enter 1-9:"
        index = gets.chomp()
        index = input_to_index(index)
        while !valid_move?(index)
            puts "Please enter 1-9:"
            index = gets.chomp()
            index = input_to_index(index)
        end
        token = current_player
        move(index,token)
        display_board
      end

      def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                # binding.pry
                return combo
            end
        end
      end

      def full?
        !@board.include?(" ")
      end

      def draw?
        full? && !won?
      end

      def over?
        draw? || won?
      end

      def winner
        if combo = won?
            @board[combo[0]]
            # binding.pry
        end
      end

      def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{self.winner}!"
        else
            puts "Cat's Game!"
        end
      end
end