require './tic_tac_toe.rb'
require 'minitest/autorun'

class TestGame < MiniTest::Unit::TestCase
  def setup
    @grid = {"a1" => 0, "b1" => 0, "c1" => 0,
             "a2" => 0, "b2" => 0, "c2" => 0,
             "a3" => 0, "b3" => 0, "c3" => 0 }
    @player_mark = 1
    @cpu_mark    = 2
  end

  def test_grid
    @grid["a1"] = 1
    assert @grid.class == Hash
    assert @grid["a1"] == 1
  end

  def test_marks
    assert_not_equal @player_mark, @cpu_mark
  end
end