require 'journey'
require 'oystercard'

describe Journey do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'returns an instance of the Journey class' do
    expect(Journey.new).to be_an_instance_of Journey
  end
  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(2).argument }

    it 'should update entry station' do
      oystercard.top_up(10)
      expect(subject.touch_in(entry_station, oystercard)).to eq(entry_station)
    end

    it 'should not allow touch_in if balance is under minimum amount' do
      oystercard.top_up(0.5)
      expect { subject.touch_in(entry_station, oystercard) }.to raise_error "balance under £#{Oystercard::MINIMUM_AMOUNT}"
    end
  end
  describe '#in_journey' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns the journey status' do
      oystercard.top_up(10)
      subject.touch_in(entry_station, oystercard)
      expect(subject.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(2).argument }

    it 'should change journey_status to false' do
      oystercard.top_up(10)
      subject.touch_in(entry_station, oystercard)
      expect(subject.touch_out(exit_station, oystercard)).to eq(nil)
    end

    it 'should deduct minimum fare from balance' do
      oystercard.top_up(5)
      subject.touch_in(entry_station, oystercard)
      expect { subject.touch_out(exit_station, oystercard) }.to change { oystercard.balance }.by(-1)
    end
  end
  describe '#fare' do
    it { is_expected.to respond_to(:fare).with(1).argument }

    it 'returns the minimum fare' do
      oystercard.top_up(10)
      subject.touch_in(entry_station, oystercard)
      subject.touch_out(exit_station, oystercard)
      expect(subject.fare(oystercard)).to eq Oystercard::MINIMUM_FARE
    end

    it 'returns the penalty fare if no touch in' do
      oystercard.top_up(10)
      subject.touch_out(exit_station, oystercard)
      expect(subject.fare(oystercard)).to eq Oystercard::PENALTY_FARE
    end

    it 'returns the penalty fare if no touch in' do
      oystercard.top_up(10)
      subject.touch_in(entry_station, oystercard)
      subject.touch_out(nil, oystercard)
      expect(subject.fare(oystercard)).to eq Oystercard::PENALTY_FARE
    end
  end
end
