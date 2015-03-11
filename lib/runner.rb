$LOAD_PATH.unshift __dir__

require "reporter"
require "robot"
require "paddock"
require "input_parser"

# Runs the whole program
class Runner
  def self.run(input_filename, output_filename)
    reporter = Reporter.new

    input = File.read(input_filename)
    input_parser = InputParser.new
    paddock, commands = input_parser.parse(input)

    runner = new(reporter, paddock, commands, output_filename)
    runner.run
  end

  def initialize(reporter, paddock, commands, output_filename)
    @reporter = reporter
    @paddock = paddock
    @commands = commands
    @output_filename = output_filename
  end

  def run
    run_commands
    File.write(@output_filename, @reporter.output)
  end

  def run_commands
    robot = Robot.new(@reporter, @paddock)

    @commands.each do |command|
      command.run(robot)
    end
  end
end
