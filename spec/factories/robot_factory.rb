FactoryGirl.define do
  factory :robot do
    reporter Reporter.new

    initialize_with { new(reporter) }
  end
end
