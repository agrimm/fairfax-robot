$LOAD_PATH.unshift __dir__

require "reporter"
require "robot"
require "paddock"
require "input_parser"

# Runs the whole program
class Runner
  def self.run(input_filename, output_filename)
    reporter = Reporter.new(output_filename)

    input = File.read(input_filename)
    input_parser = InputParser.new
    paddock, per_robot_commands = input_parser.parse(input)

    runner = new(reporter, paddock, per_robot_commands)
    runner.run
  end

  def initialize(reporter, paddock, per_robot_commands)
    @reporter = reporter
    @paddock = paddock
    @per_robot_commands = per_robot_commands
  end

  def run
    run_commands
    @reporter.write_to_file
  end

  def run_commands
    @per_robot_commands.each(&method(:run_commands_for_specific_robot))
  end

  def run_commands_for_specific_robot(commands)
    robot = Robot.new(@reporter, @paddock)

    commands.each do |command|
      begin
        command.run(robot)
      rescue Robot::CollisionError => e
        abort e.message
      end
    end

    robot.register_position
  end
end
