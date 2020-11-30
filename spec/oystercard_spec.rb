require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }
  it 'responds to balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'will top up the balance' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'will deduct from the balance' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  describe '#deduct' do
    it 'deduct from the balance' do
      expect { subject.deduct(1) }.to change { subject.balance }.by -1
    end
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
end
