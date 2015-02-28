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

  def safe_position?(x, y)
    x >= 0 &&
      x <= 5 &&
      y >= 0 &&
      y <= 5
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
    # TODO: Ignore this command if the robot has not been placed.
    @reporter.report(@x, @y, @facing)
  end
end
