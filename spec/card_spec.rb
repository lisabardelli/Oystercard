RSpec.describe Oystercard::Card do

  describe "#top_up" do
    it "tops up the balance" do
      subject.top_up(10)
      expect(subject.balance).to eql(10)
    end
  end
end
