require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    let(:io){ double(:io) }
    let(:tic_tac_toe){ TicTacToe.new(io) }

    def moves(player_a, player_b)
      player_a.zip(player_b).flatten
    end

    it "asks who's playing" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]

      io.stub(:puts)
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.should_receive(:puts).with("Who's the first player?")
      io.should_receive(:puts).with("Who's the second player?")

      tic_tac_toe.start
    end

    it "asks for player's b move after player a" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]

      io.stub(:gets).and_return("jeff","anna", *moves(jeff, anna))
      args = []
      io.stub(:puts) do |arg|
        args << arg
      end

      tic_tac_toe.start

      args.join(",").should include [
        "Player jeff:", 
        "Player anna:", 
        "Player jeff:", 
        "Player anna:", 
        "Player jeff:", 
        "Player anna:", 
        "Player jeff:", 
        "Player anna:", 
        "Player jeff:"].join(",")
    end

    it "shows the winner when one player takes the whole row" do
      jeff = ["0,0", "1,0", "2,0"]
      anna = ["0,1", "1,1"]
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player jeff")

      tic_tac_toe.start
    end

    it "shows the winner when one player takes the whole column" do
      jeff = ["0,0", "1,0", "1,1"]
      anna = ["2,0", "2,1", "2,2"]
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player anna")

      tic_tac_toe.start
    end

    it "shows the winner when one player takes the diagonal" do
      jeff = ["0,0", "0,1", "2,1"]
      anna = ["2,0", "1,1", "0,2"]
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player anna")

      tic_tac_toe.start
    end

    it "shows the winner for more sophisticated diagonals" do
      jeff = ["0,0", "0,2", "1,1", "2,0"]
      anna = ["0,1", "2,1", "2,2"]

      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player jeff")

      tic_tac_toe.start
    end

    it "doesn't allow players to do a move that belongs to another player" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["0,0", "1,1", "2,0", "0,1", "2,2"]
      io.stub(:puts)
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.should_receive(:puts).with("That square has been already taken, please do another movement")
      io.should_receive(:puts).with("No winners this time!")

      tic_tac_toe.start
    end

    it "ends the game if there are no more squares to take" do
      jeff = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      anna = ["1,1", "2,0", "0,1", "2,2"]
      io.stub(:gets).and_return("jeff", "anna", *moves(jeff, anna))
      io.stub(:puts)
      io.should_receive(:puts).with("No winners this time!")
      io.should_not_receive(:puts).with("Winner is player a")
      io.should_not_receive(:puts).with("Winner is player b")

      tic_tac_toe.start
    end
  end
end