\name{ugarchfit-methods}
\docType{methods}
\alias{ugarchfit}
\alias{ugarchfit-methods}
\alias{ugarchfit,ANY-method}
\alias{ugarchfit,uGARCHspec-method}
\title{function: Univariate GARCH Fitting}
\description{
Method for fitting a variety of univariate GARCH models.
}
\usage{
ugarchfit(spec, data, out.sample = 0, solver = "solnp", solver.control = list(),
fit.control = list(stationarity = 1, fixed.se = 0, scale = 0, rec.init = 'all',
trunclag = 1000),
numderiv.control = list(grad.eps=1e-4, grad.d=0.0001,
grad.zero.tol=sqrt(.Machine$double.eps/7e-7), hess.eps=1e-4, hess.d=0.1,
hess.zero.tol=sqrt(.Machine$double.eps/7e-7), r=4, v=2),...)
}
\arguments{
\item{data}{
A univariate data object. Can be a numeric vector, matrix, data.frame, zoo, xts,
timeSeries, ts or irts object.}
\item{spec}{
A univariate GARCH spec object of class \code{\linkS4class{uGARCHspec}}.}
\item{out.sample}{
A positive integer indicating the number of periods before the last to keep for
out of sample forecasting (see details).}
\item{solver}{
One of either \dQuote{nlminb}, \dQuote{solnp}, \dQuote{lbfgs},
\dQuote{gosolnp}, \dQuote{nloptr} or \dQuote{hybrid} (see notes). }
\item{solver.control}{
Control arguments list passed to optimizer.}
\item{fit.control}{
Control arguments passed to the fitting routine. Stationarity explicitly imposes
the variance stationarity constraint during optimization. For the FIGARCH model
this imposes the positivity constraint. The fixed.se argument
controls whether standard errors should be calculated for those parameters which
were fixed (through the fixed.pars argument of the \code{\link{ugarchspec}}
function). The scale parameter controls whether the data should be scaled before
being submitted to the optimizer. The rec.init option determines the type of
initialization for the variance recursion. Valid options are \sQuote{all} which
uses all the values for the unconditional variance calculation, an integer
greater than or equal to 1 denoting the number of data points to use for the
calculation, or a positive numeric value less than one which determines the
weighting for use in an exponential smoothing backcast. The \code{trunclag} is the
truncation lags for the binomial expansion in the FIGARCH model.}
\item{numderiv.control}{Control arguments passed to the numerical routines for the
calculation of the standard errors. See the documentation in the numDeriv package
for further details. The arguments which start with \sQuote{hess} are passed to
the hessian routine while those with \sQuote{grad} to the jacobian routine.}
\item{...}{ For the multiplicative component sGARCH model (mcsGARCH), the
additional argument \sQuote{DailyVar} is required and should be an xts object of
the daily forecasted variance to use with the intraday data.}
}
\value{
A \code{\linkS4class{uGARCHfit}} object containing details of the GARCH fit.
}
\details{
The GARCH optimization routine first calculates a set of feasible starting
points which are used to initiate the GARCH recursion. The main part of the
likelihood calculation is performed in C-code for speed.\cr
The out.sample option is provided in order to carry out forecast performance
testing against actual data. A minimum of 5 data points are required for these
tests. If the out.sample option is positive, then the routine will fit only
N - out.sample (where N is the total data length) data points, leaving
out.sample points for forecasting and testing using the forecast performance
measures. In the \code{\link{ugarchforecast}} routine the n.ahead may also be
greater than the out.sample number resulting in a combination of out of sample
data points matched against actual data and some without, which the forecast
performance tests will ignore.\cr
The \dQuote{gosolnp} solver allows for the initialization of multiple restarts
of the solnp solver with randomly generated parameters (see documentation in
the Rsolnp-package for details of the strategy used). The solver.control list
then accepts the following additional (to the solnp) arguments: \dQuote{n.restarts}
is the number of solver restarts required (defaults to 1), \dQuote{parallel}
(logical), \dQuote{pkg} (either snowfall or multicore) and \dQuote{cores}
(the number of cores or workers to use) for use of parallel functionality,
\dQuote{rseed} is the seed to initialize the random number generator, and
\dQuote{n.sim} is the number of simulated parameter vectors to generate per
n.restarts.\cr
The \dQuote{hybrid} strategy solver first tries the \dQuote{solnp} solver, in
failing to converge then tries then \dQuote{nlminb}, the \dQuote{gosolnp} and
finally the \dQuote{nloptr} solvers. Solver control parameters can be passed for
all the solvers in the solver.control list as one long list which will be
filtered for each solver's specific options as and when that solver is called
during the hybrid strategy optimization. It is still possible that the Hessian
at the optimal found cannot be inverted, in which case a warning is printed and
there will not be any standard errors. In this case it is suggested that the
problem is re-run with different solver parameters. It is also possible that the
solution, while still \sQuote{almost} optimal may be at a saddle-point very near
the global optimum in which case the Hessian may still be invertible but one
eigenvalue is negative. The uGARCHfit object has a value in the fit slot
called condH (object@fit$condH) which indicates the approximate number of decimal
places lost to roundoff/numerical estimation error. When this is NaN, this
indicates the case just described of one negative eigenvalue/saddlepoint (this
previously flagged a warning but is now silenced and it is upto to the user to
decide whether it is worth investigating further).
}
\note{
The nloptr solver takes the following options in the solver.control list:\cr
\tabular{llll}{
\tab ftol_rel \tab function value relative tolerance \tab default: 1e-8\cr
\tab xtol_rel \tab parameter value relative tolerance \tab default: 1e-6\cr
\tab maxeval \tab maximum function evaluations \tab default: 25000\cr
\tab print_level \tab trace level \tab default: 1\cr
\tab solver \tab the nloptr solver to use \tab default: 1 (\sQuote{SBPLX}).\cr
}
The solver option for nloptr has 10 different choices (1:10), which are
1:\sQuote{COBYLA}, 2:\sQuote{BOBYQA}, 3:\sQuote{PRAXIS}, 4:\sQuote{NELDERMEAD},
5:\sQuote{SBPLX}, 6:\sQuote{AUGLAG}+\sQuote{COBYLA},
7:\sQuote{AUGLAG}+\sQuote{BOBYQA}, 8:\sQuote{AUGLAG}+\sQuote{PRAXIS},
9:\sQuote{AUGLAG}+\sQuote{NELDERMEAD} and 10:\sQuote{AUGLAG}+\sQuote{SBPLX}.
As always, your mileage will vary and care should be taken on the choice of
solver, tuning parameters etc. If you do use this solver try 9 or 10 first.
}
\author{Alexios Ghalanos}
\seealso{
For specification \code{\link{ugarchspec}},filtering \code{\link{ugarchfilter}},
forecasting \code{\link{ugarchforecast}}, simulation \code{\link{ugarchsim}},
rolling forecast and estimation \code{\link{ugarchroll}}, parameter distribution
and uncertainty \code{\link{ugarchdistribution}}, bootstrap forecast
\code{\link{ugarchboot}}.
}
\examples{
# Basic GARCH(1,1) Spec
data(dmbp)
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec)
fit
coef(fit)
head(sigma(fit))
#plot(fit,which="all")
# in order to use fpm (forecast performance measure function)
# you need to select a subsample of the data:
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec, out.sample=100)
forc = ugarchforecast(fit, n.ahead=100)
# this means that 100 data points are left from the end with which to
# make inference on the forecasts
fpm(forc)
}
\keyword{methods}
