require "command_parser"

RSpec.describe CommandParser do
  it "can parse place command" do
    command_parser = CommandParser.new
    line = "PLACE 0,1,NORTH"

    command = command_parser.parse_line(line)

    expect(command.x).to eq(0)
    expect(command.y).to eq(1)
    expect(command.facing).to eq(:north)
  end

  it "can parse move command" do
    command_parser = CommandParser.new
    line = "MOVE"

    command = command_parser.parse_line(line)

    expect(command).to be_a(MoveCommand)
  end

  it "can parse left command" do
    command_parser = CommandParser.new
    line = "LEFT"

    command = command_parser.parse_line(line)

    expect(command).to be_a(LeftCommand)
  end

  it "can parse right command" do
    command_parser = CommandParser.new
    line = "RIGHT"

    command = command_parser.parse_line(line)

    expect(command).to be_a(RightCommand)
  end

  it "can parse report command" do
    command_parser = CommandParser.new
    line = "REPORT"

    command = command_parser.parse_line(line)

    expect(command).to be_a(ReportCommand)
  end
end
