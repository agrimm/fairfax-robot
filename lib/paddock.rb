require "set"

# The paddock in which robots roam
class Paddock
  # Only used in specs
  attr_reader :max_x, :max_y

  def initialize(max_x, max_y)
    @max_x = max_x
    @max_y = max_y
    @registered_positions = Set.new
  end

  # REVIEW: No specification of what should happen
  # if a robot tries to leave a paddock.
  def safe_position?(x, y)
    x >= 0 &&
      x <= @max_x &&
      y >= 0 &&
      y <= @max_y &&
      !@registered_positions.include?([x, y])
  end

  def register_position(x, y)
    @registered_positions << [x, y]
  end
end
