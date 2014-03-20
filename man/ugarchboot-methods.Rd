\name{ugarchboot-methods}
\alias{ugarchboot}
\alias{ugarchboot-methods}
\alias{ugarchboot,ANY-method}
\alias{ugarchboot,uGARCHfit-method}
\alias{ugarchboot,uGARCHspec-method}
\title{function: Univariate GARCH Forecast via Bootstrap}
\description{
Method for forecasting the GARCH density based on a bootstrap procedures (see 
details and references).
}
\usage{
ugarchboot(fitORspec, data = NULL, method = c("Partial", "Full"), 
sampling = c("raw", "kernel", "spd"), spd.options = list(upper = 0.9, 
lower = 0.1, type = "pwm", kernel = "normal"), n.ahead = 10, 
n.bootfit = 100, n.bootpred = 500, out.sample = 0, rseed = NA, solver = "solnp", 
solver.control = list(), fit.control = list(), 
external.forecasts = list(mregfor = NULL, vregfor = NULL), mexsimdata = NULL, 
vexsimdata = NULL, cluster = NULL, verbose = FALSE)
}
\arguments{
\item{fitORspec}{
Either a univariate GARCH fit object of class \code{\linkS4class{uGARCHfit}} or
alternatively a univariate GARCH specification object of class \code{\linkS4class{uGARCHspec}} 
with valid parameters supplied via the \code{setfixed<-} function in the 
specification.}
\item{data}{
Required if a specification rather than a fit object is supplied.}
\item{method}{
Either the full or partial bootstrap (see note).}
\item{sampling}{
Whether to sample from the raw residuals, the kernel-fitted distribution of the
residuals or the spd-fitted distribution of the residuals.}
\item{spd.options}{
If sampling is from the SPD distribution, this controls the options for fitting
this distribution to the residuals (see \code{spd} package for details).}
\item{n.ahead}{
The forecast horizon.}
\item{n.bootfit}{
The number of simulation based re-fits used to generate the parameter 
distribution (i.e the parameter uncertainty). Not relevant for the \dQuote{Partial} 
method. }
\item{n.bootpred}{
The number of bootstrap replications per parameter distribution per n.ahead 
forecasts used to generate the predictive density. If this is for the partial 
method, simply the number of random samples from the empirical distribution to 
generate per n.ahead.}
\item{out.sample}{
Optional. If a specification object is supplied, indicates how many data points
to keep for out of sample testing.}
\item{rseed}{
A vector of seeds to initialize the random number generator for the resampling
with replacement method (if supplied should be equal to n.bootfit + n.bootpred).}
\item{solver}{
One of either \dQuote{nlminb} or \dQuote{solnp}. }
\item{solver.control}{
Control arguments list passed to optimizer.}
\item{fit.control}{
Control arguments passed to the fitting routine (as in the \code{ugarchfit}
method).}
\item{external.forecasts}{
A list with forecasts for the external regressors in the mean and/or variance 
equations if specified.}
\item{mexsimdata}{
List of matrices (size of list n.bootpred, with each matrix having n.ahead rows) of 
simulated external regressor-in-mean data. If the fit object contains 
external regressors in the mean equation, this must be provided else will be
assumed zero.}
\item{vexsimdata}{
List of matrices (size of list n.bootpred, with each matrix having n.ahead rows) of 
simulated external regressor-in-variance data. If the fit object contains 
external regressors in the mean equation, this must be provided else will be
assumed zero.}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation
of the refits (remember to stop the cluster on completion).
}
\item{verbose}{
Whether to print out progress messages.}
\item{...}{ .}
}
\value{
A \code{\linkS4class{uGARCHboot}} object containing details of the GARCH 
bootstrapped forecast density.
}
\details{
There are two main sources of uncertainty about n.ahead forecasting from GARCH 
models, namely that arising from the form of the predictive density and due to 
parameter estimation. The bootstrap method considered here, is based on 
resampling innovations from the empirical distribution of the fitted GARCH model 
to generate future realizations of the series and sigma. The \dQuote{full} method, 
based on the referenced paper by Pascual et al (2006), takes into account 
parameter uncertainty by building a simulated distribution of the parameters 
through simulation and refitting. This process, while more accurate, is very time 
consuming which is why choice of parallel computation via a cluster (as in the 
\code{\link{ugarchdistribution}} is available and recommended). The 
\dQuote{partial} method, only considers distribution uncertainty and while faster, 
will not generate prediction intervals for the sigma 1-ahead forecast for which 
only the parameter uncertainty is relevant in GARCH type models.\cr
If using external regressors, the routine requires both the forecast (of length
n.ahead as in the \code{\link{ugarchforecast}} routine) and a list
of simulated forecasts as in the \code{\link{ugarchsim}} routine (else with be 
assumed zero). Finally, it is possible to resample based on 3 schemes, namely 
the \dQuote{raw} innovations as in the original paper of Pascual et al (2006),
\dQuote{kernel} fits a Gaussian kernel to the innovations from the \code{ks}
package in order to then generate random samples, and the \dQuote{spd} fits
a semi-parametric distribution to the innovations based on the \code{spd} 
package in order to generate the random samples, for which an optional list 
(\code{spd.options}) may be further passed to the spd fitting routine.
}
\references{
Pascual, L., Romo, J. and Ruiz, E. 2004, Bootstrap predictive inference for 
ARIMA processes, \emph{Journal of Time Series Analysis}.\cr
Pascual, L., Romo, J. and Ruiz, E. 2006, Bootstrap prediction for returns and 
volatilities in GARCH models, \emph{Computational Statistics and Data Analysis}.\cr
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}}, fitting \code{\link{ugarchfit}}, 
filtering \code{\link{ugarchfilter}}, forecasting \code{\link{ugarchforecast}}, 
simulation \code{\link{ugarchsim}}, rolling forecast and estimation 
\code{\link{ugarchroll}}, parameter distribution and uncertainty 
\code{\link{ugarchdistribution}}.
}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec(variance.model=list(model="gjrGARCH", garchOrder=c(1,1)), 
		mean.model=list(armaOrder=c(1,1), arfima=FALSE, include.mean=TRUE, 
		archm = FALSE, archpow = 1), distribution.model="std")
ctrl = list(tol = 1e-7, delta = 1e-9)
fit = ugarchfit(data=dji30ret[, "BA", drop = FALSE], out.sample = 0, 
				spec = spec, solver = "solnp", solver.control = ctrl,
				fit.control = list(scale = 1))
bootpred = ugarchboot(fit, method = "Partial", n.ahead = 120, n.bootpred = 2000)
bootpred
# as.data.frame(bootpred, which = "sigma", type = "q", qtile = c(0.01, 0.05))
}}
\keyword{methods}
