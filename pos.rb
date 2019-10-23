class Pos
  attr_reader :x_pos, :y_pos

  def initialize(x_pos, y_pos)
    @x_pos = x_pos
    @y_pos = y_pos
  end

  def self.equal?(pos1, pos2)
    pos1.x_pos == pos2.x_pos && pos1.y_pos == pos2.y_pos
  end
end
