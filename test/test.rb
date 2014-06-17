require 'minitest/autorun'
require_relative '../lib/tic_tac_toe.rb'

class TestGame < MiniTest::Unit::TestCase
  def setup
    @game = Game.new
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
