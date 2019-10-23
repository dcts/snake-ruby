require 'gosu'
require 'date'
require 'pry-byebug'
require_relative 'snake'
require_relative 'food'
require_relative 'pos'

class Game < Gosu::Window
  def initialize
    @snake = Snake.new(Pos.new(10, 10), 30, 20) # ( POS, gidsize, blocksize )
    @food = Food.new(@snake)
    @count = 0

    super @snake.blocksize * @snake.gridsize, @snake.blocksize * @snake.gridsize
    self.caption = "MY SNAKE GAME"
  end

  def update
    mapping = {
      "LEFT" => Gosu::KB_LEFT,
      "RIGHT" => Gosu::KB_RIGHT,
      "UP" => Gosu::KB_UP,
      "DOWN" => Gosu::KB_DOWN
    }
    mapping.each { |key, value| @snake.change_dir(key) if Gosu.button_down?(value) }
  end

  def draw
    @snake.move if (@count % 6).zero? # slow down the game speed!
    @count += 1
    @snake.draw_snake
    @food.draw_food
    # check if snake eats food
    if @snake.eat?(@food.pos)
      @snake.grow
      @food.reset
    end
    draw_score
    # endgame
    end_game if @snake.collision?
  end

  def draw_score
    @message = Gosu::Image.from_text(self, " SCORE: #{@snake.size}", Gosu.default_font_name, 20)
    @message.draw(0, 5, 0)
    time_passed = Time.now - @snake.birthdate
    @message = Gosu::Image.from_text(self, " Timer: #{time_passed.round(2)}", Gosu.default_font_name, 20)
    @message.draw(0, 25, 0)
  end

  def end_game
    close!
    100.times { puts "" }
    puts "----END GAME----\nFINAL SCORE: #{@snake.size}"
  end
end

Game.new.show
