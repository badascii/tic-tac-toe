class Game

  X = 1
  O = 2

  WIN_CONDITIONS = [
  ["a1", "a2", "a3"], #   vertical win 0
  ["b1", "b2", "b3"], #   vertical win 1
  ["c1", "c2", "c3"], #   vertical win 2
  ["a1", "b1", "c1"], # horizontal win 3
  ["a2", "b2", "c2"], # horizontal win 4
  ["a3", "b3", "c3"], # horizontal win 5
  ["a1", "b2", "c3"], #   diagonal win 6
  ["a3", "b2", "c1"]  #   diagonal win 7
  ]

  POSITION_REGEX_REVERSE = /[1-3][abc]/
  POSITION_REGEX         = /[abc][1-3]/

  def initialize
    puts "\nWelcome!"
    @grid = {"a1" => 0, "b1" => 0, "c1" => 0,
             "a2" => 0, "b2" => 0, "c2" => 0,
             "a3" => 0, "b3" => 0, "c3" => 0 }
    @player_mark = X
    @cpu_mark    = O
  end

  def run
    print_legend
    until game_over?
      player_input
      print_grid
      cpu_turn unless grid_full?
      print_grid unless grid_full?
    end
    results
    exit
  end

  private

  def print_legend
    puts "\n     A    B    C"
    puts
    print "1    A1 | B1 | C1"
    print "\n    --------------\n"
    print "2    A2 | B2 | C2"
    print "\n    --------------\n"
    print "3    A3 | B3 | C3"
    puts
    puts "\n     A    B    C"
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

  def print_mark(value)
    return "X" if value == X
    return "O" if value == O
    " "
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

  def game_over?
    grid_full? || win?(@player_mark) || win?(@cpu_mark)
  end

  def grid_empty?(position)
    @grid[position] == 0
  end

  def vertical_win?(mark)
    three_in_a_row?(mark, WIN_CONDITIONS[0]) || three_in_a_row?(mark, WIN_CONDITIONS[1]) || three_in_a_row?(mark, WIN_CONDITIONS[2])
  end

  def horizontal_win?(mark)
    three_in_a_row?(mark, WIN_CONDITIONS[3]) || three_in_a_row?(mark, WIN_CONDITIONS[4]) || three_in_a_row?(mark, WIN_CONDITIONS[5])
  end

  def diagonal_win?(mark)
    three_in_a_row?(mark, WIN_CONDITIONS[6]) || three_in_a_row?(mark, WIN_CONDITIONS[7])
  end

  def three_in_a_row?(mark, win_condition)
    (@grid[win_condition[0]] == mark) && (@grid[win_condition[1]] == mark) && (@grid[win_condition[2]] == mark)
  end

  def win?(mark)
    vertical_win?(mark) || horizontal_win?(mark) || diagonal_win?(mark)
  end

  def grid_full?
    !@grid.has_value?(0)
  end

  def player_input
    print "\nPlease enter the letter and number of an open position: "

    position = get_formatted_position
    if valid_position_format?(position)
      if @grid[position] == 0
        @grid[position] = @player_mark
      else
        print "\nInvalid player_input. That position is taken.\n"
        player_input
      end
    else
      print "\nInvalid player_input. That is not a valid position.\n"
      player_input
    end
  end

  def get_formatted_position
    position = gets.downcase.chomp!
    position.reverse! if position =~ POSITION_REGEX_REVERSE
    position
  end

  def valid_position_format?(position)
    (position =~ POSITION_REGEX) || (position =~ POSITION_REGEX_REVERSE)
  end

  def cpu_turn
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
    if grid_empty?("b1") && grid_empty?("b3")
      @grid["b1"] = @cpu_mark
    elsif grid_empty?("a2") && grid_empty?("c2")
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
    (@grid["b2"] == @cpu_mark) && (corner_positions.uniq.count == 2) && (side_positions.uniq.count == 3)
  end

  def opening_move
    if grid_empty?("b2")
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
        open_space = true if grid_empty?(position)
        occupied_spaces << position if @grid[position] == mark
      end
      if occupied_spaces.length == 2 && open_space == true
        move = condition - occupied_spaces
        return move.first
      end
    end
      return move
  end
end

game = Game.new

game.run
