\name{arfimafit-methods}
\docType{methods}
\alias{arfimafit-methods}
\alias{arfimafit,ANY-method}
\alias{arfimafit,ARFIMAspec-method}
\alias{arfimafit}
\title{function: ARFIMA Fit}
\description{
Method for fitting an ARFIMA models.
}
\usage{
arfimafit(spec, data, out.sample = 0, solver = "solnp", solver.control = list(), 
fit.control = list(fixed.se = 0, scale = 0), ...)
}
\arguments{
\item{data}{ A univariate data object. Can be a numeric vector, matrix, 
data.frame, zoo, xts, timeSeries, ts or irts object.}
\item{spec}{ An ARFIMA spec object of class \code{\linkS4class{ARFIMAspec}}.}
\item{out.sample}{ A positive integer indicating the number of periods before 
the last to keep for out of sample forecasting (see details).}
\item{solver}{One of either \dQuote{nlminb}, \dQuote{solnp}, \dQuote{gosolnp}
or \dQuote{nloptr}.}
\item{solver.control}{Control arguments list passed to optimizer.}
\item{fit.control}{Control arguments passed to the fitting routine. The 
fixed.se argument controls whether standard errors should be calculated for 
those parameters which were fixed (through the fixed.pars argument of the 
\code{\link{arfimaspec} function). The scale parameter controls whether the
data should be scaled before being submitted to the optimizer.}}
\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMAfit}} object containing details of the ARFIMA fit.
}
\details{
The ARFIMA optimization routine first calculates a set of feasible starting 
points which are used to initiate the ARFIMA Maximum Likelihood recursion. The 
main part of the likelihood calculation is performed in C-code for speed.\cr
The out.sample option is provided in order to carry out forecast performance 
testing against actual data. A minimum of 5 data points are required for these 
tests. If the out.sample option is positive, then the routine will fit only 
N - out.sample (where N is the total data length) data points, leaving 
out.sample points for forecasting and testing using the forecast performance 
measures. In the \code{\link{arfimaforecast}} routine the 
n.ahead may also  be greater than the out.sample number resulting in a 
combination of out of sample data points matched against actual data and some 
without, which the forecast performance tests will ignore.\cr
The \dQuote{gosolnp} solver allows for the initialization of multiple restarts 
of the solnp solver with randomly generated parameters (see documentation in 
the Rsolnp-package for details of the strategy used). The solver.control list 
then accepts the following additional (to the solnp) arguments: \dQuote{n.restarts} 
is the number of solver restarts required (defaults to 1), \dQuote{parallel} (logical), 
\dQuote{pkg} (either snowfall or multicore) and \dQuote{cores} (the number of cores 
or workers to use) for use of parallel functionality, \dQuote{rseed} is the seed to initialize 
the random number generator, and \dQuote{n.sim} is the number of simulated 
parameter vectors to generate per n.restarts.
}
\author{Alexios Ghalanos}
\keyword{methods}