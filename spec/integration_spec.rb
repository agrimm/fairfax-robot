require "factory_girl"
require_relative "./factories/robot_factory"
require "input_parser"

RSpec.describe "integration specs" do
  it "gives the correct result for example a" do
    robot = FactoryGirl.build(:robot)
    input = "5 5\n" \
            "0 0 N\n" \
            "M\n"

    input_parser = InputParser.new
    _paddock, commands = input_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("0 1 N")
  end

  it "gives the correct result for example b" do
    robot = FactoryGirl.build(:robot)
    input = "5 5\n" \
            "0 0 N\n" \
            "L\n"

    input_parser = InputParser.new
    _paddock, commands = input_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("0 0 W")
  end

  it "gives the correct result for example c" do
    robot = FactoryGirl.build(:robot)
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM\n"

    input_parser = InputParser.new
    _paddock, commands = input_parser.parse(input)
    commands.each { |command| command.run(robot) }

    expect(robot.output).to eq("3 3 N")
  end
end
