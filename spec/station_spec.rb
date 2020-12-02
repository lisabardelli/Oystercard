require 'station'

describe Station do
  let(:station) { Station.new('Farringdon') }

  it 'expects station to be an instance of the station class' do
    expect(station).to be_an_instance_of(Station)
  end

  it 'responds to return zone method' do
    expect(station).to respond_to(:return_zone)
  end

  it 'returns the zone of the station' do
    expect(station.return_zone).to eq 1
  end

  it 'returns the zone 3 if the station is Streatham' do
    station_one = Station.new('Streatham')
    expect(station_one.return_zone).to eq 3
  end
end
