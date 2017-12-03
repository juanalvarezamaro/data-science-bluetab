library("XML")
library("plyr")
library("dplyr")

daysinmonth <- function(month, year) {
  stopifnot(month > 0, month < 13, year > 1970, year < 3000)
  date1 <- as.Date(paste(as.character(year),sprintf("%02d",month),"01",sep=""),"%Y%m%d")
  
  if (month == 12) {
    date2 <- as.Date(paste(as.character(year+1),"0101",sep=""),"%Y%m%d")
  } else {
    date2 <- as.Date(paste(as.character(year),sprintf("%02d",month+1),"01",sep=""),"%Y%m%d")
  }
  as.character(difftime(date2,date1))
}

weather_table
month_weather <- function(month, year) {
    ndays <- daysinmonth(month, year)
    uri <- paste("http://www.ogimet.com/cgi-bin/gsynres?ord=REV&decoded=yes&ndays=",
                 ndays,"&ano=",as.character(year),"&mes=",as.character(month),
                 "&day=",ndays,"&hora=24&ind=08221",sep="")
    weather_table <- readHTMLTable(uri)[[1]]
    weather_table$V1 <- as.POSIXct(paste(substr(weather_table$V1,1,10),
                                         substr(weather_table$V2,1,5)), 
                                   format="%d/%m/%Y %H:%M")
    my_rows <- !is.na(weather_table$V1)
    my_rows
    
    my_cols <- c(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, 
                 FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, 
                 FALSE, FALSE, FALSE, FALSE)
    weather_table[my_rows,my_cols]
}

weather2008 <- sapply(c(1:12), month_weather, year = 2008) %>% 
               rbind.fill %>% 
               distinct %>%
               `[`(,1:4)

colnames(weather2008) <- c("Hora", "Temperatura", "Dirección V.", "Velocidad. V." )
