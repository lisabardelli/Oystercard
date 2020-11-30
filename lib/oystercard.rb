class Oystercard
  attr_accessor :balance, :capacity, :in_use, :minimum_fare

  DEFAULT_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @capacity = DEFAULT_CAPACITY
    @in_use = false
    @minimum_fare = MINIMUM_FARE
  end

  def top_up(money)
    fail "Cap  of #{@capacity} reached" if (@balance + money) > @capacity
    @balance += money
  end

  def touch_in
    fail "Not enough funds" if @balance < 1
    @in_use = true
  end

  def touch_out
    deduct(@minimum_fare)
    @in_use = false
  end

  def in_journey?
    @in_use == true
  end

  private

  def deduct(money)
    @balance -= money
  end

end
