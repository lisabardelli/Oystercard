require 'oystercard'

describe Oystercard do

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
  end

end
