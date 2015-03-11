require "paddock"

RSpec.describe Paddock do
  describe "A paddock with upper right coordinates of 4 4" do
    let(:paddock) { Paddock.new(4, 4) }

    it "rejects x less than 0" do
      expect(paddock.safe_position?(-1, 3)).to be false
    end

    it "allows x of 0" do
      expect(paddock.safe_position?(0, 3)).to be true
    end

    it "rejects x greater than or equal to 5" do
      expect(paddock.safe_position?(5, 3)).to be false
    end

    it "allows x of 4" do
      expect(paddock.safe_position?(4, 3)).to be true
    end

    it "rejects y less than 0" do
      expect(paddock.safe_position?(3, -1)).to be false
    end

    it "allows y of 0" do
      expect(paddock.safe_position?(3, 0)).to be true
    end

    it "rejects y greater than or equal to 5" do
      expect(paddock.safe_position?(3, 5)).to be false
    end

    it "allows y of 4" do
      expect(paddock.safe_position?(3, 4)).to be true
    end
  end

  describe "A paddock with upper right coordinates of 1 2" do
    let(:paddock) { Paddock.new(1, 2) }

    it "allows y of 2" do
      expect(paddock.safe_position?(0, 2)).to be true
    end

    it "rejects x of 2" do
      expect(paddock.safe_position?(2, 0)).to be false
    end
  end
end
