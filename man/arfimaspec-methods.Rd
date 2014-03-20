\name{arfimaspec-methods}
\docType{methods}
\alias{arfimaspec-methods}
\alias{arfimaspec,ANY-method}
\alias{arfimaspec}
\title{function: ARFIMA Specification}
\description{
Method for creating an ARFIMA specification object prior to fitting.
}
\usage{
arfimaspec(mean.model = list(armaOrder = c(1, 1), include.mean = TRUE, 
    arfima = FALSE, external.regressors = NULL), distribution.model = "norm", 
    start.pars = list(), fixed.pars = list(), ...) 
}
\arguments{
 	\item{mean.model}{
 	List containing the mean model specification:\cr
 	\code{armaOrder} The autoregressive (ar) and moving average (ma) orders (if any).\cr
 	\code{include.mean} Whether to include the mean.\cr
 	\code{arfima} Whether to include arfima (0<d<0.5).\cr
 	\code{external.regressors} A matrix object containing the external regressors to 
 	include in the mean equation with as many rows as will be included in the
 	data (which is passed in the fit function).
 	}
 	\item{distribution.model}{
 	The distribution density to use for the innovations. Valid choices are 
 	\dQuote{norm} for the normal distibution, \dQuote{snorm} for the skew-normal 
 	distribution, \dQuote{std} for the student-t, \dQuote{sstd} for the skew-student-t, 
 	\dQuote{ged} for the generalized error distribution, \dQuote{sged} for the 
 	skew-generalized error distribution, \dQuote{nig} for the normal inverse 
 	gaussian distribution, \dQuote{ghyp} for the Generalized  Hyperbolic, and \dQuote{jsu} 
 	for Johnson's SU distribution. Note that some of the distributions are taken from the 
 	fBasics package and implenented locally here for convenience. The \dQuote{jsu} distribution 
 	is the reparametrized version from the \dQuote{gamlss} package.}
 	\item{start.pars}{
 	List of staring parameters for the optimization routine. 
 	These are not usually required unless the optimization has problems converging.}
 	\item{fixed.pars}{
 	List of parameters which are to be kept fixed during the optimization. It is 
 	possible that you designate all parameters as fixed so as to quickly recover just 
 	the results of some previous work or published work. The optional argument
 	\dQuote{fixed.se} in the \code{\link{arfimafit}} function indicates whether to
 	calculate standard errors for those parameters fixed during the post optimization
 	stage.}
	\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMAspec}} object containing details of the ARFIMA specification.
}
\details{
The specification allows for flexibility in ARFIMA modelling.\cr
In order to understand which parameters can be entered in the start.pars and 
fixed.pars optional arguments, the list below exposes the names used for the
parameters:(note that when a parameter is followed by a number, this represents 
the order of the model. Just increment the number for higher orders):\cr
\emph{\bold{Mean Model}}:\cr
       \tabular{rll}{
         \tab constant	\tab \code{mu}\cr
         \tab AR term	\tab \code{ar1}\cr
         \tab MA term	\tab \code{ma1}\cr
         \tab exogenous regressors	\tab \code{mxreg1}\cr
         \tab arfima	\tab \code{arfima}\cr
       }
\emph{\bold{Distribution Model}}:\cr
       \tabular{rll}{
         \tab dlambda \tab \code{dlambda (for GHYP distribution)}\cr
         \tab skew	\tab \code{skew}\cr
         \tab shape	\tab \code{shape}\cr
       }
}
\author{Alexios Ghalanos}
\keyword{methods}