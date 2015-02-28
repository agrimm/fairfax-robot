require "facing"

# Command for placing a robot
class PlaceCommand
  extend Forwardable

  # Used only for specs
  attr_reader :x, :y

  # Used only for specs
  def_delegators :@facing, :facing

  def initialize(x, y, facing)
    @x = x
    @y = y
    @facing = Facing.new_of_correct_type(facing)
  end

  def run(robot)
    robot.place(@x, @y, @facing)
  end
end
