class Game

# blank = 0
  X = 1
  O = 2
  GRID = {"a1" => 0, "b1" => 0, "c1" => 0,
          "a2" => 0, "b2" => 0, "c2" => 0,
          "a3" => 0, "b3" => 0, "c3" => 0 }

  # vertical, horizontal, and diagonal win conditions, respectively
  WIN_CONDITIONS = [["a1", "a2", "a3"],
                    ["b1", "b2", "b3"],
                    ["c1", "c2", "c3"],
                    ["a1", "b1", "c1"],
                    ["a2", "b2", "c2"],
                    ["a3", "b3", "c3"]]

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
    print "1    " + print_marker(@grid["a1"]) + " | " + print_marker(@grid["b1"]) + " | " + print_marker(@grid["c1"])
    print "\n    -----------\n"
    print "2    " + print_marker(@grid["a2"]) + " | " + print_marker(@grid["b2"]) + " | " + print_marker(@grid["c2"])
    print "\n    -----------\n"
    print "3    " + print_marker(@grid["a3"]) + " | " + print_marker(@grid["b3"]) + " | " + print_marker(@grid["c3"])
    puts
    puts "\n     A   B   C"
  end

  def input
    print "\nPlease enter the letter and number of an open position: "
    position = gets.downcase.chomp!
    if (position !~ /[abc][1-3]/) && (position !~ /[1-3][abc]/)
      print "\nInvalid input. That is not a valid position.\n"
      input
    elsif (@grid[position] != 0) && (@grid[position.reverse] != 0)
      print "\nInvalid input. That position is taken.\n"
      input
    else
      @grid[position] = @player_mark
    end
  end

  def cpu_turn
    if @grid["b2"] == 0
      @grid["b2"] = @cpu_mark
    elseif cpu_check_for_win.length == 3
      @grid[]
    end
    puts "\n\nCPU turn:\n"
    print_grid
  end

  def cpu_check_for_win
    WIN_CONDITIONS.each do |condition|
      win = []
      condition.each do |position|
        win << position if @grid[position] == @cpu_mark
      end
      return condition if win.length == 2
    end
  end

  def cpu_check_for_loss
  end

  def cpu_check_horizontal
  end

  def cpu_check_diagonal
  end

  def vertical_win?(mark)
    # if all a, all b, or all c keys are == X or O, return winner
    return true if @grid["a1"] == mark && @grid["a2"] == mark && @grid["a3"] == mark
    return true if @grid["b1"] == mark && @grid["b2"] == mark && @grid["b3"] == mark
    return true if @grid["c1"] == mark && @grid["c2"] == mark && @grid["c3"] == mark
  end

  def horizontal_win?(mark)
    # if all 1, all 2, or all 3 keys are == X or O, return winner
    return true if @grid["a1"] == mark && @grid["b1"] == mark && @grid["c1"] == mark
    return true if @grid["a2"] == mark && @grid["b2"] == mark && @grid["c2"] == mark
    return true if @grid["a3"] == mark && @grid["b3"] == mark && @grid["c3"] == mark
  end

  def diagonal_win?(mark)
    # if a1, b2, c3 or a3, b2, c1 are == X or O, return winner
    return true if @grid["a1"] == mark && @grid["b2"] == mark && @grid["c3"] == mark
    return true if @grid["a3"] == mark && @grid["b2"] == mark && @grid["c1"] == mark
  end

  def player_win?
    vertical_win?(@player_mark)
    horizontal_win?(@player_mark)
    diagonal_win?(@player_mark)
  end

  def cpu_win?
    vertical_win?(@cpu_mark)
    horizontal_win?(@cpu_mark)
    diagonal_win?(@cpu_mark)
  end

  def win?
    player_win?
    cpu_win?
  end

  def run
    print_legend
    until game_over?
      input
      print_grid
      cpu_turn
    end
    results
  end

  def results
    if player_win?
      puts "Congratulations! You win!"
    elsif cpu_win?
      puts "You lose. Really?"
    else
      puts "Stalemate."
    end
  end

  def game_over?
    return true if grid_full? || win?
  end

  def grid_full?
    return false if @grid.has_value?(0)
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
