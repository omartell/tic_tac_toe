require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    let(:io){ double(:io) }
    let(:tic_tac_toe){ TicTacToe.new(io) }

    def ask_player(player)
      tic_tac_toe.play(player.to_s)
    end

    it "asks who's playing" do
      io.stub(:puts)
      io.should_receive(:puts).with("Who's the first player?")
      io.stub(gets: "oliver")
      io.should_receive(:puts).with("Who's the second player?")
      io.stub(gets: "anna")

      tic_tac_toe.set_players
    end

    it "asks for player's a first move" do
      io.stub(:gets).and_return("a","0,0")
      io.stub(:puts)
      io.should_receive(:puts).with("Player a:")
      io.should_receive(:gets)

      tic_tac_toe.start
    end

    it "asks for player's b move after player a" do
      io.stub(:puts)
      io.should_receive(:puts).with("Player a:").ordered
      io.should_receive(:gets).ordered.and_return("1,1")
      io.should_receive(:puts).with("Player b:").ordered
      io.should_receive(:gets).ordered.and_return("2,2")

      ask_player :a
      ask_player :b
    end

    it "shows the winner when one player takes the whole row" do
      a = ["0,0", "1,0", "2,0"]
      b = ["0,1", "1,1"]
      io.stub(:gets).and_return(a[0], b[0], a[1], b[1], a[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player a")

      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
    end

    it "shows the winner when one player takes the whole column" do
      a = ["0,0", "1,0", "1,1"]
      b = ["2,0", "2,1", "2,2"]
      io.stub(:gets).and_return(a[0], b[0], a[1], b[1], a[2], b[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player b")

      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
    end

    it "shows the winner when one player takes the diagonal" do
      a = ["0,0", "0,1", "2,1"]
      b = ["2,0", "1,1", "0,2"]
      io.stub(:gets).and_return(a[0], b[0], a[1], b[1], a[2], b[2])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player b")

      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
    end

    it "shows the winner for more sophisticated diagonals" do
      a = ["0,0", "0,2", "1,1", "2,0"]
      b = ["0,1", "2,1", "2,2"]

      io.stub(:gets).and_return(a[0], b[0], a[1], b[1], a[2], b[2], a[3])
      io.stub(:puts)
      io.should_receive(:puts).with("Winner is player a")

      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
    end

    it "doesn't allow players to do a move that belongs to another player" do
      io.stub(:gets).and_return("0,1","0,1")
      io.stub(:puts)
      io.should_receive(:puts).with("That square has been already taken, please do another movement")

      ask_player :a
      ask_player :b
    end

    it "ends the game if there are no more squares to take" do
      a = ["0,0", "1,0", "0,2", "2,1", "1,2"]
      b = ["1,1", "2,0", "0,1", "2,2"]
      io.stub(:gets).and_return(a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3], a[4])
      io.stub(:puts)
      io.should_receive(:puts).with("No winners this time!")
      io.should_not_receive(:puts).with("Winner is player a")
      io.should_not_receive(:puts).with("Winner is player b")

      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
      ask_player :b
      ask_player :a
    end
  end
end