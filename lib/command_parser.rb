require "place_command"

# Parse input to produce commands
class CommandParser
  def parse_line(line)
    command_word = line.split(" ").first
    case command_word
    when "PLACE" then parse_place_command(line)
    else fail "Unknown command #{command_word.inspect} in #{line.inspect}"
    end
  end

  def parse_place_command(line)
    value_substr = line.gsub("PLACE ", "")

    x_str, y_str, facing_str = value_substr.split(",")

    x = Integer(x_str)
    y = Integer(y_str)
    facing = facing_str.downcase.to_sym

    PlaceCommand.new(x, y, facing)
  end
end
