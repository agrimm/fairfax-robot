require "forwardable"

# The Robot which moves around
class Robot
  extend Forwardable

  attr_reader :x, :y

  def_delegators :@facing, :facing

  def place(x, y, facing)
    # TODO: No validation of position.
    @x = x
    @y = y
    @facing = facing
  end
end
