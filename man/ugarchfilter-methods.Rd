\name{ugarchfilter-methods}
\docType{methods}
\alias{ugarchfilter}
\alias{ugarchfilter-methods}
\alias{ugarchfilter,ANY-method}
\alias{ugarchfilter,uGARCHspec-method}
\title{function: Univariate GARCH Filtering}
\description{
Method for filtering a variety of univariate GARCH models.
}
\usage{
ugarchfilter(spec, data, out.sample = 0, n.old=NULL, rec.init = 'all', ...)
}
\arguments{
\item{data}{
A univariate data object. Can be a numeric vector, matrix, data.frame, zoo, xts, 
timeSeries, ts or irts object.}
\item{spec}{
A univariate GARCH spec object of class \code{\linkS4class{uGARCHspec}} with the 
fixed.pars argument having the model parameters on which the filtering is
to take place.}
\item{out.sample}{
A positive integer indicating the number of periods before the last to keep for 
out of sample forecasting (as in \code{\link{ugarchfit}} function).}
\item{n.old}{
For comparison with uGARCHfit models using the out.sample argument, this is the 
length of the original dataset (see details).}
\item{rec.init}{ The recursion initialization method (see \code{\link{ugarchfit}}
for explanation).}
\item{...}{ For the multiplicative component sGARCH model (mcsGARCH), the
additional argument \sQuote{DailyVar} is required and should be an xts object of 
the daily forecasted variance to use with the intraday data.}
}
\value{
A \code{\linkS4class{uGARCHfilter}} object containing details of the GARCH filter.
}
\details{
The n.old argument is optional and indicates the length of the original data (in 
cases when this represents a series augmented by newer data). The reason for 
using this is so that the old and new datasets agree since the original 
recursion uses the sum of the residuals to start the recursion and therefore is 
influenced by new data. For a small augmentation the values converge after x 
periods, but it is sometimes preferable to have this option so that there is no 
forward looking information contaminating the study.
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}}, fitting \code{\link{ugarchfit}}, 
forecasting \code{\link{ugarchforecast}}, simulation \code{\link{ugarchsim}}, 
rolling forecast and estimation \code{\link{ugarchroll}}, parameter distribution 
and uncertainty \code{\link{ugarchdistribution}}, bootstrap forecast 
\code{\link{ugarchboot}}.
}
\examples{
\dontrun{
data(sp500ret)
ctrl = list(RHO = 1,DELTA = 1e-8,MAJIT = 100,MINIT = 650,TOL = 1e-6)
spec = ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1,1)), 
		mean.model = list(armaOrder = c(1,1), include.mean = TRUE), 
		distribution.model = "std")
egarch.fit = ugarchfit(data = sp500ret[,1,drop=FALSE], spec = spec, 
		solver = "solnp", solver.control = ctrl)
		
spec = ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1,1)), 
		mean.model = list(armaOrder = c(1,1), include.mean = TRUE), 
		distribution.model = "std", fixed.pars = as.list(coef(egarch.fit)))
egarch.filter = ugarchfilter(data = sp500ret[,1,drop=FALSE], spec = spec)
}}