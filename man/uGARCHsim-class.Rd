\name{uGARCHsim-class}
\docType{class}
\alias{uGARCHsim-class}
\alias{sigma,uGARCHsim-method}
\alias{fitted,uGARCHsim-method}
\alias{quantile,uGARCHsim-method}
\alias{plot,uGARCHsim,missing-method}
\alias{show,uGARCHsim-method}
\title{class: Univariate GARCH Simulation Class}
\description{Class for the univariate GARCH simulation.}
\section{Extends}{
Class \code{"\linkS4class{GARCHsim}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHsim", distance 2.
}
\section{Slots}{
  \describe{
    \item{\code{simulation}:}{Object of class \code{"vector"}
    Holds data on the simulation.}
    \item{\code{model}:}{Object of class \code{"vector"}
    The model specification common to all objects.}
    \item{\code{seed}:}{Object of class \code{"integer"}
    The random seed used.}
  }
}
\section{Methods}{
  \describe{
    \item{sigma}{\code{signature(object = "uGARCHsim")}: 
	Extracts the conditional sigma simulated values as a matrix of size n.sim x m.sim.}
	\item{fitted}{\code{signature(object = "uGARCHsim")}: 
	Extracts the conditional mean simulated values as a matrix of size n.sim x m.sim.}
	\item{quantile}{\code{signature(object = "uGARCHsim", probs="numeric")}: 
	Calculates and returns, given a scalar for the probability (additional argument 
	\dQuote{probs}), the conditional quantile of the simulated object as an
	n.sim by m.sim matrix (with the same type of headings as the sigma and
	fitted methods).}
    \item{plot}{\code{signature(x = "uGARCHsim", y = "missing")}: 
    Simulation plots. }
    \item{show}{\code{signature(object = "uGARCHsim")}: 
    Simulation summary. }
	 }
}
\note{
The \code{sigma} and \code{fitted} methods are used to extract the matrix of 
simulated conditional sigma and mean values. The \code{as.data.frame}
method is globally deprecated as an extractor method in rugarch with the 
exception of a few classes which still makes sense to use them.
}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHforecast}}, \code{\linkS4class{uGARCHfit}} and 
\code{\linkS4class{uGARCHspec}}.
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
\keyword{classes}
