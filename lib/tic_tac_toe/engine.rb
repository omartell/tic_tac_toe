module TicTacToe
  class Engine
    attr_reader :players
    def initialize
      @players = []
    end

    def move(name, move)
      player = find_or_initialize_player(name)
      return :square_taken if has_the_square_been_taken?(move)
      player.add_move(move)

      state = :winner if has_won?(player)
      state = :no_winner if all_squares_taken?
      state
    end

    def has_won?(player)
      match_row?(player)|| match_column?(player) || match_diagonal?(player)
    end

    def match_row?(player)
      player.xs.all?{ |x| x == player.xs.first } && player.ys.inject(:+) == 3
    end

    def match_column?(player)
      player.ys.all?{ |y| y == player.ys.first } && player.xs.inject(:+) == 3
    end

    def match_diagonal?(player)
      (player.moves & [Move.new(0,2), Move.new(1,1), Move.new(2,0)]).size == 3 ||
      (player.moves & [Move.new(0,0), Move.new(1,1), Move.new(2,2)]).size == 3
    end

    def all_moves
      players.flat_map(&:moves)
    end

    def has_the_square_been_taken?(move)
      all_moves.any?{|m| m==move }
    end

    def all_squares_taken?
      all_moves.size == 9
    end

    def find_or_initialize_player(name)
      gamer = find_player(name) || Player.new(name)
      players << gamer unless find_player(name)
      gamer
    end

    def find_player(name)
      players.find{|p| p.name == name }
    end
  end
end