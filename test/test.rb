require 'minitest/autorun'
require_relative '../lib/tic_tac_toe.rb'

class TestGame < MiniTest::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_grid
    @game.grid["a1"] = 1
    assert_equal(@game.grid.class, Hash)
    assert_equal(@game.grid["a1"], 1)
  end

  def test_marks
    !assert_equal(@player_mark, @cpu_mark)
  end

  def test_print_mark
    assert_equal(@game.print_mark(1), "X")
  end

  def test_position_empty
    assert @game.position_empty?("a1") ==  true
  end
end