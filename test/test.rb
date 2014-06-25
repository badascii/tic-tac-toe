require 'minitest/autorun'
require_relative '../lib/tic_tac_toe.rb'

class TestGame < MiniTest::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_grid
    assert_equal(@game.grid.class, Hash)
    assert_equal(@game.grid.length, 9)
  end

  def test_setting_grid
    @game.grid["a1"] = 1
    assert_equal(@game.grid["a1"], 1)
  end

  def test_marks
    assert(@game.player_mark != @game.cpu_mark)
    assert_equal(@game.player_mark, 1)
    assert_equal(@game.cpu_mark, 2)
  end

  def test_print_mark
    assert_equal(@game.print_mark(0), " ")
    assert_equal(@game.print_mark(1), "X")
    assert_equal(@game.print_mark(2), "O")
  end

  def test_position_empty
    assert(@game.position_empty?("a1"))
    assert(@game.position_empty?("b2"))
    assert(@game.position_empty?("c3"))
  end

  def test_grid_full
    assert(!@game.grid_full?)

    # This code block fills the grid with moves
    @game.grid.keys.each do |position|
      @game.grid[position] = 1
    end
    assert(@game.grid_full?)
  end

  def test_win
    @game.grid.keys.each do |position|
      @game.grid[position] = @game.player_mark
    end
    assert(@game.win?(@game.player_mark))
  end

  def test_vertical_win
    @game.grid["a1"] = @player_mark
    @game.grid["a2"] = @player_mark
    @game.grid["a3"] = @player_mark
    assert(@game.vertical_win?(@player_mark))
    @game.grid["b1"] = @cpu_mark
    @game.grid["b2"] = @cpu_mark
    @game.grid["b3"] = @cpu_mark
    assert(@game.vertical_win?(@cpu_mark))
  end

  def test_horizontal_win
    @game.grid["a1"] = @player_mark
    @game.grid["b1"] = @player_mark
    @game.grid["c1"] = @player_mark
    assert(@game.horizontal_win?(@player_mark))
    @game.grid["a2"] = @cpu_mark
    @game.grid["c2"] = @cpu_mark
    @game.grid["b2"] = @cpu_mark
    assert(@game.horizontal_win?(@cpu_mark))
  end

  def test_diagonal_win
    @game.grid["a1"] = @player_mark
    @game.grid["b2"] = @player_mark
    @game.grid["c3"] = @player_mark
    assert(@game.diagonal_win?(@player_mark))
    @game.grid["a3"] = @player_mark
    @game.grid["b2"] = @player_mark
    @game.grid["c1"] = @player_mark
    assert(@game.diagonal_win?(@cpu_mark))
  end

  def test_three_in_a_row_player
    assert(!@game.three_in_a_row?(@player_mark, ["a1", "a2", "a3"]))
    @game.grid["a1"] = @player_mark
    @game.grid["a2"] = @player_mark
    @game.grid["a3"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["a1", "a2", "a3"]))
    @game.grid["b1"] = @player_mark
    @game.grid["b2"] = @player_mark
    @game.grid["b3"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["b1", "b2", "b3"]))
    @game.grid["c1"] = @player_mark
    @game.grid["c2"] = @player_mark
    @game.grid["c3"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["c1", "c2", "c3"]))
    @game.grid["a1"] = @player_mark
    @game.grid["b1"] = @player_mark
    @game.grid["c1"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["a1", "b1", "c1"]))
    @game.grid["a2"] = @player_mark
    @game.grid["b2"] = @player_mark
    @game.grid["c2"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["a2", "b2", "c2"]))
    @game.grid["a3"] = @player_mark
    @game.grid["b3"] = @player_mark
    @game.grid["c3"] = @player_mark
    assert(@game.three_in_a_row?(@player_mark, ["a3", "b3", "c3"]))
  end

  def test_three_in_a_row_cpu
    assert(!@game.three_in_a_row?(@cpu_mark, ["a1", "a2", "a3"]))
    @game.grid["a1"] = @cpu_mark
    @game.grid["a2"] = @cpu_mark
    @game.grid["a3"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["a1", "a2", "a3"]))
    @game.grid["b1"] = @cpu_mark
    @game.grid["b2"] = @cpu_mark
    @game.grid["b3"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["b1", "b2", "b3"]))
    @game.grid["c1"] = @cpu_mark
    @game.grid["c2"] = @cpu_mark
    @game.grid["c3"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["c1", "c2", "c3"]))
    @game.grid["a1"] = @cpu_mark
    @game.grid["b1"] = @cpu_mark
    @game.grid["c1"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["a1", "b1", "c1"]))
    @game.grid["a2"] = @cpu_mark
    @game.grid["b2"] = @cpu_mark
    @game.grid["c2"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["a2", "b2", "c2"]))
    @game.grid["a3"] = @cpu_mark
    @game.grid["b3"] = @cpu_mark
    @game.grid["c3"] = @cpu_mark
    assert(@game.three_in_a_row?(@cpu_mark, ["a3", "b3", "c3"]))
  end


  def test_cpu_opening_move
    assert_equal(@game.grid["b2"], 0)
    @game.opening_move
    assert_equal(@game.grid["b2"], @game.cpu_mark)
    @game.opening_move
    assert_equal(@game.grid["a1"], @game.cpu_mark)
  end

  def test_cpu_optimal_move
    assert_equal(@game.grid["b1"], 0)
    @game.optimal_move
    assert_equal(@game.grid["b1"], @game.cpu_mark)
    assert_equal(@game.grid["c2"], 0)
    @game.optimal_move
    assert_equal(@game.grid["c2"], @game.cpu_mark)
    @game.grid["b2"] = @game.player_mark
    @game.grid["b3"] = @game.player_mark
    assert_equal(@game.grid["c2"], @game.cpu_mark)
  end

  def test_cpu_place_side_defense
    assert_equal(@game.grid["a2"], 0)
    @game.place_side_defense
    assert_equal(@game.grid["a2"], @game.cpu_mark)
    assert_equal(@game.grid["b1"], 0)
    @game.place_side_defense
    assert_equal(@game.grid["b1"], @game.cpu_mark)
    assert_equal(@game.grid["b3"], 0)
    @game.place_side_defense
    assert_equal(@game.grid["b3"], @game.cpu_mark)
    assert_equal(@game.grid["c2"], 0)
    @game.place_side_defense
    assert_equal(@game.grid["c2"], @game.cpu_mark)
  end

  def test_cpu_side_defense
    assert(!@game.side_defense?)
    @game.grid["a1"] = @game.player_mark
    @game.grid["a2"] = @game.player_mark
    @game.grid["b1"] = @game.cpu_mark
    @game.grid["b2"] = @game.cpu_mark
    assert(@game.side_defense?)
  end

  def test_cpu_opposite_corners_1
    assert(!@game.opposite_corners?)
    @game.grid["a1"] = @game.player_mark
    @game.grid["c3"] = @game.player_mark
    assert(@game.opposite_corners?)
  end

  def test_cpu_opposite_corners_2
    assert(!@game.opposite_corners?)
    @game.grid["a3"] = @game.player_mark
    @game.grid["c1"] = @game.player_mark
    assert(@game.opposite_corners?)
  end
end
