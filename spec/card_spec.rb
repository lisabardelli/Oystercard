RSpec.describe Oystercard::Card do

  describe "#top_up" do
    it "tops up the balance" do
      subject.top_up(10)
      expect(subject.balance).to eql(10)
    end

    it "raises an error when reaches max balance" do
      expect { subject.top_up(101) }.to raise_error "Exceeds max balance"
    end
  end
end
