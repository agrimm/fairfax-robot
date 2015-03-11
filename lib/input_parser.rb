require "paddock"
require "place_command"
require "move_command"
require "left_command"
require "right_command"
require "report_command"

# Parse input about:
#   * The paddock
#   * Where each robot starts
#   * Commands for each robot
class InputParser
  def parse(input)
    paddock_line, *robot_lines = input.split("\n")
    paddock = parse_paddock_line(paddock_line)
    per_robot_commands = parse_robot_lines(robot_lines)
    [paddock, per_robot_commands]
  end

  def parse_paddock_line(line)
    x_str, y_str = line.split(" ")

    x = Integer(x_str)
    y = Integer(y_str)
    Paddock.new(x, y)
  end

  def parse_robot_lines(robot_lines)
    robot_lines.each_slice(2).map do |place_line, instruction_line|
      instruction_line ||= ""
      parse_robot_line_pair(place_line, instruction_line)
    end
  end

  def parse_robot_line_pair(place_line, instruction_line)
    place_command = parse_place_line(place_line)
    other_commands = parse_instruction_line(instruction_line)
    # FIXME: Get rid of report command.
    report_command = ReportCommand.new
    [place_command] + other_commands + [report_command]
  end

  def parse_place_line(line)
    x_str, y_str, facing_str = line.split(" ")

    x = Integer(x_str)
    y = Integer(y_str)
    facing = facing_str.to_sym

    PlaceCommand.new(x, y, facing)
  end

  def parse_instruction_line(instruction_line)
    instruction_line.split("").map(&method(:parse_command_string))
  end

  def parse_command_string(command_string)
    case command_string
    when "M" then MoveCommand.new
    when "L" then LeftCommand.new
    when "R" then RightCommand.new
    else fail "Unknown command #{command_string.inspect}"
    end
  end
end
