class Board
  attr_reader :board

  def initialize
    @board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
  end

  def draw_board
    @board.each.with_index do |row, index|
      index == 2 ? draw_row(row) : draw_row(row); puts("---+---+---")
    end
  end

  def update_space(space, player)
    @board = @board.map {|row| row.map {|e| e == space ? player.piece : e } }
  end

  def free_spaces
    @free_spaces = @board.flatten.select {|num| num != "x" && num != "o"}
  end

  def free_space?(move)
    @free_spaces.include?(move)
  end

  def win?
    horizontal_win || vertical_win || diagonal_win
  end

  def tie?
    free_spaces.empty? && !win?
  end

  private
  def draw_row(row)
    puts(" #{row[0]} | #{row[1]} | #{row[2]} ")
  end

  def horizontal_win
    @board[0].uniq.length == 1 || @board[1].uniq.length == 1 || @board[2].uniq.length == 1
  end

  def vertical_win
    (0..2).each do |i|
      return true if @board[0][i] == @board[1][i] && @board[0][i] == @board[2][i]
    end
    false
  end

  def diagonal_win
    (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||
    (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0])
  end

end
