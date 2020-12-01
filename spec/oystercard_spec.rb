require 'oystercard'
require 'station'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:station) { double :station }
  let(:start_station) {double :start_station}
  let(:exit_station) {double :exit_station}

  it 'responds to balance' do
    expect(subject).to respond_to(:balance) #expects oystercard to respond to balance
  end

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0 #expect oystercard balance to equal zero
  end

  it 'responds to top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument #expect oystercard to respond to top up(with 1 argument)
  end

  it 'oystercard responds to touch_in' do
    expect(subject).to respond_to(:touch_in).with(1).argument #expect oystercard to respond to touch in (with 1 argument)
  end

  it 'responds to touch_out' do
    expect(subject).to respond_to(:touch_out).with(1).argument  # expect oystercard to respond to touch out 
  end

  it 'responds to in_journey?' do
    expect(subject).to respond_to(:in_journey?) # expect oystercard to respond to in journey? 
  end

  describe '#top_up' do
    it 'will top up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by 1 #expect oystercard.top up to change the balance by 1
    end

    it 'raises error if user tries to topup past max capacity' do
      subject.capacity.times { subject.top_up(1) } # oystercard.capacity 
      expect { subject.top_up(1) }.to raise_error "Cap  of #{subject.capacity} reached"
    end
  end

  describe '#touch_in' do
    # it "changes @in_use from false to true" do
    #   subject.top_up(subject.minimum_fare) # ystercard.top_up (by the minimum fare ) in order to make test passo
    #   subject.touch_in(station) # oystercard.touch_in(to station)
    #   expect(subject.in_use).to eq true # expect oystercard to be in use
    # end

    it 'touch in fails when balance < 1' do
      expect { subject.touch_in(station) }.to raise_error "Not enough funds" # expect subject.touch_in to fail due to there being not enough funds
    end

    it 'remembers the station' do
      subject.top_up(subject.minimum_fare) # subject.top_up (by minimum fare) in order to make test work
      subject.touch_in(station) # oystercard.touch_in(to station)
      expect(subject.start_station).to eq station  # expect subject.start_station to equal station
    end


  end

  describe '#touch_out' do
    # it ' changes @in_use from true to false' do
    #     subject.top_up(subject.minimum_fare) #oystercard.top_up (by the minimum fare ) in order to make test pass
    #     subject.touch_in(station) #oystercard.touch_in(to station) to make test pass
    #     subject.touch_out #oystercard.touch_out of station to make test pass
    #   expect(subject.in_use).to eq false # expect oystercard to not be in use
    # end

    it 'deducts minimum fare from balance' do
      subject.top_up(subject.minimum_fare) #oystercard.top_up (by the minimum fare ) in order to make test pass
      subject.touch_in(station) #oystercard.touch_in(to station) to make test pass
      expect { subject.touch_out(station)}. to change{ subject.balance }.by(-(subject.minimum_fare)) #expect subject.touch_out to change the balance by (minus) the minimum fare
    end

    # it 'forgets the station on touch_out' do
    #   subject.touch_out(station)
    #   expect(subject.touch_out(station)).not_to be_empty
    # end
    it 'remembers the station' do
      subject.touch_out(station) # oystercard.touch_out(to station)
      expect(subject.exit_station).to eq station  # expect subject.exit_station to equal station
    end
  end

  describe '#in_journey?' do
    it 'return true if card is in use' do
      subject.top_up(subject.minimum_fare) #oystercard.top_up (by the minimum fare ) in order to make test pass
      subject.touch_in(station)  #oystercard.touch_in(to station) to make test pass
      expect(subject).to be_in_journey # expect oystercard(owner) to be in journey after you've touched in
    end

    it 'returns false if card not in use' do
      expect(subject.start_station).to be_empty # expect subject to not be in journey
    end
  end
  describe '#history_of_journeys' do
    it "returns an empty list of journeys by default" do
      p subject.history_of_journeys
      expect(subject.history_of_journeys).to be_empty
    end
  
    it "returns an array with list of journey" do
      subject.top_up(10)
      subject.touch_in(start_station)
      subject.touch_out(exit_station)
      expect(subject.history_of_journeys.is_a?(Array)).to be_truthy
    end
  end
end


