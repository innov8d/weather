require "rails_helper"

RSpec.describe ForecastService do
  it "responds successfully" do
    allow_any_instance_of(LocationStorage).to receive(:addressToCoords).and_return(
      { latitude: 38.898819, longitude: -77.036690, postalCode: '003820' }
    )
    allow_any_instance_of(WeatherStorage).to receive(:weatherForCoords).and_return(
      { 
        timelines: {
          daily: [
            { 'time' => '2024-10-21T11:00:00Z', 'temperatureMax' => 72.73, 'temperatureMin' => 41.9, 'weatherCodeMax'=> 1001 },
            { 'time' => '2024-10-22T11:00:00Z', 'temperatureMax' => 72.73, 'temperatureMin' => 41.9, 'weatherCodeMax'=> 1001 },
            { 'time' => '2024-10-23T11:00:00Z', 'temperatureMax' => 72.73, 'temperatureMin' => 41.9, 'weatherCodeMax'=> 1001 },
            { 'time' => '2024-10-24T11:00:00Z', 'temperatureMax' => 72.73, 'temperatureMin' => 41.9, 'weatherCodeMax'=> 1001 },
            { 'time' => '2024-10-25T11:00:00Z', 'temperatureMax' => 72.73, 'temperatureMin' => 41.9, 'weatherCodeMax'=> 1001 },
          ]
        }
      }
    )

    f = ForecastService.new
    forecast = f.get_forecast('1600 Pennsylvania Avenue NW, Washington, DC 20500')

    expect(forecast[:forecast][:timelines][:daily].length).to eq(5)
  end
end


