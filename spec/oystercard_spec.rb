RSpec.describe Oystercard::Card do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  describe '#top_up' do
    it 'tops up the balance' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'raises an error when reaches max balance' do
      expect { subject.top_up(101) }.to raise_error 'Exceeds max balance'
    end
  end

  describe '#touch_in' do
    it 'raises error when insufficient funds' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds'
    end

    it 'saves the entry station' do
      subject.top_up(10)
      expect(subject.touch_in(entry_station)).to eq(entry_station)
    end
  end

  describe '#in_journey' do
    it 'returns not nil when travelling' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).not_to eq(nil)
    end
  end

  describe '#touch_out' do
    it 'reduces the balance by minimum fare' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::Card::MIN_FARE)
    end
  end
  describe '#store_journey' do
    it 'returns an hash with nil values ' do
      subject.top_up(10)
      expected = { in: nil, out: nil }
      expect(subject.store_journey).to eq(expected)
    end

    it 'returns an hash when storing_journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expected = { in: entry_station, out: exit_station }
      expect(subject.store_journey).to eq(expected)
    end
  end
  it 'returns empty list for journeys if not travelling' do
    expect(subject.journeys).to be_empty
  end
end
