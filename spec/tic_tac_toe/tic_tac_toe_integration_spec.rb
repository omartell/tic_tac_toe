require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    let(:io){ double(:io) }
    let(:moves){ { a: [], b: [] } }

    it "asks for player's a first move" do
      io.should_receive(:puts).with("Player a:")
      io.should_receive(:gets)
      ask_player :a
    end

    it "asks for player's b move after player a" do
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

    it "doesn't allow players to do a move that belongs to another player" do
      io.stub(:gets).and_return("0,1","0,1")
      io.stub(:puts)
      io.should_receive(:puts).with("That square has been already taken, please do another movement")

      ask_player :a
      ask_player :b
    end

    Move = Struct.new(:x, :y)

    def ask_player(player)
      io.puts("Player #{player.to_s}:")
      user_input = io.gets || ""
      move = Move.new *user_input.split(",").map(&:to_i)

      if moves.values.flatten.any?{ |m| m.x == move.x && m.y == move.y }
        return io.puts("That square has been already taken, please do another movement")
      end

      moves[player] << move

      xs = moves[player].map(&:x)
      ys = moves[player].map(&:y)

      if xs.all?{ |x| x == xs.first } && ys.inject(:+) == 3
        io.puts("Winner is player b")
      end

      if ys.all?{ |y| y == ys.first } && xs.inject(:+) == 3
        io.puts("Winner is player a")
      end

      if ys.inject(:+) == 3 && xs.inject(:+) == 3
        io.puts("Winner is player b")
      end
    end
  end
end