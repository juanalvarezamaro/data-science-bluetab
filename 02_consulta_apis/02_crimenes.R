library("httr")

# Configuramos los datos de llamada a la API
api_url <- "http://nominatim.openstreetmap.org/reverse"
parameters <- list(lat=51.4965946, lon=-0.1436476, 
                  addressdetails=1,format="jsonv2")
# Ejecutamos llamada a la API
location <- GET(api_url,query = parameters)

# Recuperamos el place_id aunque no lo utilizaremos porque hemos comprobado
# que la API de la policía no devuelve nada con ese ID
place_id <- content(location)$place_id

# Configuramos los datos de llamada a la API
api_url <- "https://data.police.uk/api/crimes-at-location"
parameters <- list(date="2017-04",lat=51.4965946,lng=-0.1436476)

# Ejecutamos llamada a la API
crimes <- GET(api_url,query = parameters)
crimes_content<-content(crimes)

# Creamos una lista vacía para almacenar las categorías y recorremos la lista
# de crímenes devuelta por la API para contar el número de crímenes de cada 
# categoría
crime_categories <- list()
for (crime in crimes_content){
  if (is.null(crime_categories[[crime$category]])){
    crime_categories[[crime$category]] <- 1
  } else {
    crime_categories[[crime$category]] <- crime_categories[[crime$category]] + 1
  }
}

# Sacamos por pantalla los conteos realizados.
print(unlist(crime_categories))

