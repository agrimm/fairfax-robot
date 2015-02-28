require "factory_girl"
require_relative "./factories/robot_factory"
require "command_parser"

RSpec.describe "integration specs" do
  it "gives the correct result for example a" do
    robot = FactoryGirl.build(:robot)
    input = "PLACE 0,0,NORTH\n" \
            "MOVE\n" \
            "REPORT\n"

    command_parser = CommandParser.new
    commands = command_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("0,1,NORTH")
  end

  it "gives the correct result for example b" do
    robot = FactoryGirl.build(:robot)
    input = "PLACE 0,0,NORTH\n" \
            "LEFT\n" \
            "REPORT\n"

    command_parser = CommandParser.new
    commands = command_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("0,0,WEST")
  end

  it "gives the correct result for example c" do
    robot = FactoryGirl.build(:robot)
    input = "PLACE 1,2,EAST\n" \
            "MOVE\n" \
            "MOVE\n" \
            "LEFT\n" \
            "MOVE\n" \
            "REPORT"

    command_parser = CommandParser.new
    commands = command_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("3,3,NORTH")
  end
end
