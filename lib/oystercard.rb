class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance, :entry_station, :exit_station, :history, :journey

  def initialize
    @balance = 0
    @entry_station = nil
    @history = []
    @journey = {}
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

  def touch_out(exit_station)
    deduct(MINIMUM_AMOUNT)

    @exit_station = exit_station

    update_recent_journey

    add_journey_to_history

    reset_stations
  end

  def update_recent_journey
    @journey[:in] = @entry_station
    @journey[:out] = @exit_station
  end

  def add_journey_to_history
    @history << @journey
  end

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
