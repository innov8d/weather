class ForecastController < ApplicationController
  def forecast
    forecast_service = ForecastService.new
    forecast = forecast_service.get_forecast(params[:address])
    
    @address = params[:address]
    @live_data = forecast[:live_data]
    @forecast = forecast[:forecast]
  end
end