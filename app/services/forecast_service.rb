class ForecastService
  def get_forecast(address)
    location_storage = LocationStorage.new
    coords = location_storage.addressToCoords(address)
    
    weather_storage = WeatherStorage.new

    live_data = false
    forecast = Rails.cache.fetch("#{coords[:postalCode]}-forecast", expires_in: 30.minutes) do
      live_data = true
      weather_storage.weatherForCoords(coords[:latitude], coords[:longitude])
    end

    {
      live_data: live_data,
      forecast: forecast
    }
  end
end
