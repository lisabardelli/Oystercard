class Oystercard
  attr_accessor :balance, :capacity

  DEFAULT_CAPACITY = 90

  def initialize
    @balance = 0
    @capacity = DEFAULT_CAPACITY
  end

  def top_up(money)
    fail "Cap  of #{@capacity} reached" if (@balance + money) > @capacity
    @balance += money
  end

end
