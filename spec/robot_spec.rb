require "robot"
require "place_command"

RSpec.describe Robot do
  it "can be placed" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 0, :north)

    place_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
    expect(robot.facing).to eq(:north)
  end
end
