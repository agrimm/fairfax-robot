# Reports a robot's x, y, and facing
class Reporter
  def initialize
    @reports = []
  end

  def report(x, y, facing)
    # REVIEW: Is it possible for multiple report commands to happen?
    @reports << Report.new(x, y, facing)
  end

  def output
    @reports.join("\n")
  end

  # An individual report of x, y, and facing
  class Report
    def initialize(x, y, facing)
      @x = x
      @y = y
      @facing = facing
    end

    def to_s
      [@x, @y, @facing.facing.upcase].join(",")
    end
  end
end
