require 'oystercard'
require 'station'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:station) { double :station }
  let(:start_station) { double :start_station }
  let(:exit_station) { double :exit_station }

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
    expect(subject).to respond_to(:touch_out).with(1).argument
  end

  it 'responds to close_journey' do
    expect(subject).to respond_to(:close_journey).with(1).argument
  end
  

  describe '#top_up' do
    it 'will top up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by 1
    end

    it 'raises error if user tries to topup past max capacity' do
      expect { subject.top_up(Oystercard::DEFAULT_CAPACITY + 1) }.to raise_error(RuntimeError, "Cap  of #{Oystercard::DEFAULT_CAPACITY} reached")
    end
  end

  describe '#touch_in' do
    it 'changes @in_use from false to true' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.is_travelling).to eq true
    end

    it 'touch in fails when balance < 1' do
      expect { subject.touch_in(station) }.to raise_error(RuntimeError,'Not enough funds')
    end

    it 'remembers the station' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect(subject.touch_in(station)).to eq station
    end
  end

  describe '#touch_out' do
    it ' changes @is_travelling from true to false' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.is_travelling).to eq false
    end

    it 'deducts minimum fare from balance' do
      subject.top_up(20)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance }.from(20).to(subject.balance - Oystercard::MINIMUM_FARE)
    end

    it 'raises an error if is_travelling is false' do
      subject.top_up(10)
      expect{ subject.touch_out(station) }.to raise_error(RuntimeError, "The Oystercard has not touched in")
    end
  end

  describe '#is_travelling?' do
    it 'return true if card is in use' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.is_travelling).to be true
    end

    it 'returns false if card not is_travelling' do
      expect(subject.is_travelling).to be false
    end
  end
  describe '#close_journey' do
    it 'returns a list of journeys with nil value' do
      expected = { 'start' => nil, 'end' => nil }
      expect(subject.close_journey(station)).to eq expected
    end

    it 'returns an hash with list of journey' do
      subject.top_up(10)
      subject.touch_in(start_station)
      subject.touch_out(exit_station)
      expect(subject.close_journey(station).is_a?(Hash)).to be_truthy
    end
  end
end
