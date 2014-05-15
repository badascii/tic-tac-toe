# 0 = empty
# 1 = X
# 2 = O

class Game

  X = 1
  O = 2

  def initialize
    @grid = Game.grid
  end

  def self.grid
    return [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
  end

  def self.print_legend
    legend = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    legend.each do |row|
      row.each do |position|
        print "|" + position + "|"
      end
      puts
    end
  end

  def print_grid(grid)
    grid.each do |row|
      row.each do |position|
        case position
        when X
          print "|X|"
        when O
          print "|O|"
        else
          print "|_|"
        end
      end
      puts
    end
  end

  def self.player_input
    player_turn = gets.chomp!
    if player_turn =~ /[1-9]/
      return player_turn
    else
      puts "Invalid entry. Please enter a number from 1-9."
      self.player_input
    end
  end

  def run
    puts "Grid Legend\n"
    Game.print_legend


    while @grid[0].include?(0) || @grid[1].include?(0) || @grid[2].include?(0)
      self.print_grid(@grid)

      puts "\nEnter a number from 1-9 to place your move on that grid position: "
      player_action = Game.player_input


      @grid.each do |row|
        row.each do |position|
          if position
            position = "asdf"
          end
        end
      end
    end
  end

end


game = Game.new

game.run

game.print_grid(game.grid)

