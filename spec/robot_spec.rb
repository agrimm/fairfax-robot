require "robot"
require "place_command"
require "move_command"

RSpec.describe Robot do
  it "can be placed" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 0, :north)

    place_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
    expect(robot.facing).to eq(:north)
  end

  it "can be moved north" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 0, :north)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(1)
  end
end
