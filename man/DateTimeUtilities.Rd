\name{DateTimeUtilities}
\alias{move}
\alias{generatefwd}
\alias{ftseq}
\title{
  A small set of utilities to work with some time and date classes.
}
\description{
These utilities will likely be useful for working with the forecast objects
of the package which have a rather complex structure. In addition, the ftseq
function is of particular value in generating intraday regularly spaced time and 
date sequences within a specific interval of times (e.g. 09:30 to 16:00).
}
\usage{
move(index, by=1)
generatefwd(T0, length.out = 1, by = "days")
ftseq(T0, length.out, by, interval, exclude.weekends = TRUE)
}
\arguments{
\item{index}{
A POSIXct, Date or numeric vector.}
\item{T0}{
A single POSIXct, Date or numeric value from which to generate forward values (
the returned vector will exclude this value). For the ftseq function, this 
must be a Date AND Time object of class POSIXct.}
\item{by}{
For the move function, the length by which to shift the index forward, truncating
the first values and extending the last by this amount. For the generatefwd or 
ftseq function, either a character (see Date and Time classes for valid values), 
numeric or difftime object (see details).}
\item{length.out}{
The length of the forward generated indices (excluding T0 which is not returned).
}
\item{interval}{
A character vector of the regularly sampled times which define the trading day 
(see example).
}
\item{exclude.weekends}{
Whether to exclude the weeekends.
}
}
\details{
Every object returned by one of the main methods in rugarch (including ugarchfit,
ugarchfilter, ugarchforecast and ugarchsim) has a model slot attached which in
turns hold details on the time index of the original dataset used (including a
difftime object). In addition, extractors for the forecast class, uGARCHforecast, 
will usually return a matrix with the (n.roll+1) columns having the T+0 dates, 
and the rows names represented as characters \sQuote{T+1,...,T+n} indicating the 
forecast periods following the T+0 date.\cr
For the rolling forecast, it is a simple matter to shift the T+0 date by 1 to
obtain the actual forecast date. Because rolling forecasts are made using the
\sQuote{out.sample} switch, this means that there is always an actual date 
attached to this forecast based on the realized out.sample data (with the 
exception of the case when n.roll=out.sample in which case the last forecast is 
completely out of the range of the dataset). One quick way of obtaining the actual 
T+1 rolling dates is to just pass the vector of T+0 dates to the move function 
as shown in the examples.\cr
For the n.ahead>1 unconditional forecasts, there may or may not be
actual dates in the dataset covering the period, depending on whether out.sample
was used, n.roll was also used, and how these all come together to form a complex
object of moving and unconditional forecasts (making this the most complex of
forecast cases). One way to quickly generate a sequence of dates is to use the
generatefwd function with the T+0 starting date, the \sQuote{length} as the 
n.ahead horizon and the \sQuote{by} the difftime object from the model slot,
as shown in the examples.\cr
Note that for both the move and generatefwd functions, weekends are excluded in
order to try to return a more realistic value.\cr
Finally, when working with Date/Time objects remember to set your time zone
with \code{Sys.setenv(TZ=)}.
}
\value{
A vector of Date/Time/Numeric indices of the same class as used in the input.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(sp500ret)
spec = ugarchspec()
fit = ugarchfit(spec, sp500ret, out.sample=10)
forc = ugarchforecast(fit, n.ahead = 25, n.roll = 10)
f = fitted(forc)
# this is a 25 x 11 matrix [n.ahead x (n.roll+1)]
# colnames: T+0 date index
T0 = as.POSIXct(colnames(f))
rollT1 = move(T0, by=1)
# rolling estimation
plot(xts(f["T+1",],rollT1))
# unconditional estimates:
par(mfrow=c(3,4))
for(i in 1:11){
# difftime is always in model$modeldata$period
D=generatefwd(T0[i], length.out = 25, by = forc@model$modeldata$period)
plot(xts(f[,i], D), main=paste("T+0:",as.character(T0[i]),sep=""), auto.grid=FALSE)
}
############################
## Intraday Sequency Example
############################
T0 = as.POSIXct("2001-01-01 16:00:00")
# remember to remove the backslash from the code below
interval = format(seq(as.POSIXct("2001-01-01 09:30:00"), as.POSIXct("2001-01-01 16:00:00"), 
by="min"), "\%H:\%M:\%S")
by = "mins"
length.out=1000
R = ftseq(T0, length.out, by, interval)
}}