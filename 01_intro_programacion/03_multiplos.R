multiples <- c(3,5)

for (i in 6:1000) {
  if (i%%3 == 0 | i%%5 == 0)
    multiples <- c(multiples,i)
}

sum(multiples)
