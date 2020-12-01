require "oystercard/version"

module Oystercard
  class Card
    MAX_BALANCE = 100
    attr_reader :balance, :in_use

    def initialize
      @balance = 0
      @in_use = false
    end

    def top_up(money)
      fail "Exceeds max balance" if balance + money >= MAX_BALANCE
      @balance = @balance + money
    end

    def touch_in
      @in_use = true
    end

    def in_journey?
      @in_use
    end

    def touch_out
      @in_use = false
    end

    def deduct_fare(money)
      @balance = @balance - money
    end
  end
end
