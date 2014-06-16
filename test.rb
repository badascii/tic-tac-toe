require 'minitest/autorun'

class TestGame
  def setup
    @grid = {"a1" => 0, "b1" => 0, "c1" => 0,
             "a2" => 0, "b2" => 0, "c2" => 0,
             "a3" => 0, "b3" => 0, "c3" => 0 }
    @player_mark = 1
    @cpu_mark    = 2
  end

  def test_grid
    assert @grid.class == Hash
  end

  def test_player_input
  end
end