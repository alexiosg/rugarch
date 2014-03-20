\name{arfimasim-methods}
\docType{methods}
\alias{arfimasim-methods}
\alias{arfimasim,ANY-method}
\alias{arfimasim,ARFIMAfit-method}
\alias{arfimasim}
\title{function: ARFIMA Simulation}
\description{
Method for simulation from ARFIMA models.
}
\usage{
arfimasim(fit, n.sim = 1000, n.start = 0, m.sim = 1, startMethod = 
	c("unconditional", "sample"), prereturns = NA, preresiduals = NA, 
	rseed = NA, custom.dist = list(name = NA, distfit = NA, type = "z"), 
	mexsimdata = NULL, ...) 
}
\arguments{
\item{fit}{ An ARFIMA fit object of class \code{\linkS4class{ARFIMAfit}}.}
\item{n.sim}{ The simulation horizon.}
\item{n.start}{ The burn-in sample.}
\item{m.sim}{ The number of simulations.}
\item{startMethod}{ Starting values for the simulation.}
\item{prereturns}{ Allows the starting return data to be provided by the user.}
\item{preresiduals}{ Allows the starting residuals to be provided by the user.}
\item{rseed}{ Optional seeding value(s) for the random number generator.}
\item{custom.dist}{ Optional density with fitted object from which to simulate. 
The \dQuote{type} argument denotes whether the standardized innovations are 
passed (\dQuote{z}) else the innovations (anything other than \dQuote{z}). 
See notes below for details. }
\item{mexsimdata}{ Matrix of simulated external regressor-in-mean data. If the 
fit object contains external regressors in the mean equation, this can be 
provided else will be ignored.}
\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMAsim}} object containing details of the ARFIMA 
simulation.
}
\details{
The custom.dist option allows for defining a custom density which exists in the
users workspace with methods for \dQuote{r} (sampling, e.g. rnorm) and \dQuote{d} 
(density e.g. dnorm). It must take a single fit object as its second argument.
Alternatively, custom.dist can take any name in the name slot (e.g.\dQuote{sample}) 
and a matrix in the fit slot with dimensions equal to m.sim (columns) and 
n.sim (rows).
}
\author{Alexios Ghalanos}
\keyword{methods}