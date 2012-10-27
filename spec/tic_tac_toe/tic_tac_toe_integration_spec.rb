require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do

    let(:io){ double(:io) }
    let(:moves){ { a: [], b: [] } }

    it "asks for player's a first move" do
      io.stub(:gets).and_return("0,0")
      io.stub(:puts)
      io.should_receive(:puts).with("Player a:")
      io.should_receive(:gets)
      ask_player :a
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

    Move = Struct.new(:x, :y) do
      def eql?(other)
        other.x == self.x && other.y == self.y
      end
    end

    def ask_player(player)
      io.puts("Player #{player.to_s}:")
      move = parse_input(io.gets)

      if has_the_square_been_taken?(move)
        return io.puts("That square has been already taken, please do another movement")
      end

      add_move(player, move)

      io.puts ("Winner is player #{player.to_s}") if has_won?(player)
      io.puts("No winners this time!") if moves.values.flatten.size == 9
    end

    def add_move(player, move)
      moves[player] << move
    end

    def parse_input(user_input)
      Move.new *user_input.split(",").map(&:to_i)
    end

    def xs(player)
      moves[player].map(&:x)
    end

    def ys(player)
      moves[player].map(&:y)
    end

    def has_won?(player)
      xs = xs(player)
      ys = ys(player)
      xs.all?{ |x| x == xs.first } && ys.inject(:+) == 3 ||
      ys.all?{ |y| y == ys.first } && xs.inject(:+) == 3 ||
      ys.inject(:+) == 3 && xs.inject(:+) == 3 && xs.size == 3
    end

    def has_the_square_been_taken?(move)
      moves.values.flatten.any?{|m| m==move }
    end
  end
end