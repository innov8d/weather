class WeatherStorage
  include HTTParty
  base_uri 'https://api.tomorrow.io/v4/weather/'

  def weatherForCoords(latitude, longitude)
    raise ArgumentError, 'you must supply a latitude' if latitude.blank?
    raise ArgumentError, 'you must supply a longitude' if longitude.blank?

    query = {
      apikey: ENV['TOMORROW_KEY'], 
      location: "#{latitude},#{longitude}",
      fields: 'temperature',
      units: 'imperial',
      timesteps: '1d', 
      endTime: 'nowPlus5D' 
    }

    forecast = self.class.get('/forecast', { query: query })

    forecast['timelines']['daily'].map { |forecast| convert_forecast(forecast) }
  end

  private

  def convert_forecast(forecast)
    {
      time: forecast['time'], 
      temperatureMax: forecast['values']['temperatureMax'],
      temperatureMin: forecast['values']['temperatureMin'],
      weatherCode: forecast['values']['weatherCodeMax']
    }
  end
end
