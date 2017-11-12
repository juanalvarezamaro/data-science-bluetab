monedas <- c(200, 100, 50, 20, 10, 5, 2, 1)

combinations <- function(importe, monedas, maxmoneda = 200){
  count <- 0
  for (moneda in monedas){
    if (moneda <= maxmoneda & moneda <= importe){
      if (moneda == importe){
        count <- count + 1
      } else if (moneda < importe){
        count <- count + combinations(importe-moneda,monedas,moneda)
      }
    }
    
  }
  
  count
}

combinations(200,monedas)
