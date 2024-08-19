\name{ugarchdistribution-methods}
\docType{methods}
\alias{ugarchdistribution}
\alias{ugarchdistribution-methods}
\alias{ugarchdistribution,ANY-method}
\alias{ugarchdistribution,uGARCHfit-method}
\alias{ugarchdistribution,uGARCHspec-method}
\title{function: Univariate GARCH Parameter Distribution via Simulation}
\description{
Method for simulating and estimating the parameter distribution from a variety 
of univariate GARCH models as well as the simulation based consistency of the 
estimators given the data size.
}
\usage{
ugarchdistribution(fitORspec, n.sim = 2000, n.start = 1, 
m.sim = 100,  recursive = FALSE, recursive.length = 6000, recursive.window = 1000,
presigma = NA, prereturns = NA, preresiduals = NA, rseed = NA,
custom.dist = list(name = NA, distfit = NA), mexsimdata = NULL, vexsimdata = NULL, 
fit.control = list(), solver = "solnp", solver.control = list(), cluster = NULL, ...)
}
\arguments{
\item{fitORspec}{
Either a univariate GARCH fit object of class \code{\linkS4class{uGARCHfit}} or
alternatively a univariate GARCH specification object of class \code{\linkS4class{uGARCHspec}} 
with valid parameters supplied via the \code{setfixed<-} function in the 
specification.}
\item{n.sim}{
The simulation horizon.}
\item{n.start}{
The burn-in sample.}
\item{m.sim}{
The number of simulations.}
\item{recursive}{
Whether to perform a recursive simulation on an expanding window.}
\item{recursive.length}{
If \code{recursive} is TRUE, this indicates the final length of the simulation 
horizon, with starting length \code{n.sim}.}
\item{recursive.window}{
If \code{recursive} is TRUE, this indicates the increment to the expanding 
window. Together with \code{recursive.length}, it determines the total number
of separate and increasing length windows which will be simulated and fitted.}
\item{presigma}{
Allows the starting sigma values to be provided by the user.}
\item{prereturns}{
Allows the starting return data to be provided by the user.}
\item{preresiduals}{
Allows the starting residuals to be provided by the user.}
\item{rseed}{
Optional seeding value(s) for the random number generator.}
\item{custom.dist}{
Optional density with fitted object from which to simulate.}
\item{mexsimdata}{
Matrix of simulated external regressor-in-mean data. If the fit object contains 
external regressors in the mean equation, this must be provided.}
\item{vexsimdata}{
Matrix of simulated external regressor-in-variance data. If the fit object 
contains external regressors in the variance equation, this must be provided.}
\item{solver}{
One of either \dQuote{nlminb} or \dQuote{solnp}. }
\item{solver.control}{
Control arguments list passed to optimizer.}
\item{fit.control}{
Control arguments passed to the fitting routine (as in the \code{ugarchfit}
method).}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation
of the refits (remember to stop the cluster on completion).
}
\item{...}{ . }
}
\value{
A \code{\linkS4class{uGARCHdistribution}} object containing details of the GARCH 
simulated parameters distribution.
}
\details{
This method facilitates the simulation and evaluation of the uncertainty of 
GARCH model parameters. The recursive option also allows the evaluation of the 
simulation based consistency (in terms of sqrt(N) ) of the parameters as the 
length (n.sim) of the data increases, in the sense of the root mean square error 
(rmse) of the difference  between the simulated and true (hypothesized) 
parameters.\cr
This is a very expensive function, particularly if using the \code{recursive} 
option, both on memory and cpu resources, performing many re-fits of the 
simulated data in order to generate the parameter distribution and it is 
therefore suggested that, if available, the parallel functionality should be 
used (in a system with ideally many cores and at least 4GB of RAM for the 
recursion option...).
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}}, fitting \code{\link{ugarchfit}}, 
filtering \code{\link{ugarchfilter}}, forecasting \code{\link{ugarchforecast}}, 
simulation \code{\link{ugarchsim}}, rolling forecast and estimation \code{\link{ugarchroll}}, 
bootstrap forecast \code{\link{ugarchboot}}.
}
\keyword{methods}