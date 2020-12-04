require 'journey'

class JourneyLog
  attr_reader :class_journey, :journeys, :entry_station

  def intialize(class_journey = Journey)
    @class_journey = class_journey
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
    @journey = @class_journey.new
    @journey.touch_in(entry_station, oystercard)
  end

  private

  def current_journey; end
end

