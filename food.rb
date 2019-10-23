require 'gosu'

class Food
  attr_reader :pos

  def initialize(snake)
    @snake = snake
    @pos = Pos.new((rand * @snake.gridsize).floor, (rand * @snake.gridsize).floor)
    @color = Gosu::Color::RED
  end

  def draw_food
    size = @snake.blocksize
    Gosu.draw_rect(@pos.x_pos * size, @pos.y_pos * size, size, size, @color)
  end

  def reset
    @pos = Pos.new((rand * @snake.gridsize).floor, (rand * @snake.gridsize).floor)
  end
end
