# The paddock in which robots roam
class Paddock
  # Only used in specs
  attr_reader :max_x, :max_y

  def initialize(max_x, max_y)
    @max_x = max_x
    @max_y = max_y
  end

  def safe_position?(x, y)
    x >= 0 &&
      x <= @max_x &&
      y >= 0 &&
      y <= @max_y
  end
end
