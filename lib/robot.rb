require "forwardable"

# The Robot which moves around
class Robot
  extend Forwardable

  attr_reader :x, :y

  def_delegators :@facing, :facing

  def place(x, y, facing)
    return unless safe_position?(x, y)
    @x = x
    @y = y
    @facing = facing
  end

  def safe_position?(x, y)
    x >= 0 &&
      x <= 5 &&
      y >= 0 &&
      y <= 5
  end

  def move
    new_x = @x + @facing.x_change
    new_y = @y + @facing.y_change

    return unless safe_position?(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def rotate_left
    @facing = @facing.rotate_left
  end

  def rotate_right
    @facing = @facing.rotate_right
  end
end
