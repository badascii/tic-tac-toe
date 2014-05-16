# 0 = empty
# 1 = X
# 2 = O

class Game

  X = 1
  O = 2

  def initialize
    @grid = Game.grid
    @player_symbol = self.choose_symbol
  end

  def self.grid
    return [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  end

  def self.print_legend
    puts "Grid Legend\n"

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

  def choose_symbol
    print "Enter X or O and press enter to play using that symbol: "
    player_input = gets.downcase.chomp!

    case player_input
    when "x"
      puts "You have chosen X"
      return X
    when "o"
      puts "You have chosen O"
      return O
    else
      print "Invalid input. Please enter either X or O and press enter: "
      self.choose_symbol
    end
  end

  def player_input
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
      @grid[0][0] = @player_symbol
      return @grid
    when "2"
      @grid[0][1] = @player_symbol
      return @grid
    when "3"
      @grid[0][2] = @player_symbol
      return @grid
    when "4"
      @grid[1][0] = @player_symbol
      return @grid
    when "5"
      @grid[1][1] = @player_symbol
      return @grid
    when "6"
      @grid[1][2] = @player_symbol
      return @grid
    when "7"
      @grid[2][0] = @player_symbol
      return @grid
    when "8"
      @grid[2][1] = @player_symbol
      return @grid
    when "9"
      @grid[2][0] = @player_symbol
      return @grid
    else
      puts "Invalid entry. Please enter a number from 1-9."
      self.player_input
      self.place_move(grid_location, @player_symbol)
    end
  end

  def run
    Game.print_legend

    while @grid[0].include?(0) || @grid[1].include?(0) || @grid[2].include?(0)
      puts "\nEnter a number from 1-9 to place your move on position: "
      player_action = self.player_input
      self.place_move(player_action)
      self.print_grid(@grid)
    end
  end

end

game = Game.new

game.run

