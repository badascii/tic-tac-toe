# 0 = empty
# 1 = X
# 2 = O

class Game

  X = 1
  O = 2
  VALID_INPUT = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  LEGEND = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]

  def initialize
    puts "\nWelcome!"
    @grid = Game.grid
    choose_mark
    if @player_mark = X
      @cpu_mark = O
    else
      @cpu_mark = X
    end
  end

  def self.grid
    return [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  end

  def self.print_legend
    puts "\nGrid Legend"
    puts "-----------\n"
    LEGEND.each do |row|
      row.each do |position|
        print "|" + position + "|"
      end
      puts
    end
  end

  def print_grid
    puts
    @grid.each do |row|
      row.each do |position|
        case position
        when X
          print "|X|"
        when O
          print "|O|"
        else
          print "|_|"
        end
      end
      puts
    end
  end

  def choose_mark
    print "\nWhich mark would you like to play as? Select X or O and press enter: "
    player_input = gets.downcase.chomp!
    case player_input
    when "x"
      puts "\nYou have chosen X.\n"
      @player_mark = X
    when "o"
      puts "\nYou have chosen O.\n"
      @player_mark = O
    else
      print "Invalid entry. Please enter either X or O and press enter: "
      choose_mark
    end
  end

  def player_input
    if @player_mark == X
      player = "X"
    else
      player = "O"
    end
    print "\nYour turn. Enter a number from 1-9 to place an #{player} there: "
    Integer(gets) rescue nil
  end

  def check_invalid_move(grid_position)
    if (grid_position == X) || (grid_position == O)
      puts "\nThat position is already taken. Please select a different one."
      self.player_input
    else
      return nil
    end
  end

  def place_move(input_integer, mark)
    case input_integer
    when 1
      check_invalid_move(@grid[0][0])
      @grid[0][0] = mark
    when 2
      check_invalid_move(@grid[0][1])
      @grid[0][1] = mark
    when 3
      check_invalid_move(@grid[0][2])
      @grid[0][2] = mark
    when 4
      check_invalid_move(@grid[1][0])
      @grid[1][0] = mark
    when 5
      check_invalid_move(@grid[1][1])
      @grid[1][1] = mark
    when 6
      check_invalid_move(@grid[1][2])
      @grid[1][2] = mark
    when 7
      check_invalid_move(@grid[2][0])
      @grid[2][0] = mark
    when 8
      check_invalid_move(@grid[2][1])
      @grid[2][1] = mark
    when 9
      check_invalid_move(@grid[2][2])
      @grid[2][2] = mark
    else
      puts "\nInvalid entry. Please enter an integer from 1-9."
      player_input
    end
  end

  def space_taken?

  end

  def cpu_turn
    if @grid[1][1] == 0
      @grid[1][1] = @cpu_mark
    else
      cpu_defend
    end
    puts "\nComputer turn:\n"
  end

  #  |1||2||3|
  #  |4||5||6|
  #  |7||8||9|
  #
  #  [0][0] [0][1] [0][2]

  #  [1][0] [1][1] [1][2]

  #  [2][0] [2][1] [2][2]

  def cpu_defend
    if check_position_1
      return
    elsif check_position_2

    elsif check_position_3

    elsif check_position_4

    elsif check_position_6

    elsif check_position_7

    elsif check_position_8

    elsif check_position_9
      return
    else
      cpu_place_move
    end
  end

  def cpu_place_move

  end

  def check_position_1
    if @grid[0][0] == 0
      if (@grid[0][1] == @grid[0][2]) && (@grid[0][1] != 0)
        @grid[0][0] = @cpu_mark
      elsif (@grid[1][1] == @grid[2][2]) && (@grid[1][1] != 0)
        @grid[0][0] = @cpu_mark
      elsif (@grid[1][0] == @grid[2][0]) && (@grid[1][0] != 0)
        @grid[0][0] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_2
    if @grid[0][1] == 0
      if (@grid[0][0] == @grid[0][2]) && (@grid[0][2] != 0)
        @grid[0][1] = @cpu_mark
      elsif (@grid[1][1] == @grid[2][1]) && (@grid[2][1] != 0)
        @grid[0][1] = @cpu_mark
      elsif (@grid[1][0] == @grid[2][0]) && (@grid[1][0] != 0)
        @grid[0][1] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_3
    if @grid[0][2] == 0
      if (@grid[0][0] == @grid[0][1]) && (@grid[0][1] != 0)
        @grid[0][2] = @cpu_mark
      elsif (@grid[1][1] == @grid[2][0]) && (@grid[2][0] != 0)
        @grid[0][2] = @cpu_mark
      elsif (@grid[1][2] == @grid[2][2]) && (@grid[1][2] != 0)
        @grid[0][2] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_4
    if @grid[1][0] == 0
      if (@grid[0][0] == @grid[2][0]) && (@grid[2][0] != 0)
        @grid[1][0] = @cpu_mark
      elsif (@grid[1][1] == @grid[1][2]) && (@grid[1][2] != 0)
        @grid[1][0] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_6
    if @grid[1][2] == 0
      if (@grid[0][2] == @grid[2][2]) && (@grid[0][2] != 0)
        @grid[1][2] = @cpu_mark
      elsif (@grid[1][0] == @grid[1][1]) && (@grid[1][0] != 0)
        @grid[1][2] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_7
    if @grid[2][0] == 0
      if (@grid[0][0] == @grid[1][0]) && (@grid[1][0] != 0)
        @grid[2][0] = @cpu_mark
      elsif (@grid[2][1] == @grid[2][2]) && (@grid[2][1] != 0)
        @grid[2][0] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_8
    if @grid[2][1] == 0
      if (@grid[0][1] == @grid[1][1]) && (@grid[0][1] != 0)
        @grid[2][1] = @cpu_mark
      elsif (@grid[2][0] == @grid[2][2]) && (@grid[2][0] != 0)
        @grid[2][1] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_position_9
    if @grid[2][2] == 0
      if (@grid[0][2] == @grid[1][2]) && (@grid[0][2] != 0)
        @grid[2][2] = @cpu_mark
      elsif (@grid[2][0] == @grid[2][1]) && (@grid[2][0] != 0)
        @grid[2][2] = @cpu_mark
      else
        return false
      end
    end
  end

  def check_horizontal_victory(mark)
    if (@grid[0][0] == mark) && (@grid[0][1] == mark) && (@grid[0][2] == mark)
      return true
    elsif (@grid[1][0] == mark) && (@grid[1][1] == mark) && (@grid[1][2] == mark)
      return true
    elsif (@grid[2][0] == mark) && (@grid[2][1] == mark) && (@grid[2][2] == mark)
      return true
    else
      return false
    end
  end

  def check_vertical_victory(mark)
    if (@grid[0][0] == mark) && (@grid[1][0] == mark) && (@grid[2][0] == mark)
      return true
    elsif (@grid[0][1] == mark) && (@grid[1][1] == mark) && (@grid[2][1] == mark)
      return true
    elsif (@grid[0][2] == mark) && (@grid[1][2] == mark) && (@grid[2][2] == mark)
      return true
    else
      return false
    end
  end

  def check_diagonal_victory(mark)
    if (@grid[0][0] == mark) && (@grid[1][1] == mark) && (@grid[2][2] == mark)
      return true
    elsif (@grid[0][2] == mark) && (@grid[1][1] == mark) && (@grid[2][0] == mark)
      return true
    else
      return false
    end
  end

  def grid_full?
    return true unless (@grid[0].include?(0) || @grid[1].include?(0) || @grid[2].include?(0))
    return false
  end

  def game_over?
    return true if check_for_winner == (@player_mark || @cpu_mark)
    return true if grid_full?
    return false
  end

  def print_results
    if self.check_for_winner == @player_mark
      puts "\nYou win!\n\nCongratulations!!!\n\n"
    elsif self.check_for_winner == @cpu_mark
      puts "\nYou lose.\n\nlol\n"
    else
      puts "\nStalemate!\n\nToo bad, so sad.\n"
    end
  end

  def check_for_winner
    if check_horizontal_victory(@player_mark) || check_vertical_victory(@player_mark) || check_diagonal_victory(@player_mark)
      return @player_mark
    elsif check_horizontal_victory(@cpu_mark) || check_vertical_victory(@cpu_mark) || check_diagonal_victory(@cpu_mark)
      return @cpu_mark
    else
      return
    end
  end

def run
  Game.print_legend
  until game_over?
    place_move(player_input, @player_mark)
    print_grid
    cpu_turn
    print_grid
  end
  print_results
end

end

game = Game.new

game.run
