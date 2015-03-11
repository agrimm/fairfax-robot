require "robot"
require "reporter"
require "paddock"

FactoryGirl.define do
  factory :robot do
    reporter { Reporter.new }
    paddock { Paddock.new(4, 4) }

    initialize_with { new(reporter, paddock) }
  end
end
