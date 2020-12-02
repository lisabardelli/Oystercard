class Station
  attr_reader :station_name

  ZONES = {
    'Farringdon' => 1,
    'Oxford Circus' => 1,
    'Stockwell' => 2,
    'Streatham' => 3,
    'Richmond' => 4
  }.freeze

  def initialize(station_name)
    @station_name = station_name
  end

  def return_zone
    ZONES[station_name]
  end
end
