require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:journey) { Journey.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it { is_expected.to respond_to(:balance) }

  it 'has a starting balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add amount to balance' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'should raise an error if balance is already at maximum limit' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { subject.top_up(1) }.to raise_error "balance exceeds £#{Oystercard::MAXIMUM_LIMIT}"
    end
  end

  describe '#history' do
    it { is_expected.to respond_to(:history) }

    it 'starts with an empty list of journeys' do
      expect(subject.history).to be_empty
    end

    it 'displays history of journeys' do
      oystercard.top_up(10)
      2.times do
        journey.touch_in(entry_station, oystercard)
        journey.touch_out(exit_station, oystercard)
      end
      expect(oystercard.history).to eq([{ in: entry_station, out: exit_station }, { in: entry_station, out: exit_station }])
    end
  end
end
