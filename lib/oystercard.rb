class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    raise "Cannot exeed max balance (#{MAXIMUM_BALANCE})!" if (@balance + money) > MAXIMUM_BALANCE

    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    raise 'The balance is less than (#{MINIMUM_BALANCE}). Top_up your card!' if balance < MINIMUM_BALANCE

    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
