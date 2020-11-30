class Oystercard
  attr_accessor :balance, :capacity, :in_use

  DEFAULT_CAPACITY = 90

  def initialize
    @balance = 0
    @capacity = DEFAULT_CAPACITY
    @in_use = false
  end

  def top_up(money)
    fail "Cap  of #{@capacity} reached" if (@balance + money) > @capacity
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use == true
  end

end
