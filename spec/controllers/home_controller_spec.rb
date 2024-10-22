require "rails_helper"

RSpec.describe HomeController, type: :controller do
  it "response successfully" do
     get :index 
     expect(response.status).to eq(200)
     expect(response).to render_template("home/index")
     expect(response).to render_template("layouts/application")
  end
end
