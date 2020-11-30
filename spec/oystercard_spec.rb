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

  describe '#top_up' do
    it 'will top up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by 1 
    
    end
  end
end
