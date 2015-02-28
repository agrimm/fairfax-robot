require "robot"
require "place_command"
require "move_command"
require "left_command"
require "right_command"
require "factory_girl"
# REVIEW: Is it possible to automatically load spec/factories/*.rb ,
#   as indicated in https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#defining-factories
#   when Rails isn't being used?
require_relative "./factories/robot_factory"

RSpec.describe Robot do
  it "can be placed" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :north)

    place_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
    expect(robot.facing).to eq(:north)
  end

  it "can be moved north" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :north)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(1)
  end

  it "can be moved south" do
    robot = FactoryGirl.build(:robot)
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
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :east)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(1)
  end

  it "can be moved west" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 1, :west)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
  end

  describe "left command" do
    let(:robot) { FactoryGirl.build(:robot) }
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
    let(:robot) { FactoryGirl.build(:robot) }
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

  describe "unsafe place commands" do
    let(:robot) do
      robot = FactoryGirl.build(:robot)
      place_command = PlaceCommand.new(1, 2, :north)
      place_command.run(robot)
      robot
    end

    it "ignores x less than 0" do
      place_command = PlaceCommand.new(-1, 3, :south)

      expect { place_command.run(robot) }.to_not change(robot, :x).from(1)
    end

    it "ignores x greater than 5" do
      place_command = PlaceCommand.new(6, 3, :south)

      expect { place_command.run(robot) }.to_not change(robot, :x).from(1)
    end

    it "ignores y less than 0" do
      place_command = PlaceCommand.new(3, -1, :south)

      expect { place_command.run(robot) }.to_not change(robot, :y).from(2)
    end

    it "ignores y greater than 5" do
      place_command = PlaceCommand.new(3, 6, :south)

      expect { place_command.run(robot) }.to_not change(robot, :y).from(2)
    end

    it "entirely ignores unsafe place commands, not just the unsafe attribute" do
      place_command = PlaceCommand.new(-1, 3, :south)

      expect { place_command.run(robot) }.to_not change(robot, :x).from(1)
      expect { place_command.run(robot) }.to_not change(robot, :y).from(2)
      expect { place_command.run(robot) }.to_not change(robot, :facing).from(:north)
    end
  end

  it "ignores unsafe move commands" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :south)
    move_command = MoveCommand.new

    place_command.run(robot)

    expect { move_command.run(robot) }.to_not change(robot, :y).from(0)
  end

  it "ignore commands when robot is not on table" do
    robot = FactoryGirl.build(:robot)
    move_command = MoveCommand.new
    left_command = LeftCommand.new
    right_command = RightCommand.new
    # TODO: Implement report command
    expect do
      move_command.run(robot)
      left_command.run(robot)
      right_command.run(robot)
    end.to_not raise_error
  end
end
