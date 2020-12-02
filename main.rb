require "./lib/oystercard.rb"

oc = Oystercard.new
oc.top_up(10)
# oc.history_of_journeys
oc.touch_in("holborn")
oc.touch_out("chancery lane")
oc.touch_in("notting hill")
oc.touch_out("chancery lane")
puts oc.journeys