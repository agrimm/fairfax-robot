require "input_parser"

RSpec.describe InputParser do
  it "can parse place line" do
    input_parser = InputParser.new
    line = "0 1 N"

    command = input_parser.parse_place_line(line)

    expect(command.x).to eq(0)
    expect(command.y).to eq(1)
    expect(command.facing).to eq(:N)
  end

  it "can parse move command" do
    input_parser = InputParser.new
    command_string = "M"

    command = input_parser.parse_command_string(command_string)

    expect(command).to be_a(MoveCommand)
  end

  it "can parse left command" do
    input_parser = InputParser.new
    command_string = "L"

    command = input_parser.parse_command_string(command_string)

    expect(command).to be_a(LeftCommand)
  end

  it "can parse right command" do
    input_parser = InputParser.new
    command_string = "R"

    command = input_parser.parse_command_string(command_string)

    expect(command).to be_a(RightCommand)
  end

  it "can parse input consiting of multiple lines" do
    input_parser = InputParser.new
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM"

    commands = input_parser.parse(input)

    expect(commands.length).to be(6)
    expect(commands.first).to be_a(PlaceCommand)
  end

  it "does not have a problem with newlines at the end" do
    input_parser = InputParser.new
    input = "5 5\n" \
            "1 2 E\n" \
            "MMLM\n"

    expect { input_parser.parse(input) }.to_not raise_error
  end
end
