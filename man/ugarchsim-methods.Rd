\name{ugarchsim-methods}
\docType{methods}
\alias{ugarchsim}
\alias{ugarchsim-methods}
\alias{ugarchsim,ANY-method}
\alias{ugarchsim,uGARCHfit-method}
\title{function: Univariate GARCH Simulation}
\description{
Method for simulation from a variety of univariate GARCH models.
}
\usage{
ugarchsim(fit, n.sim = 1000, n.start = 0, m.sim = 1, 
startMethod = c("unconditional", "sample"), presigma = NA, prereturns = NA, 
preresiduals = NA, rseed = NA, custom.dist = list(name = NA, distfit = NA), 
mexsimdata = NULL, vexsimdata = NULL, ...)
}
\arguments{
\item{fit}{
A univariate GARCH fit object of class \code{\linkS4class{uGARCHfit}}.}
\item{n.sim}{
The simulation horizon.}
\item{n.start}{
The burn-in sample.}
\item{m.sim}{
The number of simulations.}
\item{startMethod}{
Starting values for the simulation. Valid methods are \dQuote{unconditional} for 
the expected values given the density, and \dQuote{sample} for the ending values 
of the actual data from the fit object.}
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
\item{custom.dist}{
Optional density with fitted object from which to simulate. See notes below for 
details.}
\item{mexsimdata}{
List of matrices (size of list m.sim, with each matrix having n.sim rows) of 
simulated external regressor-in-mean data. If the fit object contains 
external regressors in the mean equation, this must be provided else will be
assumed zero.}
\item{vexsimdata}{
List of matrices (size of list m.sim, with each matrix having n.sim rows) of 
simulated external regressor-in-variance data. If the fit object contains 
external regressors in the mean equation, this must be provided else will be
assumed zero.}
\item{...}{For the multiplicative component sGARCH model (mcsGARCH), the
additional argument \sQuote{DailyVar} is required and should be an xts object 
of length floor(n.sim/increments-per-day) by m.sim of the the daily simulated 
variance to use with the intraday data. In the case of the realized GARCH (realGARCH)
model, the optional argument \sQuote{prerealized} allows to pass starting values of the
realized volatility (should be of length q as was set in the \sQuote{garchOrder(q,p)} 
in the specification)}
}
\value{
A \code{\linkS4class{uGARCHsim}} object containing details of the GARCH simulation.
}
\details{
The custom.dist option allows for defining a custom density which exists in the
users workspace with methods for \dQuote{r} (sampling, e.g. rnorm) and \dQuote{d} 
(density e.g. dnorm). It must take a single fit object as its second argument.
Alternatively, custom.dist can take any name in the name slot (e.g.\dQuote{sample}) 
and a matrix in the fit slot with dimensions equal to m.sim (columns) and n.sim (rows).
The usefulness of this becomes apparent when one is considering the copula-GARCH 
approach or the bootstrap method.\cr
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}}, fitting \code{\link{ugarchfit}}, 
filtering \code{\link{ugarchfilter}}, forecasting \code{\link{ugarchforecast}}, 
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
sim = ugarchsim(fit,n.sim=1000, n.start=1, m.sim=1, startMethod="sample")
sim
head(sigma(sim))
}}
\keyword{methods}
