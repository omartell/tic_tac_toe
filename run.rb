require_relative "lib/tic_tac_toe.rb"

io = Struct.new(nil) do
  def gets(*args)
    STDIN.gets *args
  end

  def puts(*args)
    STDOUT.puts *args
  end
end.new

TicTacToe::TicTacToe.new(io).start