\name{multifit-methods}
\docType{methods}
\alias{multifit}
\alias{multifit-methods}
\alias{multifit,ANY-method}
\alias{multifit,uGARCHmultispec-method}
\alias{multifit,ARFIMAmultispec-method}
\title{function: Univariate GARCH and ARFIMA Multiple Fitting}
\description{
Method for multiple fitting a variety of univariate GARCH and ARFIMA models.
}
\usage{
multifit(multispec, data, out.sample = 0, solver = "solnp", solver.control = list(), 
fit.control = list(stationarity = 1, fixed.se = 0, scale = 0, rec.init = "all"), 
cluster = NULL, ...)
}
\arguments{
\item{multispec}{
A multiple GARCH or ARFIMA spec object of class \code{\linkS4class{uGARCHmultispec}} 
and \code{\linkS4class{ARFIMAmultispec}}.}
\item{out.sample}{
A positive integer indicating the number of periods before the last to keep for 
out of sample forecasting (see details).}
\item{data}{
A multivariate data object of class xts or coercible to such.}
\item{solver}{
One of either \dQuote{nlminb} or \dQuote{solnp}.}
\item{solver.control}{
Control arguments list passed to optimizer.}
\item{fit.control}{
Control arguments passed to the fitting routine. Stationarity (only for the 
GARCH case) explicitly imposes the variance stationarity constraint during 
optimization. The fixed.se argument controls whether standard errors should be 
calculated for those parameters which were fixed (through the fixed.pars 
argument of the \code{\link{ugarchspec}} or \code{\link{arfimaspec}} functions). 
The scale parameter controls whether the data should be scaled before being 
submitted to the optimizer, while the rec.init option controls the recursion
initialization method and only valid for GARCH models.}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation.
}
\item{...}{ . }
}
\value{
A \code{\linkS4class{uGARCHmultifit}} or \code{\linkS4class{ARFIMAmultifit}} 
object containing details of the GARCH or ARFIMA fits.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec()
mspec = multispec( replicate(spec, n = 4) )
fitlist = multifit(multispec = mspec, data = dji30ret[,1:4])
}}
\keyword{methods}