require_relative './oystercard'

class Journey
  attr_reader :history, :balance

  def initialize
    @entry_station = nil
    @journey = {}
    @travel_status = false
  end

  def touch_in(entry_station, oystercard)
    raise "balance under £#{Oystercard::MINIMUM_AMOUNT}" if oystercard.balance < (Oystercard::MINIMUM_AMOUNT)

    @travel_status = true
    @entry_station = entry_station
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_out(exit_station, oystercard)
    oystercard.deduct(Oystercard::MINIMUM_AMOUNT)

    @exit_station = exit_station
    make_journey(oystercard)
  end

  def make_journey(oystercard)
    @travel_status = false
    update_recent_journey
    add_journey_to_history(oystercard)
  end

  def add_journey_to_history(oystercard)
    oystercard.history.append(@journey)
    reset_stations
  end

  def update_recent_journey
    @journey[:in] = @entry_station
    @journey[:out] = @exit_station
  end

  def reset_stations
    @entry_station = nil
    @exit_station = nil
  end

  def fare(_oystercard)
    !@journey[:in].nil? && !@journey[:out].nil? ? Oystercard::MINIMUM_FARE : Oystercard::PENALTY_FARE
  end
end
