require "./lib/oystercard.rb"
require "./lib/journey.rb"

journey1 = Journey.new
journey2 = Journey.new
journey3 = Journey.new
oc = Oystercard.new
p oc.top_up(10)
p journey1.touch_in("holborn", oc)
p journey1.touch_out("chancery lane", oc)
p oc.history
p journey2.touch_in("notting hill", oc)
p journey2.touch_out("oxford circus", oc)
p oc.history
p journey3.touch_in("st paul", oc)
p journey3.touch_out("angel", oc)
p oc.history