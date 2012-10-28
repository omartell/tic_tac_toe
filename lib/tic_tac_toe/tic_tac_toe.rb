module TicTacToe
  class TicTacToe
    attr_reader :io

    def initialize(io)
      @io = io
      @engine = Engine.new
      @player_names = []
    end

    def set_players
      io.puts("Who's the first player?")
      @player_names << io.gets
      io.puts("Who's the second player?")
      @player_names << io.gets
    end

    def start
      set_players
      play(@player_names.first)
      play(@player_names.last)
    end

    def play(player)
      io.puts("Player #{player}:")
      move = parse_input(io.gets)
      state = @engine.move(player, move)

      io.puts("That square has been already taken, please do another movement") if state == :square_taken
      io.puts ("Winner is player #{player.to_s}") if state == :winner
      io.puts("No winners this time!") if state == :no_winner
    end

    def parse_input(user_input)
      Move.new *user_input.split(",").map(&:to_i)
    end
  end
end