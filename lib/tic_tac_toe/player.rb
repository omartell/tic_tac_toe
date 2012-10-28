module TicTacToe
  class Player
    attr_reader :moves, :name
    def initialize(name)
      @name = name
      @moves = []
    end

    def add_move(move)
      @moves << move
    end

    def xs
      @moves.map(&:x)
    end

    def ys
      @moves.map(&:y)
    end
  end
end