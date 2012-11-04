require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    let(:io){ double(:io) }
    let(:tic_tac_toe){ TicTacToe.new(io) }

    it "asks who's playing" do
      a = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      b = ["1,1", "2,0", "0,1", "2,2"]

      io.stub(:puts)
      io.stub(:gets).and_return("oliver", "ana", a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3], a[4])
      io.should_receive(:puts).with("Who's the first player?")
      io.should_receive(:puts).with("Who's the second player?")

      tic_tac_toe.start
    end

    it "asks for player's b move after player a" do
      a = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      b = ["1,1", "2,0", "0,1", "2,2"]

      io.stub(:gets).and_return("a","b", a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3], a[4])
      args = []
      io.stub(:puts) do |arg|
        args << arg
      end

      tic_tac_toe.start

      args.join(",").should include ["Player a:", "Player b:", "Player a:", "Player b:", "Player a:", "Player b:", "Player a:", "Player b:", "Player a:"].join(",")
    end

    it "shows the winner when one player takes the whole row" do
      a = ["0,0", "1,0", "2,0"]
      b = ["0,1", "1,1"]
      io.stub(:gets).and_return("a", "b", a[0], b[0], a[1], b[1], a[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player a")

      tic_tac_toe.start
    end

    it "shows the winner when one player takes the whole column" do
      a = ["0,0", "1,0", "1,1"]
      b = ["2,0", "2,1", "2,2"]
      io.stub(:gets).and_return("a", "b",a[0], b[0], a[1], b[1], a[2], b[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player b")

      tic_tac_toe.start
    end

    it "shows the winner when one player takes the diagonal" do
      a = ["0,0", "0,1", "2,1"]
      b = ["2,0", "1,1", "0,2"]
      io.stub(:gets).and_return("a", "b",a[0], b[0], a[1], b[1], a[2], b[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player b")

      tic_tac_toe.start
    end

    it "shows the winner for more sophisticated diagonals" do
      a = ["0,0", "0,2", "1,1", "2,0"]
      b = ["0,1", "2,1", "2,2"]

      io.stub(:gets).and_return("a", "b",a[0], b[0], a[1], b[1], a[2], b[2], a[3])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player a")

      tic_tac_toe.start
    end

    it "doesn't allow players to do a move that belongs to another player" do
      a = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      b = ["0,0", "1,1", "2,0", "0,1", "2,2"]
      io.stub(:puts)
      io.stub(:gets).and_return("a", "b",a[0], b[0], b[1],a[1], b[2], a[2], b[3], a[3], b[4], a[4])
      io.should_receive(:puts).with("That square has been already taken, please do another movement")
      io.should_receive(:puts).with("No winners this time!")

      tic_tac_toe.start
    end

    it "ends the game if there are no more squares to take" do
      a = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      b = ["1,1", "2,0", "0,1", "2,2"]
      io.stub(:gets).and_return("a", "b",a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3], a[4])
      io.stub(:puts)
      io.should_receive(:puts).with("No winners this time!")
      io.should_not_receive(:puts).with("Winner is player a")
      io.should_not_receive(:puts).with("Winner is player b")

      tic_tac_toe.start
    end
  end
end