module TicTacToe
  Move = Struct.new(:x, :y) do
    def eql?(other)
      other.x == self.x && other.y == self.y
    end
  end
end