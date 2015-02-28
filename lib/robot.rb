require "forwardable"

# The Robot which moves around
class Robot
  extend Forwardable

  attr_reader :x, :y

  def_delegators :@facing, :facing
  def_delegators :@reporter, :output

  def initialize(reporter)
    @placed = false
    @reporter = reporter
  end

  def place(x, y, facing)
    return unless safe_position?(x, y)
    @x = x
    @y = y
    @facing = facing
    @placed = true
  end

  # 5 by 5 table starting at 0,0
  # so a value of 5 is not safe
  def safe_position?(x, y)
    x >= 0 &&
      x <= 4 &&
      y >= 0 &&
      y <= 4
  end

  def move
    return unless @placed

    new_x = @x + @facing.x_change
    new_y = @y + @facing.y_change

    return unless safe_position?(new_x, new_y)

    @x = new_x
    @y = new_y
  end

  def rotate_left
    return unless @placed

    @facing = @facing.rotate_left
  end

  def rotate_right
    return unless @placed

    @facing = @facing.rotate_right
  end

  def report
    return unless @placed

    @reporter.report(@x, @y, @facing)
  end
end
