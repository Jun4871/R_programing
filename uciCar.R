uciCar <- read.table(
  "http://www.win-vector.com/dfiles/car.data.csv",
  sep = ",",
  header = TRUE
)


class(uciCar)
summary(uciCar)
dim(uciCar)

custdata <- read.table("https://github.com/WinVector/zmPDSwR/tree/master/Custdata/custdata.tsv", header = TRUE, sep = "/")

require(RCurl)

urlBase <- "https://raw.github.com/WinVector/zmPDSwR/master/"
mkCon <- function(nm) {
  textConnection(getURL(paste(urlBase,nm,sep = "")))
}

cars <- read.table(mkCon("UCICar/car.data.csv"), sep ="," ,header = TRUE, comment.char = "")

