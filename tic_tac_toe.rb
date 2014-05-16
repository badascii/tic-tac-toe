# 0 = empty
# 1 = X
# 2 = O

class Game

  X = 1
  O = 2

  def initialize
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
      print "Invalid input. Please enter either X or O and press enter: "
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
    player_turn = gets.chomp!
    if player_turn =~ /[1-9]/
      return player_turn
    else
      puts "Invalid entry. Please enter a number from 1-9."
      self.player_input
    end
  end

  def place_move(grid_location)
    case grid_location
    when "1"
      @grid[0][0] = @player_mark
      return @grid
    when "2"
      @grid[0][1] = @player_mark
      return @grid
    when "3"
      @grid[0][2] = @player_mark
      return @grid
    when "4"
      @grid[1][0] = @player_mark
      return @grid
    when "5"
      @grid[1][1] = @player_mark
      return @grid
    when "6"
      @grid[1][2] = @player_mark
      return @grid
    when "7"
      @grid[2][0] = @player_mark
      return @grid
    when "8"
      @grid[2][1] = @player_mark
      return @grid
    when "9"
      @grid[2][2] = @player_mark
      return @grid
    else
      puts "Invalid entry. Please enter a number from 1-9."
      self.player_input
      self.place_move(grid_location, @player_mark)
    end
  end

  def check_horizontal(mark)
    @grid.each do |row|
      current_row = []
      row.each do |m|
        current_row << m
      end
      if current_row.uniq.length == 1
        return true
      else
        return false
      end
    end
  end

  def check_vertical(mark)
    if ((@grid[0][0] && @grid[1][0] && @grid[2][0]) || (@grid[0][1] && @grid[1][1] && @grid[2][1]) || (@grid[0][2] && @grid[1][2] && @grid[2][2])) == mark
      return true
    else
      return false
    end
  end

  def check_diagonal(mark)
    if ((@grid[0][0] && @grid[1][1] && @grid[2][2]) || (@grid[0][2] && @grid[1][1] && @grid[2][0])) == mark
      return true
    else
      return false
    end
  end

  def game_over?
    return true unless (@grid[0].include?(0) || @grid[1].include?(0) || @grid[2].contain?(0))
    return false
  end

  def check_for_winner
    if self.check_horizontal(@player_mark) || self.check_vertical(@player_mark) || self.check_diagonal(@player_mark)
      puts "You win!!!"
    elsif self.check_horizontal(@cpu_mark) || self.check_vertical(@cpu_mark) || self.check_diagonal(@cpu_mark)
      puts "CPU beat ya. Really?"
    else
      puts "Stalemate!"
    end
  end

  def run
    Game.print_legend
    unless game_over?
      self.place_move(self.player_input)
      self.print_grid(@grid)
    end
    self.check_for_winner
  end
end

game = Game.new

game.run

