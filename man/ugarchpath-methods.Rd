\name{ugarchpath-methods}
\docType{methods}
\alias{ugarchpath}
\alias{ugarchpath-methods}
\alias{ugarchpath,ANY-method}
\alias{ugarchpath,uGARCHspec-method}
\title{function: Univariate GARCH Path Simulation}
\description{
Method for simulating the path of a GARCH model from a variety of univariate 
GARCH models. This is a convenience function which does not require a fitted 
object (see note below).
}
\usage{
ugarchpath(spec, n.sim=1000, n.start=0, m.sim=1, presigma=NA, prereturns=NA, 
preresiduals=NA, rseed=NA, custom.dist=list(name=NA,distfit=NA), mexsimdata=NULL, 
vexsimdata=NULL, ...)
}
\arguments{
\item{spec}{
A univariate GARCH spec object of class \code{\linkS4class{uGARCHspec}} with
the required parameters of the model supplied via the fixed.pars list argument 
or \code{\link{setfixed<-}} method.}
\item{n.sim}{
The simulation horizon.}
\item{n.start}{
The burn-in sample.}
\item{m.sim}{
The number of simulations.}
\item{presigma}{
Allows the starting sigma values to be provided by the user.}
\item{prereturns}{
Allows the starting return data to be provided by the user.}
\item{preresiduals}{
Allows the starting residuals to be provided by the user.}
\item{rseed}{
Optional seeding value(s) for the random number generator. For m.sim>1, it is 
possible to provide either a single seed to initialize all values, or one seed 
per separate simulation (i.e. m.sim seeds). However, in the latter case this may 
result in some slight overhead depending on how large m.sim is.}
\item{custom.dist}{ Optional density with fitted object from which to simulate. 
See notes below for details.}
\item{mexsimdata}{
List of matrices (size of list m.sim, with each matrix having n.sim rows) of 
simulated external regressor-in-mean data. If the fit object contains 
external regressors in the mean equation, this must be provided else will be
assumed zero.}
\item{vexsimdata}{
List of matrices (size of list m.sim, with each matrix having n.sim rows) of 
simulated external regressor-in-variance data. If the fit object contains 
external regressors in the variance equation, this must be provided else will be
assumed zero.}
\item{...}{ If the model is the \dQuote{csGARCH}, then \code{preq} can be used 
to denote the previous value of the permanent component of the variance model 
(q, e.g. tail(fit@fit$q,1)) so that the ugarchpath method with all pre-values 
included will evaluate to the same result as the ugarchsim method with method 
equal to \dQuote{sample} (assuming the same random seeding values are used).}
}
\value{
A \code{\linkS4class{uGARCHpath}} object containing details of the GARCH path 
simulation.
}
\details{
This is a convenience method to allow path simulation of various GARCH models 
without the need to supply a fit object as in the \code{\link{ugarchsim}} method. 
Instead, a GARCH spec object is required with the fixed model parameters.
The mcsGARCH model is not supported for the path method-use \code{\link{ugarchsim}}
instead.
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}}, fitting \code{\link{ugarchfit}}, 
filtering \code{\link{ugarchfilter}}, forecasting \code{\link{ugarchforecast}}, 
simulation \code{\link{ugarchsim}}, rolling forecast and estimation 
\code{\link{ugarchroll}}, parameter distribution and uncertainty 
\code{\link{ugarchdistribution}}, bootstrap forecast \code{\link{ugarchboot}}.
}
\examples{
\dontrun{
# create a basic sGARCH(1,1) spec:
spec=ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
		mean.model=list(armaOrder=c(0,0), include.mean=TRUE, garchInMean = 
		FALSE, inMeanType = 2), distribution.model="sstd", 
		fixed.pars=list(mu=0.001,omega=0.00001, alpha1=0.05, beta1=0.90,
		shape=4,skew=2))
# simulate the path
path.sgarch = ugarchpath(spec, n.sim=3000, n.start=1, m.sim=1)
}}
\keyword{methods}
