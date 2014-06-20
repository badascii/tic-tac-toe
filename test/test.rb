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
    assert(@game.position_empty?("a1") == true)
    assert(@game.position_empty?("b2") == true)
    assert(@game.position_empty?("c3") == true)
  end

  def test_grid_full
    assert(@game.grid_full? == false)

    # This code block fills the grid with moves
    @game.grid.keys.each do |position|
      @game.grid[position] = 1
    end

    assert(@game.grid_full? == true)
  end
end