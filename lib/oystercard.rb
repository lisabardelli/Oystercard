require './lib/oystercard'
module Oystercard
  class Card
    MAX_BALANCE = 100
    MIN_FARE = 1
    attr_reader :balance, :entry_station, :exit_station
    attr_accessor :journeys

    def initialize
      @balance = 0
      @entry_station = entry_station
      @exit_station = exit_station
      @journeys = []
      @journey = { in: nil, out: nil }
    end

    def top_up(money)
      raise 'Exceeds max balance' if balance + money >= MAX_BALANCE

      @balance += money
    end

    def touch_in(entry_station)
      raise 'Insufficient funds' if balance < MIN_FARE

      @entry_station = entry_station
    end


    def in_journey?
      !!@entry_station
    end

  
    def touch_out(exit_station)
      deduct(MIN_FARE)
      

      @exit_station = exit_station
    end

    def store_journey
      @journey[:in] = @entry_station
      @journey[:out] = @exit_station
      @journey
    end

    private

    def deduct(money)
      @balance -= money
    end
  end
end
