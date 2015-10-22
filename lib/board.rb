class Board
  attr_accessor :board

  def initialize
    @board = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
  end

  def draw_board
    @board.each.with_index do |row, index|
      if index == 2
        draw_row(row)
      else
        draw_row(row)
        puts("---+---+---")
      end
    end
    puts "\n"
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
    (0..2).map { |n| @board[n].uniq.length == 1 }.include?(true)
  end

  def vertical_win
    vert_array = (0..2).map { |n| @board.map { |row| row[n] } }
    (0..2).map { |n| vert_array[n].uniq.length == 1 }.include?(true)
  end

  def diagonal_win
    diag1 = (0..2).map { |n| @board[n][n] }
    diag2 = (0..2).map { |n| @board[-n-1][n] }
    diag_array = [diag1, diag2]
    (0..1).map { |n| diag_array[n].uniq.length == 1 }.include?(true)
  end

end
