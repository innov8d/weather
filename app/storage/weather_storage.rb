class WeatherStorage
  include HTTParty
  base_uri 'https://api.tomorrow.io/v4/weather/'

  # Calls Tomorrow.io for the given latitude and longitude
  # returns an array of: {time, temperatireMax, temperatureMin, WeatherCode}
  def weatherForCoords(latitude, longitude)
    raise ArgumentError, 'you must supply a latitude' if latitude.blank?
    raise ArgumentError, 'you must supply a longitude' if longitude.blank?

    forecast = get_forecast(latitude, longitude)

    forecast&.[]('timelines')&.[]('daily')&.map { |forecast| convert_forecast(forecast) } || []
  end

  private

  def get_forecast(latitude, longitude)
    query = {
      apikey: ENV['TOMORROW_KEY'], 
      location: "#{latitude},#{longitude}",
      fields: 'temperature',
      units: 'imperial',
      timesteps: '1d', 
      endTime: 'nowPlus5D' 
    }

    forecast = self.class.get('/forecast', { query: query })
  end

  def convert_forecast(forecast)
    {
      time: Date.parse(forecast['time']).to_fs(:long), 
      temperatureMax: forecast['values']['temperatureMax'],
      temperatureMin: forecast['values']['temperatureMin'],
      weatherCode: forecast['values']['weatherCodeMax']*10
    }
  end
end
