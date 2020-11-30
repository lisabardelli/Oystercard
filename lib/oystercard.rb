class Oystercard
  MAXIMUM_LIMIT = 90
  attr_reader :balance
  attr_reader :journey_status

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    fail "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @journey_status = true
  end

  def in_journey?
    @journey_status
  end

  def touch_out
    @journey_status = false
  end


end
