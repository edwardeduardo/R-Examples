###################################################
### chunk number 1: 
###################################################
#line 6 "appb.Rnw"
options(prompt="R> ")
options(width=80)


###################################################
### chunk number 2: 
###################################################
#line 52 "appb.Rnw"
require(quantmod)
getSymbols("AAPL")


###################################################
### chunk number 3: qmod1 eval=FALSE
###################################################
## #line 57 "appb.Rnw"
## chartSeries(AAPL, theme="white",TA=NULL)


###################################################
### chunk number 4: 
###################################################
#line 62 "appb.Rnw"
#line 57 "appb.Rnw#from line#62#"
chartSeries(AAPL, theme="white",TA=NULL)
#line 63 "appb.Rnw"


###################################################
### chunk number 5: qmod2 eval=FALSE
###################################################
## #line 70 "appb.Rnw"
## chartSeries(AAPL, theme="white", TA="addVo();addBBands();addCCI()")


###################################################
### chunk number 6: 
###################################################
#line 75 "appb.Rnw"
#line 70 "appb.Rnw#from line#75#"
chartSeries(AAPL, theme="white", TA="addVo();addBBands();addCCI()")
#line 76 "appb.Rnw"


###################################################
### chunk number 7: 
###################################################
#line 95 "appb.Rnw"
X <- ts(1:10, frequency = 4, start = c(1959, 2))
X


###################################################
### chunk number 8: 
###################################################
#line 100 "appb.Rnw"
set.seed(123)
X <- ts(cumsum(1 + round(rnorm(100), 2)), start = c(1954, 7), frequency = 12)
X


###################################################
### chunk number 9: 
###################################################
#line 107 "appb.Rnw"
time(X)[1:10]
deltat(X)
start(X)
end(X)
frequency(X)


###################################################
### chunk number 10: 
###################################################
#line 116 "appb.Rnw"
window(X, frequency=4)


###################################################
### chunk number 11: 
###################################################
#line 123 "appb.Rnw"
require(zoo)
X <- zoo( rnorm(10) )
X
str(X)


###################################################
### chunk number 12: 
###################################################
#line 130 "appb.Rnw"
index(X)


###################################################
### chunk number 13: 
###################################################
#line 134 "appb.Rnw"
X <- zoo( rnorm(10), order.by = cumsum(rexp(10,rate=0.1)))
X
str(X)


###################################################
### chunk number 14: 
###################################################
#line 140 "appb.Rnw"
Xreg <- zooreg(cumsum(1 + round(rnorm(100), 2)), start = c(1954, 7), frequency = 12)
time(Xreg)[1:10]


###################################################
### chunk number 15: 
###################################################
#line 145 "appb.Rnw"
Y <- as.ts(X)
time(X)
time(Y)


###################################################
### chunk number 16: 
###################################################
#line 153 "appb.Rnw"
require(xts)
X <- xts( rnorm(10), order.by = as.Date(cumsum(rexp(10,rate=0.1))))
X
str(X)


###################################################
### chunk number 17: xts eval=FALSE
###################################################
## #line 162 "appb.Rnw"
## plot(X)


###################################################
### chunk number 18: 
###################################################
#line 167 "appb.Rnw"
#line 162 "appb.Rnw#from line#167#"
plot(X)
#line 168 "appb.Rnw"


###################################################
### chunk number 19: 
###################################################
#line 178 "appb.Rnw"
require(tseries)
X <- irts(  cumsum(rexp(10,rate=0.1)), rnorm(10))
X
str(X)


###################################################
### chunk number 20: 
###################################################
#line 188 "appb.Rnw"
require(timeSeries)
X <- timeSeries( rnorm(10),  as.Date(cumsum(rexp(10,rate=0.1))))
X
str(X)


###################################################
### chunk number 21: 
###################################################
#line 199 "appb.Rnw"
d <- ISOdate(2006,6,9)
d


###################################################
### chunk number 22: 
###################################################
#line 204 "appb.Rnw"
args(ISOdate)


###################################################
### chunk number 23: 
###################################################
#line 209 "appb.Rnw"
class(d)


###################################################
### chunk number 24: 
###################################################
#line 214 "appb.Rnw"
names(as.POSIXlt(d))
unlist(as.POSIXlt(d))


###################################################
### chunk number 25: 
###################################################
#line 220 "appb.Rnw"
format(d,"%a") # week day
format(d,"%A")

format(d,"%b") # month
format(d,"%B")

format(d,"%c") # full date

format(d,"%D") # yy/dd/mm
format(d,"%T") # hh:mm:ss

format(d,"%A %B  %d %H:%M:%S %Y")
format(d,"%A   %d/%m/%Y")
format(d,"%d/%m/%Y (%A)")


###################################################
### chunk number 26: 
###################################################
#line 238 "appb.Rnw"
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
strptime(x, "%d%b%Y")


###################################################
### chunk number 27: 
###################################################
#line 243 "appb.Rnw"
Sys.getlocale()
Sys.setlocale("LC_ALL", "it_it")
strptime(x, "%d%b%Y")
Sys.setlocale("LC_ALL", "en_GB")
strptime(x, "%d%b%Y")


###################################################
### chunk number 28: 
###################################################
#line 251 "appb.Rnw"
format(ISOdate(2006,6,9),"%H:%M:%S")
format(as.POSIXct("2006-06-09"),"%H:%M:%S")


###################################################
### chunk number 29: 
###################################################
#line 258 "appb.Rnw"
holidayNYSE()
holidayNERC()


###################################################
### chunk number 30: 
###################################################
#line 263 "appb.Rnw"
ISOdate(2006,6,9) - ISOdate(2006, 3, 1)


###################################################
### chunk number 31: 
###################################################
#line 267 "appb.Rnw"
my.dates = timeDate(c("2001-01-05", "2001-02-15")) 
my.dates[2] - my.dates[1]


###################################################
### chunk number 32: 
###################################################
#line 272 "appb.Rnw"
listFinCenter("Europe*")


###################################################
### chunk number 33: 
###################################################
#line 276 "appb.Rnw"
timeDate("2001-01-05", Fin="Europe/Paris") -> d1
timeDate("2001-01-05", Fin="America/New_York") -> d2
d1
d2


###################################################
### chunk number 34: 
###################################################
#line 288 "appb.Rnw"
set.seed(123) 
data <- rnorm(6) 
charvec <- paste("2009-0", 1:6, "-01", sep = "") 
charvec


###################################################
### chunk number 35: 
###################################################
#line 295 "appb.Rnw"
X <- zoo(data, as.Date(charvec))
Y <- xts(data, as.Date(charvec))
Z <- timeSeries(data, charvec)


###################################################
### chunk number 36: 
###################################################
#line 301 "appb.Rnw"
X
Y
Z


###################################################
### chunk number 37: 
###################################################
#line 307 "appb.Rnw"
z1 <- zoo(data, as.POSIXct(charvec))
z2 <- zoo(data, ISOdatetime(2009, 1:6, 1, 0,0,0))
z3 <- zoo(data, ISOdate(2009, 1:6, 1, 0))
z1
z2
z3


###################################################
### chunk number 38: 
###################################################
#line 318 "appb.Rnw"
set.seed(123) 
d1 <- rnorm(5) 
d2 <- rnorm(7) 
date1 <- ISOdate(2009,1:5,1)
date2 <- ISOdate(2009,6:12,1)
z1 <- zoo(d1, date1)
z2 <- zoo(d2, date2)
rbind(z1,z2)
x1 <- xts(d1, date1)
x2 <- xts(d2, date2)
rbind(x1,x2)
s1 <- timeSeries(d1, date1)
s2 <- timeSeries(d2, date2)
rbind(s1,s2)


###################################################
### chunk number 39: 
###################################################
#line 336 "appb.Rnw"
date2 <- ISOdate(2009,4:10,1)
z2 <- zoo(d2, date2)


###################################################
### chunk number 40:  eval=FALSE
###################################################
## #line 341 "appb.Rnw"
## rbind(z1,z2)


###################################################
### chunk number 41: 
###################################################
#line 344 "appb.Rnw"
cat(unclass(try(rbind(z1,z2))))


###################################################
### chunk number 42: 
###################################################
#line 348 "appb.Rnw"
x2 <- xts(d2, date2)
rbind(x1,x2)
s2 <- timeSeries(d2, date2)
rbind(s1,s2)


###################################################
### chunk number 43: 
###################################################
#line 355 "appb.Rnw"
merge(z1,z2)
merge(x1,x2)


###################################################
### chunk number 44: 
###################################################
#line 360 "appb.Rnw"
merge(s1,s2)


###################################################
### chunk number 45: 
###################################################
#line 364 "appb.Rnw"
s2 <- timeSeries(d2, date2,units="s2")
merge(s1,s2)


###################################################
### chunk number 46: 
###################################################
#line 369 "appb.Rnw"
date1 <- ISOdate(2009,1:5,1)
date2 <- ISOdate(2009,6:12,1)
s1 <- timeSeries(d1, date1)
s2 <- timeSeries(d2, date2)
rbind(s1,s2)
rbind(s2,s1)


###################################################
### chunk number 47: 
###################################################
#line 378 "appb.Rnw"
sort( rbind(s2,s1) )
sort( rbind(s2,s1), decr=TRUE)


###################################################
### chunk number 48: 
###################################################
#line 383 "appb.Rnw"
s2
rev(s2)


###################################################
### chunk number 49: 
###################################################
#line 390 "appb.Rnw"
require(sde)
data(quotes)
str(quotes)


###################################################
### chunk number 50: 
###################################################
#line 397 "appb.Rnw"
quotes[1,1:5]
quotes[1:10,"MSOFT"]


###################################################
### chunk number 51: 
###################################################
#line 402 "appb.Rnw"
quotes$MSOFT[1:10]


###################################################
### chunk number 52: 
###################################################
#line 406 "appb.Rnw"
date <- as.Date(sprintf("2006-07-%.2d",1:10))
date
quotes[date, 1:5]


###################################################
### chunk number 53: 
###################################################
#line 413 "appb.Rnw"
start <- as.Date("2006-06-25")
end <- as.Date("2006-07-10")
quotes[ (time(quotes) >= start) & (time(quotes)<= end), 1:5]


###################################################
### chunk number 54: 
###################################################
#line 423 "appb.Rnw"
getSymbols("AAPL")
attr(AAPL, "src")


###################################################
### chunk number 55: 
###################################################
#line 428 "appb.Rnw"
getSymbols("AAPL",src="google")
attr(AAPL, "src")


###################################################
### chunk number 56: 
###################################################
#line 433 "appb.Rnw"
getSymbols("DEXUSEU",src="FRED")
attr(DEXUSEU, "src")
getSymbols("EUR/USD",src="oanda")
attr(EURUSD, "src")
str(EURUSD)


###################################################
### chunk number 57: 
###################################################
#line 443 "appb.Rnw"
require(fImport)
X <- yahooSeries("AAPL")
str(X)


###################################################
### chunk number 58: 
###################################################
#line 449 "appb.Rnw"
X <- yahooImport("AAPL")
str(X)


###################################################
### chunk number 59: 
###################################################
#line 458 "appb.Rnw"
x <- get.hist.quote("AAPL")
str(x)
x <- get.hist.quote(instrument = "EUR/USD", provider = "oanda", start = Sys.Date() - 300)
str(x)


