class Game

  X = 1
  O = 2
  GRID = {"a1" => 0, "b1" => 0, "c1" => 0,
          "a2" => 0, "b2" => 0, "c2" => 0,
          "a3" => 0, "b3" => 0, "c3" => 0 }

  WIN_CONDITIONS = [
  ["a1", "a2", "a3"], #   vertical win
  ["b1", "b2", "b3"], #   vertical win
  ["c1", "c2", "c3"], #   vertical win
  ["a1", "b1", "c1"], # horizontal win
  ["a2", "b2", "c2"], # horizontal win
  ["a3", "b3", "c3"], # horizontal win
  ["a1", "b2", "c3"], #   diagonal win
  ["a3", "b2", "c1"]  #   diagonal win
  ]

  def initialize
    puts "\nWelcome!"
    @grid = GRID
    @player_mark = X
    @cpu_mark = O
  end

  def print_legend
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

  def print_mark(value)
    case value
    when X
      "X"
    when O
      "O"
    else
      " "
    end
  end

  def print_grid
    puts "\n     A   B   C"
    puts
    print "1    " + print_mark(@grid["a1"]) + " | " + print_mark(@grid["b1"]) + " | " + print_mark(@grid["c1"])
    print "\n    -----------\n"
    print "2    " + print_mark(@grid["a2"]) + " | " + print_mark(@grid["b2"]) + " | " + print_mark(@grid["c2"])
    print "\n    -----------\n"
    print "3    " + print_mark(@grid["a3"]) + " | " + print_mark(@grid["b3"]) + " | " + print_mark(@grid["c3"])
    puts
    puts "\n     A   B   C"
  end

  def player_input
    print "\nPlease enter the letter and number of an open position: "
    position = gets.downcase.chomp!
    if (position !~ /[abc][1-3]/) && (position !~ /[1-3][abc]/)
      print "\nInvalid player_input. That is not a valid position.\n"
      player_input
    elsif (@grid[position] != 0) && (@grid[position.reverse] != 0)
      print "\nInvalid player_input. That position is taken.\n"
      player_input
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
    puts "\nComputer is thinking..."
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
    else
      optimal_move
    end
    puts "\nCPU turn:\n"
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
          break
        end
      end
    end
  end

  def side_defense?
    corner_positions = [@grid["a1"], @grid["a3"], @grid["c1"], @grid["c3"]]
    side_positions = [@grid["a2"], @grid["b1"], @grid["b3"], @grid["c2"]]
    @grid["b2"] == @cpu_mark && corner_positions.uniq.count == 2 && side_positions.uniq.count == 3
  end

  def opening_move
    if @grid["b2"] == 0
      @grid["b2"] = @cpu_mark
    else
      @grid["a1"] = @cpu_mark
    end
  end

  # CPU check for player opening in 2 opposite corners
  def opposite_corners?
    (@grid["a1"] == @player_mark && @grid["c3"] == @player_mark) || (@grid["a3"] == @player_mark && @grid["c1"] == @player_mark)
  end

  # CPU defense against specific opening moves
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
    three_in_a_row?(mark, "a1", "a2", "a3") || three_in_a_row?(mark, "b1", "b2", "b3") || three_in_a_row?(mark, "c1", "c2", "c3")
  end

  def horizontal_win?(mark)
    three_in_a_row?(mark, "a1", "b1", "c1") || three_in_a_row?(mark, "a2", "b2", "c2") || three_in_a_row?(mark, "a3", "b3", "c3")
  end

  def diagonal_win?(mark)
    three_in_a_row?(mark, "a1", "b2", "c3") || three_in_a_row?(mark, "a3", "b2", "c1")
  end

  def three_in_a_row?(mark, position_1, position_2, position_3)
    @grid[position_1] == mark && @grid[position_2] == mark && @grid[position_3] == mark
  end

  def win?(mark)
    vertical_win?(mark) || horizontal_win?(mark) || diagonal_win?(mark)
  end

  def grid_full?
    !@grid.has_value?(0)
  end

  def game_over?
    grid_full? || win?(@player_mark) || win?(@cpu_mark)
  end

  def run
    print_legend
    until game_over?
      player_input
      print_grid
      cpu_turn
      print_grid
    end
    results
    exit
  end

  def results
    if win?(@player_mark)
      puts "\nCongratulations! You win!\n\n"
    elsif win?(@cpu_mark)
      puts "\nYou lose. Really?\n\n"
    else
      puts "\nStalemate.\n\n"
    end
  end
end

game = Game.new

game.run
