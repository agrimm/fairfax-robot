require "place_command"
require "move_command"
require "left_command"
require "right_command"
require "report_command"
require "factory_girl"
# REVIEW: Is it possible to automatically load spec/factories/*.rb ,
#   as indicated in https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#defining-factories
#   when Rails isn't being used?
require_relative "./factories/robot_factory"

RSpec.describe Robot do
  it "can be placed" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :N)

    place_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
    expect(robot.facing).to eq(:N)
  end

  it "can be moved north" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :N)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(1)
  end

  it "can be moved south" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 1, :S)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(0)
    expect(robot.y).to eq(0)
  end

  # REVIEW: There's probably a more DRY way to specify the behavior
  #   of east and west. I'm still a beginner at RSpec.
  #   (I previously used test/unit and minitest)
  it "can be moved east" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :E)
    move_command = MoveCommand.new

    place_command.run(robot)
    move_command.run(robot)

    expect(robot.x).to eq(1)
    expect(robot.y).to eq(0)
  end

  it "can be moved west" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(1, 0, :W)
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
      place_command = PlaceCommand.new(0, 0, :N)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:W)
    end

    it "knows south is left of west" do
      place_command = PlaceCommand.new(0, 0, :W)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:S)
    end

    it "knows east is left of south" do
      place_command = PlaceCommand.new(0, 0, :S)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:E)
    end

    it "knows north is left of east" do
      place_command = PlaceCommand.new(0, 0, :E)

      place_command.run(robot)
      left_command.run(robot)

      expect(robot.facing).to eq(:N)
    end
  end

  describe "right command" do
    let(:robot) { FactoryGirl.build(:robot) }
    let(:right_command) { RightCommand.new }

    it "knows east is right of north" do
      place_command = PlaceCommand.new(0, 0, :N)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:E)
    end

    it "knows south is right of east" do
      place_command = PlaceCommand.new(0, 0, :E)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:S)
    end

    it "knows west is right of south" do
      place_command = PlaceCommand.new(0, 0, :S)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:W)
    end

    it "knows north is right of west" do
      place_command = PlaceCommand.new(0, 0, :W)

      place_command.run(robot)
      right_command.run(robot)

      expect(robot.facing).to eq(:N)
    end
  end

  describe "unsafe place commands" do
    let(:robot) do
      robot = FactoryGirl.build(:robot)
      place_command = PlaceCommand.new(1, 2, :N)
      place_command.run(robot)
      robot
    end

    it "entirely ignores unsafe place commands, not just the unsafe attribute" do
      place_command = PlaceCommand.new(-1, 3, :S)

      expect { place_command.run(robot) }.to_not change(robot, :x).from(1)
      expect { place_command.run(robot) }.to_not change(robot, :y).from(2)
      expect { place_command.run(robot) }.to_not change(robot, :facing).from(:N)
    end
  end

  it "ignores unsafe move commands" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 0, :S)
    move_command = MoveCommand.new

    place_command.run(robot)

    expect { move_command.run(robot) }.to_not change(robot, :y).from(0)
  end

  it "ignore commands when robot is not on table" do
    robot = FactoryGirl.build(:robot)
    move_command = MoveCommand.new
    left_command = LeftCommand.new
    right_command = RightCommand.new
    report_command = ReportCommand.new
    expect do
      move_command.run(robot)
      left_command.run(robot)
      right_command.run(robot)
      report_command.run(robot)
    end.to_not raise_error
  end

  it "reports its position" do
    robot = FactoryGirl.build(:robot)
    place_command = PlaceCommand.new(0, 1, :N)
    report_command = ReportCommand.new

    place_command.run(robot)
    report_command.run(robot)

    expect(robot.output).to include("0 1 N")
  end
end
