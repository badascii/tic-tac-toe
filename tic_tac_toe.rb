class Game

  GRID = {'a1': 0, 'a2': 0, 'a3': 0,
          'b1': 0, 'b2': 0, 'b3': 0,
          'c1': 0, 'c2': 0, 'c3': 0}

  def initialize
    @player = Player.new
    @cpu = Cpu.new
    @player_mark =
    @cpu_mark    = "0"
  end

  def run
    until game_over?

    end
  end

  def game_over?

  end

end

class Player
  def initialize
    @mark = "X"
  end
end

class Cpu
  def initialize
    @mark = "O"
  end
end

game = Game.new

game.run
