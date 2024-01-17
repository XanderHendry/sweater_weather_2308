# README

#Sweater Weather - API Only
---
###End Points:

```
  get '/api/v0/forecasts?location=QUERY'
  post '/api/v0/users'
  post '/api/v0/sessions'
  post '/api/v0/road_trip
```
---
* Forecast Endpoint
  - Returns a 5 day weather weather forecast for the given location.
  - Output will be a hash with current, daily, and hourly weather keys nested inside an attributes key.
---
* User Registration Endpoint
  - Allows a new user to register with the API.
  - User details (email, password, and password confirmation) must be passed as a json payload in   the body of the request.
  - Output will be a hash with the users email, and an api key.
  - Will return an error if a field is blank, email is not unique, or if passwords don't match
---
* User Login Endpoint
  - Allows a registered user to access their API key by providing credentials.
  - User credentials (email, password) must be passed as a json payload in the body of the request.
  - Output will be a hash with the users email, and an api key.
  - Will return an error if field is blank, or if credentials are bad
---
* Road Trip Endpoint
  - Allows a registered user to request road trip info.
  - Query params (origin, destination, api key) must be passed as a json payload in the body of the request.
  - Output will be a have Start City, End City, Travel Time, and a Weather At Eta hash with Datetime, Temperature, and Conditions.
  - Will return a travel time of impossible and an empty weather block if a route can't be completed
  - Will return an authorization error if the api key is invalid
