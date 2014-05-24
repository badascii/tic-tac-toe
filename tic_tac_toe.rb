class Game

# blank = 0
  X = 1
  O = 2
  GRID = {a1: 0, a2: 0, a3: 0,
          b1: 0, b2: 0, b3: 0,
          c1: 0, c2: 0, c3: 0 }

  LEGEND = [["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]]

  def initialize
    puts "\nWelcome!"
    @grid = GRID
    @player = Player.new
    @cpu = Cpu.new
    @player_mark = "X"
    @cpu_mark = "O"
  end

  def print_legend
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
    @grid.each do |position, state|
      case state
      when X
        print "|" + "X" + "|"
      when O
        print "|" + "O" + "|"
      else
        print "|" + "_" + "|"
      end
    end
    puts
  end

  def run
    until game_over?
      @player.input(@grid)
      print_grid
    end
  end

  def game_over?
  end
end

class Player
  def initialize
    @mark = "X"
  end

  def input(grid)
    print "\nYour turn. Enter a position to place your move there: "
    position = gets.downcase.chomp!
    if position !~ /[a-c][1-3]/
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
      input
    elsif grid[position.to_sym] != 0
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
    else
      grid[position] = @player_mark
      return grid
    end
  end

end

class Cpu
  def initialize
    @mark = "O"
  end
end

game = Game.new

game.run
