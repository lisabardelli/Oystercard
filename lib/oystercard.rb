require_relative 'station'

class Oystercard # class (Object)
  attr_accessor :balance, :capacity, :minimum_fare, :start_station, :exit_station, :num_of_journeys # when we need to change variables attr accessor allows us both read and write instance variables without using def name @name end (reader) and def name=(str) @name = str end (writer)


  DEFAULT_CAPACITY = 90 # constant is like a variable except its value is supposed to remain constant for the duration of the program (allows it to be changed for different users i.e different capacity/different prices etc)
  MINIMUM_FARE = 1

  def initialize  # this allows the class to know what each of the below methods gives us
    @balance = 0 # sets starting balance to 0 
    @capacity = DEFAULT_CAPACITY #sets capacity to the value of the DEFAULT_CAPACITY constant
    @in_use = false # sets the starting status of in_use as false as it hasnt been used yet
    @minimum_fare = MINIMUM_FARE  #sets the minimum_fare to the value of the MINIMUM_FARE constant
    @start_station = ""
    @exit_station = ""
    @journeys = {}
    @num_of_journeys = 0
  end

  def top_up(money) #method (property of owner)
    fail "Cap  of #{@capacity} reached" if (@balance + money) > @capacity # fail if balance + money is more than the capacity of the oystercard
    @balance += money # same as balance = balance + money
  end

  def deduct(money) # method (property of owner) with the argument of money as you want call money on deduct
    @balance -= money # same as balance = balance - money
  end
 
   def touch_in(station) #method with the argument of station 
    fail "Not enough funds" if @balance < 1 # fail if balance is below one (as it is lower than minimum fair)
    @start_station = station #start station is equal to the station we touch_in at 

  end

  def touch_out(station) #method of touch_out
    deduct(@minimum_fare) #deducts the minimum fare from the balance when touch_out is called
    @exit_station = station
    @num_of_journeys +=1

    
  end
  def history_of_journeys
    journey = @journeys[@num_of_journeys] = [@start_station]
    journey = @journeys[@num_of_journeys].push(@exit_station)
  end

  def in_journey? #method of in_journey
    @start_station# if in_use is equal to true then oystercard is in journey
  end

  def station #method of station
  end

  private #private method provides functionality for the public methods the user wants to see (but is not needed for user)

  def deduct(money) #as deduct provides functionality for touch_out it is no longer needed in the public method
    @balance -= money # same as balance = balance - money (therefore deducting it)
  end

  def empty? 
    true
  end
end
