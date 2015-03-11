require "forwardable"

# The Robot which moves around
class Robot
  extend Forwardable

  attr_reader :x, :y

  def_delegators :@facing, :facing
  def_delegators :@reporter, :output
  def_delegators :@paddock, :safe_position?

  def initialize(reporter, paddock)
    @reporter = reporter
    @paddock = paddock
  end

  def place(x, y, facing)
    return unless safe_position?(x, y)
    @x = x
    @y = y
    @facing = facing
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

  def report
    @reporter.report(@x, @y, @facing)
  end
end
