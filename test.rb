require 'minitest/autorun'

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
    assert_not_equal(@player_mark, @cpu_mark)
  end

  def test_print_mark
    assert_equal(print_mark(1), "X")
  end

  def test_position_empty
    assert position_empty?("a1") ==  true
  end
end