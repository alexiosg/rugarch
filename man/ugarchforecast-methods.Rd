\name{ugarchforecast-methods}
\docType{methods}
\alias{ugarchforecast}
\alias{ugarchforecast-methods}
\alias{ugarchforecast,ANY-method}
\alias{ugarchforecast,uGARCHfit-method}
\alias{ugarchforecast,uGARCHspec-method}
\title{function: Univariate GARCH Forecasting}
\description{
Method for forecasting from a variety of univariate GARCH models.
}
\usage{
ugarchforecast(fitORspec, data = NULL, n.ahead = 10, n.roll = 0, out.sample = 0,
		external.forecasts = list(mregfor = NULL, vregfor = NULL), trunclag = 1000, ...)
}
\arguments{
\item{fitORspec}{
Either a univariate GARCH fit object of class \code{\linkS4class{uGARCHfit}} or
alternatively a univariate GARCH specification object of class
\code{\linkS4class{uGARCHspec}} with valid fixed parameters.}
\item{data}{
Required if a specification rather than a fit object is supplied.}
\item{n.ahead}{
The forecast horizon.}
\item{n.roll}{
The no. of rolling forecasts to create beyond the first one (see details).}
\item{out.sample}{
Optional. If a specification object is supplied, indicates how many data points
to keep for out of sample testing.}
\item{external.forecasts}{
A list with forecasts for the external regressors in the mean and/or variance
equations if specified.}
\item{trunclag}{
The truncation lag for the binomial expansion in the FIGARCH model. Only used
when the dispatch is based on a \code{\linkS4class{uGARCHspec}} object, otherwise
will be read from the already defined value in the fitted object.
}
\item{...}{For the multiplicative component sGARCH model (mcsGARCH), the
additional argument \sQuote{DailyVar} is required and should be an xts object of
the daily forecasted variance for the period under consideration to be used
with the intraday data.\cr
For the realized GARCH model (realGARCH), the additional argument
\sQuote{RealizedVol}, an xts object, is required when using a specification
object for fitORspec. Additionally, the optional argument \sQuote{n.sim} denotes
the number of simulations required for n.ahead>1 forecast (see vignette for this
model's representation), whilst \sQuote{returnDistribution} is a logical argument
(default TRUE) denoting whether to return the simulated distribution of the
sigma and realized forecast values.
}
}
\value{
A \code{\linkS4class{uGARCHforecast}} object containing details of the GARCH
forecast. See the class for details on the returned object and methods for
accessing it and performing some tests.
}
\details{
The forecast function has two dispatch methods allowing the user to call it with
either a fitted object (in which case the data argument is ignored), or a
specification object (in which case the data is required) with fixed parameters.\cr
The forecast is based on the expected value of the innovations and hence the
density chosen. One step ahead forecasts are based on the value of the previous
data, while n-step ahead (n>1) are based on the unconditional expectation of the
models.\cr
The ability to roll the forecast 1 step at a time is implemented with the
\code{n.roll} argument which controls how many times to roll the n.ahead
forecast. The default argument of n.roll = 0 denotes no rolling and returns the
standard n.ahead forecast. Critically, since n.roll depends on data being
available from which to base the rolling forecast, the \code{\link{ugarchfit}}
function needs to be called with the argument \code{out.sample} being at least
as large as the n.roll argument, or in the case of a specification being used
instead of a fit object, the \code{out.sample} argument directly in the forecast
function.
}
\author{Alexios Ghalanos}
\seealso{
For filtering \code{\link{ugarchfilter}},simulation \code{\link{ugarchsim}},
rolling forecast and estimation \code{\link{ugarchroll}}, parameter distribution
and uncertainty \code{\link{ugarchdistribution}}, bootstrap forecast
\code{\link{ugarchboot}}.
}
\examples{
\dontrun{
# Basic GARCH(1,1) Spec
data(dmbp)
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec)
forc = ugarchforecast(fit, n.ahead=20)
forc
head(sigma(forc))
head(fitted(forc))
#plot(forc,which="all")
}}
\keyword{methods}
