require_relative 'station'

class Oystercard
  attr_accessor :balance, :journeys, :is_travelling, :journey

  DEFAULT_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @is_travelling = false
    clear_journey
  end

  def top_up(money)
    fail "Cap  of #{DEFAULT_CAPACITY} reached" if (@balance + money) > DEFAULT_CAPACITY

    @balance += money
  end

  def touch_in(station)
    fail 'Not enough funds' if @balance < 1

    fail 'The Oystercard has not touched out yet' if @is_travelling == true

    @is_travelling = true
    @journey['start'] = station
  end

  def touch_out(station)
    fail 'The Oystercard has not touched in' if @is_travelling == false

    self.deduct(MINIMUM_FARE)
    self.close_journey(station)
  end

  def close_journey(station)
    @journey['end'] = station
    @journeys.append(@journey)
    @is_travelling = false
    clear_journey
  end

  private

  def deduct(money)
    @balance -= money
  end

  def clear_journey
    @journey = { 'start' => nil, 'end' => nil }
  end
end
