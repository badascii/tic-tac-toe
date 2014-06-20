class CPU
  def initialize
    @mark = 2 # TODO: Implement Game method to check player's choice
  end

  def turn
    puts "\nComputer is thinking..."
    sleep 2

    win  = check_for_win(@mark)
    loss = check_for_win(@player_mark)

    if @grid.values.uniq.length == 2
      opening_move
    elsif win
      @grid[win] = @mark
    elsif loss
      @grid[loss] = @mark
    elsif side_defense?
      place_side_defense
    elsif opposite_corners?
      @grid["a2"] = @mark
    else
      optimal_move
    end
    puts "\nCPU turn:\n"
  end

  def check_for_win(mark)
    move = nil
    WIN_CONDITIONS.each do |condition|
      occupied_spaces = []
      open_space = false
      condition.each do |position|
        open_space = true if position_empty?(position)
        occupied_spaces << position if @grid[position] == mark
      end
      if occupied_spaces.length == 2 && open_space == true
        move = condition - occupied_spaces
        return move.first
      end
    end
      return move
  end

  def opening_move
    if position_empty?("b2")
      @grid["b2"] = @mark
    else
      @grid["a1"] = @mark
    end
  end

  def optimal_move
    if position_empty?("b1") && position_empty?("b3")
      @grid["b1"] = @mark
    elsif position_empty?("a2") && position_empty?("c2")
      @grid["c2"] = @mark
    else
      @grid.each do |key, value|
        if value == 0
          @grid[key] = @mark
          break
        end
      end
    end
  end

  # Defense against specific opening moves
  def place_side_defense
    if @grid["a2"] == 0
      @grid["a2"] = @mark
    elsif @grid["b1"] == 0
      @grid["b1"] = @mark
    elsif @grid["b3"] == 0
      @grid["b3"] == @mark
    elsif @grid["b2"] == 0
      @grid["c2"] == @mark
    end
  end

  def side_defense?
    corner_positions = [@grid["a1"], @grid["a3"], @grid["c1"], @grid["c3"]]
    side_positions   = [@grid["a2"], @grid["b1"], @grid["b3"], @grid["c2"]]

    (@grid["b2"] == @mark) && (corner_positions.uniq.count == 2) && (side_positions.uniq.count == 3)
  end

  # Checks for player opening in 2 opposite corners
  def opposite_corners?
    (@grid["a1"] == @player_mark && @grid["c3"] == @player_mark) || (@grid["a3"] == @player_mark && @grid["c1"] == @player_mark)
  end
end