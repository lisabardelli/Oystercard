RSpec.describe Oystercard::Card do

#let(:oystercard) {Oystercard.new}
let(:entry_station) {double :entry_station}

  describe "#top_up" do
    it "tops up the balance" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it "raises an error when reaches max balance" do
      expect { subject.top_up(101) }.to raise_error "Exceeds max balance"
    end
  end

  describe "#touch_in" do
    # it "touch in to start a journey" do
    #   subject.top_up(10)
    #   #expect(subject).not_to be_in_journey
    #   subject.touch_in(entry_station)
    #   #expect(subject).to be_in_journey
    # end

    it "raises error when insufficient funds" do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds'
    end

    it "saves the entry station" do
      subject.top_up(10)
      expect(subject.touch_in(entry_station)).to eq(entry_station)
    end
  end

  describe "#in_journey" do
    it "returns not nil when travelling" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).not_to eq(nil)
    end
  end

  describe "#touch_out" do
    # it "touch out to end journey" do
    #   subject.top_up(10)
    #   subject.touch_in(entry_station)
    #   subject.touch_out
    #   expect(subject).not_to be_in_journey
    # end

    it "reduces the balance by minimum fare" do
      expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::Card::MIN_FARE)
    end

    it "returns nil for entry station" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end
  end
end
