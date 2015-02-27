require "robot"
require "place_command"
require "move_command"
require "left_command"
require "right_command"

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

  it "can be moved south" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 1, :south)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
  end

  # REVIEW: There's probably a more DRY way to specify the behavior
  #   of east and west. I'm still a beginner at RSpec.
  it "can be moved east" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 0, :east)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(1)
  end

  it "can be moved west" do
    robot = Robot.new
    place_command = PlaceCommand.new(0, 1, :west)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
  end

  describe "left command" do
    let(:robot) { Robot.new }
    let(:left_command) { LeftCommand.new }

    it "knows west is left of north" do
      place_command = PlaceCommand.new(0, 0, :north)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:west)
    end

    it "knows south is left of west" do
      place_command = PlaceCommand.new(0, 0, :west)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:south)
    end

    it "knows east is left of south" do
      place_command = PlaceCommand.new(0, 0, :south)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:east)
    end

    it "knows north is left of east" do
      place_command = PlaceCommand.new(0, 0, :east)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:north)
    end
  end

  describe "right command" do
    let(:robot) { Robot.new }
    let(:right_command) { RightCommand.new }

    it "knows east is right of north" do
      place_command = PlaceCommand.new(0, 0, :north)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:east)
    end

    it "knows south is right of east" do
      place_command = PlaceCommand.new(0, 0, :east)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:south)
    end

    it "knows west is right of south" do
      place_command = PlaceCommand.new(0, 0, :south)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:west)
    end

    it "knows north is right of west" do
      place_command = PlaceCommand.new(0, 0, :west)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:north)
    end
  end
end
