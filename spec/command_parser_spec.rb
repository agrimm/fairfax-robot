require "command_parser"

RSpec.describe CommandParser do
  it "can parse place line" do
    command_parser = CommandParser.new
    line = "0 1 N"

    command = command_parser.parse_place_line(line)

    expect(command.x).to eq(0)
    expect(command.y).to eq(1)
    expect(command.facing).to eq(:N)
  end

  it "can parse move command" do
    command_parser = CommandParser.new
    command_string = "M"

    command = command_parser.parse_command_string(command_string)

    expect(command).to be_a(MoveCommand)
  end

  it "can parse left command" do
    command_parser = CommandParser.new
    command_string = "L"

    command = command_parser.parse_command_string(command_string)

    expect(command).to be_a(LeftCommand)
  end

  it "can parse right command" do
    command_parser = CommandParser.new
    command_string = "R"

    command = command_parser.parse_command_string(command_string)

    expect(command).to be_a(RightCommand)
  end

  it "can parse input consiting of multiple lines" do
    command_parser = CommandParser.new
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM"

    commands = command_parser.parse(input)

    expect(commands.length).to be(6)
    expect(commands.first).to be_a(PlaceCommand)
  end

  it "does not have a problem with newlines at the end" do
    command_parser = CommandParser.new
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM\n"

    expect { command_parser.parse(input) }.to_not raise_error
  end
end
