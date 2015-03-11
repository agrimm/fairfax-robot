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
    fail CollisionError, "Collision of two robots at #{x} #{y}" unless safe_position?(x, y)
    @x = x
    @y = y
    @facing = facing
  end

  def move
    @x += @facing.x_change
    @y += @facing.y_change
    fail CollisionError, "Collison of two robots at #{@x} #{@y}" unless safe_position?(@x, @y)
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

  def register_position
    @paddock.register_position(@x, @y)
  end

  CollisionError = Class.new(StandardError)
end
