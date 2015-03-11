$LOAD_PATH.unshift __dir__

require "reporter"
require "robot"
require "paddock"
require "command_parser"

# Runs the whole program
class Runner
  def self.run(input_filename, output_filename)
    reporter = Reporter.new
    # FIXME: Get rid of hard-wired configuration.
    paddock = Paddock.new(4, 4)
    robot = Robot.new(reporter, paddock)

    input = File.read(input_filename)
    command_parser = CommandParser.new
    commands = command_parser.parse(input)
    commands.each do |command|
      command.run(robot)
    end

    File.write(output_filename, reporter.output)
  end
end
