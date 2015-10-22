class TicTacToe

  def play
    puts "\e[H\e[2J"
    puts "Let's play Tic Tac Toe!"
    player_name
    choice_of_piece
    @player = Player.new(@player_name, @player_piece)
    @computer = Player.new("SkyNet", @computer_piece)
    @board = Board.new
    @turn_num = 0
    until win? || tie?
      puts "\e[H\e[2J"
      @board.draw_board
      @turn_num.even? ? player_move : computer_move
    end
    ending
  end

  def player_name
    puts "I'm SkyNet. What is your name?"
    name = gets.chomp
    @player_name = name
  end

  def choice_of_piece
    puts "Would you like to play X or O?"
    input = gets.chomp.downcase
    while input != "x" && input != "o"
      puts "You must choose X or O"
      input = gets.chomp.downcase
    end
    if input == 'x'
      @player_piece = 'x'
      @computer_piece = 'o'
    else
      @computer_piece = 'x'
      @player_piece = 'o'
    end
  end

  def invalid
    puts "That move is invalid. You must select an open number."
  end

  def ending
    puts "\e[H\e[2J"
    @board.draw_board
    if win?
      puts "#{winner.name} won!"
    else
      puts "It's a tie."
    end
    play_again
  end

  def play_again
    puts "Play again? (y/n)"
    input = gets.chomp.downcase
    input == 'y' ? TicTacToe.new.play : abort
  end

  def player_move
    puts "Please select an open number between 1 and 9."
    @move = gets.chomp
    @turn1 = @move if @turn_num == 0
    if @board.free_space?(@move)
      @board.update_space(@move, @player)
      @turn_num += 1
    else
      invalid
      player_move
    end  
  end

  def computer_move
    move = @board.free_spaces.sample
    @board.update_space(move, @computer)
    move
    @turn_num += 1
  end

  def winner
    @turn_num.odd? ? @player : @computer
  end

  def win?
    @board.win?
  end

  def tie?
    @board.tie?
  end

end
