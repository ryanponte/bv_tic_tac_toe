require 'spec_helper'

describe "Board" do
  describe "#initialize" do
    let(:game) { Board.new }
    it "initiates a class with a board that is an array of three arrays" do
      expect(game.board).to eq([["1","2","3"],["4","5","6"],["7","8","9"]])
    end
    it "has a writer method for board" do
      game.board[0][0] = "x"
      expect(game.board).to eq([["x","2","3"],["4","5","6"],["7","8","9"]])
    end
  end

  describe "#free_spaces" do
    let(:game) { Board.new }
    let(:tie_game) {
      tied = Board.new
      tied.board = [["o","o","x"],["x","o","o"],["o","x","x"]]
      tied
    }
    it "returns array that contains arrays of of all empty space coordinates at beginning of game" do
      expect(game.free_spaces).to include("1")
      expect(game.free_spaces).to include("2")
      expect(game.free_spaces).to include("3")
      expect(game.free_spaces).to include("4")
      expect(game.free_spaces).to include("5")
      expect(game.free_spaces).to include("6")
      expect(game.free_spaces).to include("7")
      expect(game.free_spaces).to include("8")
      expect(game.free_spaces).to include("9")
    end
    it "returns array that contains arrays of of all empty space coordinates throughout game" do
      game.board = [["1","2","x"],["o","x","6"],["7","x","o"]]
      expect(game.free_spaces).to include("1")
      expect(game.free_spaces).to include("2")
      expect(game.free_spaces).to include("6")
      expect(game.free_spaces).to include("7")
    end
    it "returns an empty array when there are no free spaces" do
      expect(tie_game.free_spaces).to eq([])
    end
  end

  describe "#update_space"
    let(:game) { Board.new }
    it "updates board space to the correct letter" do
      skynet = Player.new("SkyNet", "x")
      game.update_space("6", skynet)
      expect(game.board[1][2]).to eq("x")
  end

  describe "#tie?" do
    let(:game) { Board.new }
    it "returns false when the game starts" do
      expect(game.tie?).to eq(false)
    end
    it "returns false when there are spaces available" do
      game.board = [["1","2","x"],["o","x","6"],["7","x","o"]]
      expect(game.tie?).to eq(false)
    end
    it "returns true when the spaces are filled and there are no winners" do
      game.board = [["o","x","x"],["x","o","o"],["x","o","x"]]
      expect(game.tie?).to eq(true)
    end
    it "returns false when there is a winner" do
      game.board = [["x","x","x"],["o","o","x"],["o","x","o"]]
      expect(game.tie?).to eq(false)
    end
  end

  describe "#win" do
    let(:game) { Board.new }
    it "returns false for no winner" do
      expect(game.win?).to eq(false)
      game.board = [["o","x","x"],["x","o","o"],["x","o","x"]]
      expect(game.win?).to eq(false)
    end
    it "returns true when there is a diagonal winner" do
      game.board = [["x","x","o"],["o","x","o"],["x","o","x"]]
      expect(game.win?).to eq(true)
    end
    it "returns true for horizontal winner" do
      game.board = [["x","x","x"],["4","5","6"],["o","8","o"]]
      expect(game.win?).to eq(true)
    end
    it "returns true for vertical winner" do
      game.board = [["x","2","3"],["x","o","6"],["x","o","9"]]
      expect(game.win?).to eq(true)
    end
  end
end
