require "reporter"
require "input_parser"
require "runner"

RSpec.describe "integration specs" do
  let(:input_parser) { InputParser.new }
  let(:reporter) { Reporter.new(nil) }

  it "gives the correct result for example a from REA" do
    input = "5 5\n" \
            "0 0 N\n" \
            "M\n"

    paddock, per_robot_commands = input_parser.parse(input)
    runner = Runner.new(reporter, paddock, per_robot_commands)
    runner.run

    expect(reporter.output).to eq("0 1 N")
  end

  it "gives the correct result for example b from REA" do
    input = "5 5\n" \
            "0 0 N\n" \
            "L\n"

    paddock, per_robot_commands = input_parser.parse(input)
    runner = Runner.new(reporter, paddock, per_robot_commands)
    runner.run

    expect(reporter.output).to eq("0 0 W")
  end

  it "gives the correct result for example c from REA" do
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM\n"

    paddock, per_robot_commands = input_parser.parse(input)
    runner = Runner.new(reporter, paddock, per_robot_commands)
    runner.run

    expect(reporter.output).to eq("3 3 N")
  end
end
