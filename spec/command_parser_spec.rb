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
end
