library("httr")

api_url <- "http://www.cartociudad.es/services/api/geocoder/reverseGeocode"
parameters <- list(lat=36.9003409, lon=-3.4244838)

location <- GET(api_url,query = parameters)

content(location)
status_code(location)
headers(location)