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
                    ["a3", "b3", "c3"],
                    ["a1", "b2", "c3"],
                    ["a3", "b2", "c1"]]

  LEGEND = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"]]

  def initialize
    puts "\nWelcome!"
    @grid = GRID
    @cpu = Cpu.new
    @player_mark = X
    @cpu_mark = O
  end

  def print_legend
    # puts "\nGrid Legend"
    # puts "-----------\n"
    # LEGEND.each do |row|
    #   row.each do |position|
    #     print "|" + position + "|"
    #   end
    #   puts
    #   puts
    # end
    puts "\n     A    B    C"
    puts
    print "1    " + "A1" + " | " + "B1" + " | " + "C1"
    print "\n    --------------\n"
    print "2    " + "A2" + " | " + "B2" + " | " + "C2"
    print "\n    --------------\n"
    print "3    " + "A3" + " | " + "B3" + " | " + "C3"
    puts
    puts "\n     A    B    C"

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
      if position =~ /[1-3][abc]/
        position.reverse!
      end
      @grid[position] = @player_mark
    end
  end

  def cpu_turn
    if grid_full?
      return nil
    end
    puts "Computer is thinking..."
    sleep 2
    win  = cpu_check_for_win(@cpu_mark)
    loss = cpu_check_for_win(@player_mark)
    if @grid.values.uniq.length == 2
      opening_move
    elsif win
      @grid[win] = @cpu_mark
    elsif loss
      @grid[loss] = @cpu_mark
    elsif side_defense?
      place_side_defense
    elsif opposite_corners?
      @grid["a2"] = @cpu_mark
    elsif
      optimal_move
    end
    puts "\n\nCPU turn:\n"
    print_grid
  end

  def optimal_move
    if @grid["b1"] == 0 && @grid["b3"] == 0
      @grid["b1"] = @cpu_mark
    elsif @grid["a2"] && @grid["c2"] == 0
      @grid["c2"] = @cpu_mark
    else
      @grid.each do |key, value|
        if value == 0
          @grid[key] = @cpu_mark
          return
        end
      end
    end
  end

  def side_defense?
    corner_positions = [@grid["a1"], @grid["a3"], @grid["c1"], @grid["c3"]]
    side_positions = [@grid["a2"], @grid["b1"], @grid["b3"], @grid["c2"]]
    if @grid["b2"] == @cpu_mark && corner_positions.uniq.count == 2 && side_positions.uniq.count == 3
      return true
    end
    return false
  end

  def opening_move
    if @grid["b2"] == 0
      @grid["b2"] = @cpu_mark
    else
      @grid["a1"] = @cpu_mark
    end
  end

  def opposite_corners?
    if (@grid["a1"] == @player_mark && @grid["c3"] == @player_mark) #|| (@grid["a3"] == @player_mark && @grid["c1"] == @player_mark)
      return true
    end
    return false
  end

  def place_side_defense
    if @grid["a2"] == 0
      @grid["a2"] = @cpu_mark
    elsif @grid["b1"] == 0
      @grid["b1"] = @cpu_mark
    elsif @grid["b3"] == 0
      @grid["b3"] == @cpu_mark
    elsif @grid["b2"] == 0
      @grid["c2"] == @cpu_mark
    end
  end

  def cpu_check_for_win(mark)
    move = nil
    WIN_CONDITIONS.each do |condition|
      occupied_spaces = []
      open_space = false
      condition.each do |position|
        open_space = true if @grid[position] == 0
        occupied_spaces << position if @grid[position] == mark
      end
      if occupied_spaces.length == 2 && open_space == true
        move = condition - occupied_spaces
        return move.first
      end
    end
    return move
  end

  def vertical_win?(mark)
    # if all a, all b, or all c keys are == X or O, return winner
    # return true if @grid["a1"] == mark && @grid["a2"] == mark && @grid["a3"] == mark
    # return true if @grid["b1"] == mark && @grid["b2"] == mark && @grid["b3"] == mark
    # return true if @grid["c1"] == mark && @grid["c2"] == mark && @grid["c3"] == mark
    return true if three_in_a_row?(mark, "a1", "a2", "a3")
    return true if three_in_a_row?(mark, "b1", "b2", "b3")
    return true if three_in_a_row?(mark, "c1", "c2", "c3")
    return false
  end

  def horizontal_win?(mark)
    # if all 1, all 2, or all 3 keys are == X or O, return winner
    # return true if @grid["a1"] == mark && @grid["b1"] == mark && @grid["c1"] == mark
    # return true if @grid["a2"] == mark && @grid["b2"] == mark && @grid["c2"] == mark
    # return true if @grid["a3"] == mark && @grid["b3"] == mark && @grid["c3"] == mark
    return true if three_in_a_row?(mark, "a1", "b1", "c1")
    return true if three_in_a_row?(mark, "a2", "b2", "c2")
    return true if three_in_a_row?(mark, "a3", "b3", "c3")
    return false
  end

  def diagonal_win?(mark)
    # if a1, b2, c3 or a3, b2, c1 are == X or O, return winner
    # return true if @grid["a1"] == mark && @grid["b2"] == mark && @grid["c3"] == mark
    # return true if @grid["a3"] == mark && @grid["b2"] == mark && @grid["c1"] == mark
    return true if three_in_a_row?(mark, "a1", "b2", "c3")
    return true if three_in_a_row?(mark, "a3", "b2", "c1")
    return false

  end

  def three_in_a_row?(mark, position_1, position_2, position_3)
    return true if @grid[position_1] == mark && @grid[position_2] ==  mark && @grid[position_3] == mark
  end

  def check_win?(mark)
    vertical_win?(mark) || horizontal_win?(mark) || diagonal_win?(mark)
  end

  def win?
    check_win?(@player_mark) || check_win?(@cpu_mark)
  end

  def game_over?
    return true if grid_full? || win?
    return false
  end

  def run
    print_legend
    until game_over?
      input
      print_grid
      cpu_turn
    end
    results
    exit
  end

  def results
    if check_win?(@player_mark)
      puts "\nCongratulations! You win!\n"
    elsif check_win?(@cpu_mark)
      puts "\nYou lose. Really?\n"
    else
      puts "\nStalemate.\n"
    end
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
