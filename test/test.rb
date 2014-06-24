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

  def test_cpu_opposite_corners
    assert(!@game.opposite_corners?)
    @game.grid["a1"] == @game.player_mark
    @game.grid["c3"] == @game.player_mark
    assert(@game.opposite_corners?)
end
