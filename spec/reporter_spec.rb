require "reporter"
require "facing"

RSpec.describe Reporter do
  it "reports its position" do
    reporter = Reporter.new
    facing = Facing.new_of_correct_type(:N)
    reporter.report(0, 1, facing)

    expect(reporter.output).to include("0 1 N")
  end
end
