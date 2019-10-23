require 'gosu'
require 'date'
require_relative 'pos'

class Snake
  attr_reader :x_pos, :y_pos, :blocksize, :gridsize, :size, :birthdate, :dir

  def initialize(pos, blocksize, gridsize)
    @positions = [pos] # array with pos-objects
    @blocksize = blocksize # size of each block ("resolution")
    @gridsize = gridsize # nbr of blocks in the grid
    @dir = ["RIGHT", "LEFT", "UP", "DOWN"].sample # random starting direction
    @size = 4
    @birthdate = Time.now
    @color = Gosu::Color::WHITE
  end

  def move
    new_pos = compute_new_pos
    @positions.unshift(new_pos)
    @positions.pop while @positions.size > @size
  end

  def compute_new_pos
    old_pos = @positions.first
    if @dir == "UP"
      return Pos.new(old_pos.x_pos, (old_pos.y_pos - 1) % @gridsize)
    elsif @dir == "RIGHT"
      return Pos.new((old_pos.x_pos + 1) % @gridsize, old_pos.y_pos)
    elsif @dir == "DOWN"
      return Pos.new(old_pos.x_pos, (old_pos.y_pos + 1) % @gridsize)
    elsif @dir == "LEFT"
      return Pos.new((old_pos.x_pos - 1) % @gridsize, old_pos.y_pos)
    end
  end

  def change_dir(new_dir)
    illigal_combinations = {
      "UP" => "DOWN",
      "RIGHT" => "LEFT",
      "DOWN" => "UP",
      "LEFT" => "RIGHT"
    }
    @dir = new_dir if illigal_combinations[@dir] != new_dir
  end

  def grow
    @size += 1
  end

  def draw_snake
    @positions.each do |pos|
      Gosu.draw_rect(pos.x_pos * @blocksize, pos.y_pos * @blocksize, @blocksize, @blocksize, @color)
    end
  end

  def collision?
    flag = false
    head = @positions.first
    @positions[1..-1].each { |position| flag = true if Pos.equal?(head, position) } if @positions.size > 4
    return flag
  end

  # food has to be a Pos-object
  def eat?(food)
    Pos.equal?(food, @positions.first)
  end
end
