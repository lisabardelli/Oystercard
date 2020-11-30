require "oystercard/version"

module Oystercard
  class Card

    def initialize
      @balance = 0
    end

    def top_up(money)
      @balance = @balance + money
    end

    def balance
      @balance
    end
  end
end
