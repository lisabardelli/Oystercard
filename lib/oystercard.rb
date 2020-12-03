require "oystercard/version"

module Oystercard
  class Card
    MAX_BALANCE = 100
    MIN_FARE = 1
    attr_reader :balance, :entry_station

    def initialize
      @balance = 0
      @entry_station = entry_station
    end

#this method has been tested
    def top_up(money)
      fail "Exceeds max balance" if balance + money >= MAX_BALANCE
      @balance = @balance + money
    end

#this method has been tested
    def touch_in(entry_station)
      fail "Insufficient funds" if balance < MIN_FARE
      @entry_station = entry_station
    end

#this method has been tested
    def in_journey?
      !!@entry_station
    end

#this method has been tested
    def touch_out
      deduct(MIN_FARE)
      @entry_station = nil
    end

    private

    def deduct(money)
      @balance = @balance - money
    end
  end
end
