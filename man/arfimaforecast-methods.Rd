\name{arfimaforecast-methods}
\docType{methods}
\alias{arfimaforecast-methods}
\alias{arfimaforecast,ANY-method}
\alias{arfimaforecast,ARFIMAfit-method}
\alias{arfimaforecast,ARFIMAspec-method}
\alias{arfimaforecast}
\title{function: ARFIMA Forecasting}
\description{
Method for forecasting from an ARFIMA model.
}
\usage{
arfimaforecast(fitORspec, data = NULL, n.ahead = 10, n.roll = 0, out.sample = 0, 
external.forecasts = list(mregfor = NULL), ...)
}
\arguments{
\item{fitORspec}{ Either an ARFIMA fit object of class 
\code{\linkS4class{ARFIMAfit}} or alternatively an ARFIMA specification object 
of class \code{\linkS4class{ARFIMAspec}} with valid parameters supplied via the 
\code{fixed.pars} argument in the specification.}
\item{data}{ Required if a specification rather than a fit object is supplied.}
\item{n.ahead}{ The forecast horizon.}
\item{n.roll}{ The no. of rolling forecasts to create beyond the first one (see 
details).}
\item{out.sample}{ Optional. If a specification object is supplied, indicates 
how many data points to keep for out of sample testing.}
\item{external.forecasts}{ A list with a matrix of forecasts for the external 
regressors in the mean.}
\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMAforecast}} object containing details of the ARFIMA 
forecast. See the class for details on the returned object and methods for 
accessing it and performing some tests.
}
\details{
The forecast function has two dispatch methods allowing the user to call it with 
either a fitted object (in which case the data argument is ignored), or a 
specification object (in which case the data is required) with the parameters 
entered via the \code{set.fixed<-} methods on an \code{\linkS4class{ARFIMAspec}} 
object.\cr
One step ahead forecasts are based on the value of the previous data, while 
n-step ahead (n>1) are based on the unconditional mean of the model.\cr
The ability to roll the forecast 1 step at a time is implemented with the 
\code{n.roll} argument which controls how many times to roll the n.ahead 
forecast. The default argument of n.roll = 0 denotes no rolling beyond the first 
forecast and returns the standard n.ahead forecast. Critically, since n.roll 
depends on data being available from which to base the rolling forecast, the 
\code{\link{arfimafit}} function needs to be called with the argument 
\code{out.sample} being at least as large as the n.roll argument, or in the case 
of a specification being used instead of a fit object, the \code{out.sample}
argument directly in the forecast function.
}
\author{Alexios Ghalanos}
\keyword{methods}