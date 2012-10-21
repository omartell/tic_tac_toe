require 'spec_helper'

module TicTacToe
  describe "TicTacToe" do
    let(:io){ double(:output) }

    it "asks for player's a first move" do
      io.should_receive(:puts).with("Player a:")
      io.should_receive(:gets)
      ask_player :a
    end

    it "asks for player's b move after player a" do
      io.should_receive(:puts).with("Player a:").ordered
      io.should_receive(:gets).ordered
      io.should_receive(:puts).with("Player b:").ordered
      io.should_receive(:gets).ordered

      ask_player :a
      ask_player :b
    end

    def ask_player(player)
      io.puts("Player #{player.to_s}:")
      io.gets
    end
  end
end