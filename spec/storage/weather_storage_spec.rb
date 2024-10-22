require "rails_helper"

RSpec.describe WeatherStorage do
  it "should throw an ArgumentError if no arguments is passed" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({})
    w = WeatherStorage.new
    expect {w.weatherForCoords}.to raise_error(ArgumentError)
  end

  it "should throw an ArgumentError if no longititude is passed" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({})
    w = WeatherStorage.new
    expect {w.weatherForCoords(38.898, nil)}.to raise_error(ArgumentError)
  end

  it "should throw an ArgumentError if no longititude is passed" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({})
    w = WeatherStorage.new
    expect {w.weatherForCoords(nil, -77.036)}.to raise_error(ArgumentError)
  end

  it "should return an empty array when get_forecast returns nil" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return(nil)

    w = WeatherStorage.new
    forecast = w.weatherForCoords(38.898, -77.036)
    puts forecast

    expect(forecast.empty?).to be_truthy
  end

  it "should return an empty array when get_forecast returns an empty object" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({})

    w = WeatherStorage.new
    forecast = w.weatherForCoords(38.898, -77.036)

    expect(forecast.empty?).to be_truthy
  end

  it "should return an empty array when get_forecast returns a partial object" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({timelines: {}})

    w = WeatherStorage.new
    forecast = w.weatherForCoords(38.898, -77.036)

    expect(forecast.empty?).to be_truthy
  end

  it "should return an empty array when get_forecast returns a partial object" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({timelines: { daily: nil }})

    w = WeatherStorage.new
    forecast = w.weatherForCoords(38.898, -77.036)

    expect(forecast.empty?).to be_truthy
  end

  it "should return an empty array when get_forecast returns a partial object" do
    allow_any_instance_of(WeatherStorage).to receive(:get_forecast).and_return({
      'timelines' => { 
        'daily' =>
          [ 
            { 'time' => '2024-10-22T11:00:00Z', 'values' => { 'temperatureMax' => 70, 'temperatureMin' => 45, 'weatherCodeMax' =>  1000 } },
            { 'time' => '2024-10-23T11:00:00Z', 'values' => { 'temperatureMax' => 70, 'temperatureMin' => 45, 'weatherCodeMax' =>  1000 } },
            { 'time' => '2024-10-24T11:00:00Z', 'values' => { 'temperatureMax' => 70, 'temperatureMin' => 45, 'weatherCodeMax' =>  1000 } },
            { 'time' => '2024-10-25T11:00:00Z', 'values' => { 'temperatureMax' => 70, 'temperatureMin' => 45, 'weatherCodeMax' =>  1000 } },
            { 'time' => '2024-10-26T11:00:00Z', 'values' => { 'temperatureMax' => 70, 'temperatureMin' => 45, 'weatherCodeMax' =>  1000 } },
          ]
        }
    })

    w = WeatherStorage.new
    forecast = w.weatherForCoords(38.898, -77.036)
    expect(forecast.length).to eq(5)
    expect(forecast.first[:time]).to eq('October 22, 2024')
  end
end