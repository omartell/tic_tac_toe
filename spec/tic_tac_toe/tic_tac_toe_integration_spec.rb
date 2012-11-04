require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    IO = Struct.new(:inputs) do
      attr_reader :outputs

      def puts(message)
        @outputs ||= []
        @outputs << message
      end

      def gets
        inputs.shift
      end
    end

    def io(jeff = nil, anna = nil)
      @io ||= IO.new(["jeff", "anna", *jeff.zip(anna).flatten])
    end

    it "asks who's playing" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Who's the first player?", "Who's the second player?"
    end

    it "asks for player's b move after player a" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Player jeff:", "Player anna:", "Player jeff:", "Player anna:", "Player jeff:", "Player anna:", "Player jeff:", "Player anna:", "Player jeff:"
    end

    it "shows the winner when one player takes the whole row" do
      jeff = ["0,0", "1,0", "2,0"]
      anna = ["0,1", "1,1"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Winner is player jeff"
    end

    it "shows the winner when one player takes the whole column" do
      jeff = ["0,0", "1,0", "1,1"]
      anna = ["2,0", "2,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Winner is player anna"
    end

    it "shows the winner when one player takes the diagonal" do
      jeff = ["0,0", "0,1", "2,1"]
      anna = ["2,0", "1,1", "0,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Winner is player anna"
    end

    it "shows the winner for more sophisticated diagonals" do
      jeff = ["0,0", "0,2", "1,1", "2,0"]
      anna = ["0,1", "2,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "Winner is player jeff"
    end

    it "doesn't allow players to do a move that belongs to another player" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["0,0", "1,1", "2,0", "0,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "That square has been already taken, please do another movement", "No winners this time!"
    end

    it "ends the game if there are no more squares to take" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]

      TicTacToe.new(io(jeff, anna)).start

      io.outputs.should include "No winners this time!"
    end
  end
end