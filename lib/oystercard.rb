require_relative './journey.rb'
class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :balance, :entry_station, :exit_station, :history, :journey

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
