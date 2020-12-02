require 'oystercard'

describe Oystercard do
let(:entry_station){ double :station }
let(:exit_station){ double :station }

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

  # describe "#deduct" do
  #   it { is_expected.to respond_to(:deduct).with(1).argument }

  #   it 'should deduct amount from balance' do
  #     subject.top_up(20)
  #     expect(subject.deduct(5)).to eq 15
  #   end
  # end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'should change journey_status to true if minimum amount is met' do
      subject.top_up(10)
      expect { subject.touch_in(entry_station) }.to change { subject.entry_station }.to entry_station
    end

    it 'should not allow touch_in if balance is under minimum amount' do
      subject.top_up(0.5)
      expect { subject.touch_in(entry_station) }.to raise_error "balance under £#{Oystercard::MINIMUM_AMOUNT}"
    end

    it 'should remember the entry station' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe "#in_journey" do
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns the journey status' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'should change journey_status to false' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.entry_station }.to nil
    end

    it 'should deduct minimum fare from balance' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end
  end

  describe '#history' do
    it { is_expected.to respond_to(:history) }

    it 'starts with an empty list of journeys' do
      expect(subject.history).to be_empty
    end

    it 'displays history of journeys' do
      subject.top_up(10)
      2.times {
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      }
      expect(subject.history).to eq( [{:in => entry_station, :out => exit_station}, {:in => entry_station, :out => exit_station} ] )
    end
  end

  describe '#journey' do
    it { is_expected.to respond_to(:journey) }

    it 'holds the current journey in hash' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey).to include( :in => entry_station, :out => exit_station )
    end
  end
end
