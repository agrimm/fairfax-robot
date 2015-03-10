# Module for creating a facing of the correct direction
module Facing
  def self.new_of_correct_type(facing)
    case facing
    when :N then NorthFacing.new
    when :S then SouthFacing.new
    when :E  then EastFacing.new
    when :W  then WestFacing.new
    else fail "Invalid facing #{facing.inspect}"
    end
  end
end

# Facing north
class NorthFacing
  def facing
    :N
  end

  def x_change
    0
  end

  def y_change
    +1
  end

  def rotate_left
    WestFacing.new
  end

  def rotate_right
    EastFacing.new
  end
end

# Facing south
class SouthFacing
  def facing
    :S
  end

  def x_change
    0
  end

  def y_change
    -1
  end

  def rotate_left
    EastFacing.new
  end

  def rotate_right
    WestFacing.new
  end
end

# Facing east
class EastFacing
  def facing
    :E
  end

  def x_change
    +1
  end

  def y_change
    0
  end

  def rotate_left
    NorthFacing.new
  end

  def rotate_right
    SouthFacing.new
  end
end

# Facing west
class WestFacing
  def facing
    :W
  end

  def x_change
    -1
  end

  def y_change
    0
  end

  def rotate_left
    SouthFacing.new
  end

  def rotate_right
    NorthFacing.new
  end
end
