class Game
  def initialize
    @player = Player.new
    @cpu = Cpu.new
    @player_mark =
    @cpu_mark    = "0"
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