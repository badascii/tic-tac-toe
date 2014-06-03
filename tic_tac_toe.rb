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
    @cpu = Cpu.new
    @player_mark = X
    @cpu_mark = O
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

  def print_marker(value)
    case value
    when X
      return "X"
    when O
      return "O"
    else
      return " "
    end
  end

  def print_grid
    puts "\n     A   B   C"
    puts
    print "1    " + print_marker(@grid[:a1]) + " | " + print_marker(@grid[:b1]) + " | " + print_marker(@grid[:c1])
    print "\n    -----------\n"
    print "2    " + print_marker(@grid[:a2]) + " | " + print_marker(@grid[:b2]) + " | " + print_marker(@grid[:c2])
    print "\n    -----------\n"
    print "3    " + print_marker(@grid[:a3]) + " | " + print_marker(@grid[:b3]) + " | " + print_marker(@grid[:c3])
    puts
    puts "\n     A   B   C"
  end

  def input
    position = gets.downcase.chomp!
    if (position !~ /[abc][1-3]/) && (position !~ /[1-3][abc]/)
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
      input
    elsif (@grid[position.to_sym] != 0) && (@grid[position.reverse.to_sym] != 0)
      print "\nInvalid input. Please enter the letter and number of an open position and press enter: "
      input
    else
      @grid[position.to_sym] = @player_mark
    end
  end

  def cpu_turn
    if @grid[:b2] == 0
      @grid[:b2] = @cpu_mark
    else
      check_for_win
      prevent_loss
    end
    puts "\n\nCPU turn:\n\n"
    print_grid
  end

  def check_for_win
      # if all a, all b, or all c keys are == 1 or 2, return winner
      # if all 1, all 2, or all 3 keys are == 1 or 2, return winner
      # if a1, b2, c3 or a3, b2, c1 are == 1 or 2, return winner
  end

  def run
    print_legend
    until game_over?
      print "\nYour turn. Enter a position (1A, B2, 3C etc) to place your move there: "
      input
      print_grid
      cpu_turn
    end
  end

  def game_over?
    return true if grid_full?
  end

  def grid_full?
    return false if @grid.contains?(0)
    return true
  end
end



class Cpu
  def initialize
    @mark = "O"
  end
end

game = Game.new

game.run
