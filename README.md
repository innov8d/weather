# README

This project implements a simple application which allows you to enter an address and the
6-day forecast will be displayed.

* Ruby version

3.3.4

* Rails version

7.2.1.1

* Configuration

Copy .env file to root of the project (not the app base).
bundle install
./bin/dev

* Database creation

No database required.

* How to run the test suite

Run the test suite by running bundle exec rspec.

* Services (job queues, cache servers, search engines, etc.)

Gets location data from radar.io, this gives us lat/long for and address
Gets weather forecast data from tomorrow.io, this takes lat/long and returns a forecast for 6 days

* Architecture

I chose a basic three-tier application. In this, the controllers can call the services, and the services
can call the storage layer. In most applications the storage layer would include database access, but
the requirements of the application did not require a database. So the third tier are the calls to 
RADAR and Tomorrow.

* Scalability

For a true production I was use redis for the cache. This would allow for multiple machines and 
processes to share a cache. Right now Puma is limited to 1 thread to get the file-based cache
work.

The lat/long could be cached by reduce calls to Radar, but it was judged for initial implementation
it was more important to cache the calls to Tomorrow.

* Class decomposition

The most significant example of decomposition in this project is splitting the ForecastService into 
two additional classes that each perform a single action. For the LocationStorage service, it take an 
address and returns lat/long. For the WeatherStorageService, it take a lat/long and returns a 6 day 
forecast.

