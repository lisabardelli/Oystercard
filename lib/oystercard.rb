require "oystercard/version"

module Oystercard
  class Card
    MAX_BALANCE = 100
    attr_reader :balance

    def initialize
      @balance = 0
    end

    def top_up(money)
      fail "Exceeds max balance" if balance + money >= MAX_BALANCE
      @balance = @balance + money
    end

    def deduct_fare(money)
      @balance = @balance - money
    end
  end
end
