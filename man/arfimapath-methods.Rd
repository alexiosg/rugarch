\name{arfimapath-methods}
\docType{methods}
\alias{arfimapath-methods}
\alias{arfimapath,ANY-method}
\alias{arfimapath,ARFIMAspec-method}
\alias{arfimapath}
\title{function: ARFIMA Path Simulation}
\description{
Method for simulating the path of an ARFIMA model. This is a convenience 
function which does not require a fitted object (see note below).
}
\usage{
arfimapath(spec, n.sim = 1000, n.start = 0, m.sim = 1, prereturns = NA, 
	preresiduals = NA, rseed = NA, 
	custom.dist=list(name = NA, distfit = NA, type = "z"), mexsimdata=NULL, ...)
}
\arguments{
\item{spec}{ An ARFIMA object of class \code{\linkS4class{ARFIMAspec}} with
the required parameters of the model supplied via the fixed.pars list argument.}
\item{n.sim}{ The simulation horizon.}
\item{n.start}{ The burn-in sample.}
\item{m.sim}{ The number of simulations.}
\item{prereturns}{ Allows the starting return data to be provided by the user.}
\item{preresiduals}{ Allows the starting residuals to be provided by the user.}
\item{rseed}{ Optional seeding value(s) for the random number generator.}
\item{custom.dist}{ Optional density with fitted object from which to simulate. 
The \dQuote{type} argument denotes whether the standardized innovations are 
passed (\dQuote{z}) else the innovations (anything other than \dQuote{z}).}
\item{mexsimdata}{ Matrix of simulated external regressor-in-mean data. If the 
fit object contains external regressors in the mean equation, this must be 
provided.}
\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMApath}} object containing details of the ARFIMA path 
simulation.
}
\details{
This is a convenience method to allow path simulation of ARFIMA models without
the need to supply a fit object as in the \code{\link{arfimasim}} method. 
Instead, an arfima spec object is required with the model parameters supplied 
via the \code{setfixed<-} argument to the spec.
}
\author{Alexios Ghalanos}
\keyword{methods}