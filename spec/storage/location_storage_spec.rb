require "rails_helper"

RSpec.describe LocationStorage do
  it "throws an Argument error when no address is passed" do
    allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({})
    l = LocationStorage.new
    expect {l.addressToCoords}.to raise_error(ArgumentError)
  end

  it "throws an Argument error when an empty address is passed" do
    allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({})
    l = LocationStorage.new
    expect {l.addressToCoords}.to raise_error(ArgumentError)
  end

  it "throws an Argument error when no address is passed" do
    allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({})
    l = LocationStorage.new
    expect {l.addressToCoords('')}.to raise_error(ArgumentError)
  end

  it "throws an RuntimeError error when no forecast data is returned" do
    allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({})
    l = LocationStorage.new
    expect {l.addressToCoords("1600 Pennsylvania Avenue NW, Washington, DC 20500")}.to raise_error(NoAddressesError)
  end

  it "throws an RuntimeError error when no forecast data is returned #2" do
    allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({'addresses' => []})
    l = LocationStorage.new
    expect {l.addressToCoords("1600 Pennsylvania Avenue NW, Washington, DC 20500")}.to raise_error(NoAddressesError)
  end

  it "succeeds when a location is passed and location data is found for it" do
    # allow_any_instance_of(LocationStorage).to receive(:get_location).and_return({'addresses' => [ { 'latitude' =>  38.898819, 'longitude' => -77.036690, 'postalCode' => '20500' } ]})
    l = LocationStorage.new
    location = l.addressToCoords("1600 Pennsylvania Avenue NW, Washington, DC 20500")
    expect(location[:latitude]).to eq(38.898)
    expect(location[:longitude]).to eq(-77.036)
    expect(location[:postalCode]).to eq('20500')
  end
end