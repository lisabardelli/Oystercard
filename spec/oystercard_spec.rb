require 'oystercard'
require 'station'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:station) { Station.new }

  it 'responds to balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'responds to top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'oystercard responds to touch_in' do
    expect(subject).to respond_to(:touch_in).with(1).argument
  end

  it 'responds to touch_out' do
    expect(subject).to respond_to(:touch_out)
  end

  it 'responds to in_journey?' do
    expect(subject).to respond_to(:in_journey?)
  end

  describe '#top_up' do
    it 'will top up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by 1
    end

    it 'raises error if user tries to topup past max capacity' do
      subject.capacity.times { subject.top_up(1) }
      expect { subject.top_up(1) }.to raise_error "Cap  of #{subject.capacity} reached"
    end
  end

  describe '#touch_in' do
    it "changes @in_use from false to true" do
      subject.top_up(subject.minimum_fare)
      subject.touch_in(station)
      expect(subject.in_use).to eq true
    end

    it 'touch in fails when balance < 1' do
      expect { subject.touch_in(station) }.to raise_error "Not enough funds"
    end

    it 'remembers the station' do
      subject.top_up(subject.minimum_fare)
      subject.touch_in(station)
      expect(subject.start_station).to eq station 
    end
  end

  describe '#touch_out' do
    it ' changes @in_use from true to false' do
        subject.top_up(subject.minimum_fare)
        subject.touch_in(station)
        subject.touch_out
      expect(subject.in_use).to eq false
    end

    it 'deducts minimum fare from balance' do
      subject.top_up(subject.minimum_fare)
      subject.touch_in(station)
      expect { subject.touch_out}. to change{ subject.balance }.by(-(subject.minimum_fare))
    end
  end

  describe '#in_journey?' do
    it 'return true if card is in use' do
      subject.top_up(subject.minimum_fare)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'returns false if card not in use' do
      expect(subject).not_to be_in_journey
    end
  end
end
