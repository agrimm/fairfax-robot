# The Robot which moves around
class Robot
  attr_reader :x, :y, :facing

  def place(x, y, facing)
    # TODO: No validation of position.
    @x = x
    @y = y
    @facing = facing
  end
end
