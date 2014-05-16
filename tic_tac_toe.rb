# 0 = empty
# 1 = X
# 2 = O

class Game

  X = 1
  O = 2
  VALID_INPUT = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  def initialize
    puts "\nWelcome!"
    @grid = Game.grid
    @player_mark = self.choose_mark
    @cpu_mark = "O"
  end

  def self.grid
    return [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  end

  def self.print_legend
    puts "\nGrid Legend\n"
    legend = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    legend.each do |row|
      row.each do |position|
        print "|" + position + "|"
      end
      puts
    end
  end

  def print_grid(grid)
    grid.each do |row|
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
    print "\nEnter either X or O and press enter to play using that mark: "
    player_input = gets.downcase.chomp!
    case player_input
    when "x"
      puts "\nYou have chosen X.\n"
      return X
    when "o"
      puts "\nYou have chosen O.\n"
      return O
    else
      print "Invalid entry. Please enter either X or O and press enter: "
      self.choose_mark
    end
  end

  def player_input
    if @player_mark == 1
      player = "X"
    else
      player = "O"
    end
    print "\nEnter a number from 1-9 to place an #{player} there: "
    Integer(gets) rescue nil
  end

  def check_invalid_move(grid_position)
    if (grid_position == X) || (grid_position == O)
      puts "That position is already taken. Please select a different one."
      self.player_input
    else
      return
    end
  end

  def place_move(input_integer, mark)
    case input_integer
    when 1
      self.check_invalid_move(@grid[0][0])
      @grid[0][0] = mark
      return @grid
    when 2
      self.check_invalid_move(@grid[0][1])
      @grid[0][1] = mark
      return @grid
    when 3
      self.check_invalid_move(@grid[0][2])
      @grid[0][2] = mark
      return @grid
    when 4
      self.check_invalid_move(@grid[1][0])
      @grid[1][0] = mark
      return @grid
    when 5
      self.check_invalid_move(@grid[1][1])
      @grid[1][1] = mark
      return @grid
    when 6
      self.check_invalid_move(@grid[1][2])
      @grid[1][2] = mark
      return @grid
    when 7
      self.check_invalid_move(@grid[2][0])
      @grid[2][0] = mark
      return @grid
    when 8
      self.check_invalid_move(@grid[2][1])
      @grid[2][1] = mark
      return @grid
    when 9
      self.check_invalid_move(@grid[2][2])
      @grid[2][2] = mark
      return @grid
    else
      puts "\nInvalid entry. Please enter an integer from 1-9."
      self.player_input
    end
  end

  def check_horizontal(mark)
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

  def check_vertical(mark)
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

  def check_diagonal(mark)
    if (@grid[0][0] == mark) && (@grid[1][1] == mark) && (@grid[2][2] == mark)
      return true
    elsif (@grid[0][2] == mark) && (@grid[1][1] == mark) && (@grid[2][0] == mark)
      return true
    else
      return false
    end
  end

  def grid_full?
    return true unless (@grid[0].include?(0) || @grid[1].include?(0) || @grid[2].contain?(0))
    return false
  end

  def game_over?
    return true if self.check_for_winner == (@player_mark || @cpu_mark)
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
    if self.check_horizontal(@player_mark) || self.check_vertical(@player_mark) || self.check_diagonal(@player_mark)
      return @player_mark
    elsif self.check_horizontal(@cpu_mark) || self.check_vertical(@cpu_mark) || self.check_diagonal(@cpu_mark)
      return @cpu_mark
    else
      return false
    end
  end

  def run
    Game.print_legend
    until self.game_over?
      self.place_move(self.player_input, @player_mark)
      self.print_grid(@grid)
    end
    self.print_results
  end
end

game = Game.new

game.run
