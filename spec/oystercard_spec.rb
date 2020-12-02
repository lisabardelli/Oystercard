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

  describe "#deduct_fare" do
    it "deducts the journey fare" do
      subject.top_up(10)
      expect { subject.deduct_fare(5) }.to change { subject.balance }.from(10).to(5)
    end
  end

  describe "#touch_in" do
    it "touch in to start a journey" do
      subject.top_up(10)
      expect(subject).not_to be_in_journey
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raises error when insufficient funds" do
      expect { subject.touch_in }.to raise_error 'Insufficient funds'
    end
  end

  describe "#touch_out" do
    it "touch out to end journey" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
