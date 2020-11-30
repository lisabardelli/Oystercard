require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new }
  it 'responds to balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end
end
