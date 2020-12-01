require "./lib/oystercard.rb"

oc = Oystercard.new
oc.top_up(10)
oc.history_of_journeys
oc.touch_in("holborn")
oc.touch_out("chancery lane")
oc.history_of_journeys
oc.touch_in("notting hill")
oc.touch_out("chancery lane")
print oc.history_of_journeys