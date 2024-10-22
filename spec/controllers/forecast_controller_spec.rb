require "rails_helper"

RSpec.describe ForecastController, type: :controller do
  it "response successfully" do
     post :forecast, params: { address: "1600 Pennsylvania Avenue NW, Washington, DC 20500" }
     expect(response.status).to eq(200)
     expect(response).to render_template("forecast/forecast")
     expect(response).to render_template("layouts/application")
  end

  context "with render_views" do
    render_views

    it "displays live data" do
      post :forecast, params: { address: "1600 Pennsylvania Avenue NW, Washington, DC 20500" }
      expect(response.body).to match(/LIVE DATA/)
      expect(response.body).to match(/1600 Pennsylvania Avenue NW, Washington, DC 20500/)
    end
  end
end
