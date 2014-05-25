class Game

# blank = 0
  X = 1
  O = 2
  GRID = {a1: 0, b1: 0, c1: 0,
          a2: 0, b2: 0, c2: 0,
          a3: 0, b3: 0, c3: 0 }

  LEGEND = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"]]

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
    puts
    print "1   #{@grid[:a1]} | #{@grid[:b1]} | #{@grid[:c1]} \n"
    print "   -----------\n"
    print "2   #{@grid[:a2]} | #{@grid[:b2]} | #{@grid[:c2]} \n"
    print "   -----------\n"
    print "3   #{@grid[:a3]} | #{@grid[:b3]} | #{@grid[:c3]} \n"
    puts
    puts "    A   B   C"
  end

  def run
    print_legend
    until game_over?
      print "\nYour turn. Enter a position to place your move there: "
      @grid = @player.input(@grid)
      print_grid
    end
  end

  def game_over?
  end
end

class Player
  def initialize
    @mark = 1
  end

  def input(grid)
    position = gets.downcase.chomp!
    if (position !~ /[abc][1-3]/) && (position !~ /[1-3][abc]/)
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
      input(grid)
    elsif (grid[position.to_sym] != 0) && (grid[position.reverse.to_sym] != 0)
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
      input(grid)
    else
      grid[position] = @mark
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
