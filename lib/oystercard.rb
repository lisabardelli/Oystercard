class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    fail "balance under £#{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT
    @entry_station = entry_station
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
