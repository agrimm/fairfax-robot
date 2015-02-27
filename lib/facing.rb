# Module for creating a facing of the correct direction
module Facing
  def self.new_of_correct_type(facing)
    case facing
    when :north then NorthFacing.new
    end
  end
end

# Facing north
class NorthFacing
  def facing
    :north
  end

  def x_change
    0
  end

  def y_change
    +1
  end
end
