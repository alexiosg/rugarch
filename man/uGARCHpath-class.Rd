\name{uGARCHpath-class}
\docType{class}
\alias{uGARCHpath-class}
\alias{sigma,uGARCHpath-method}
\alias{fitted,uGARCHpath-method}
\alias{quantile,uGARCHpath-method}
\alias{plot,uGARCHpath,missing-method}
\alias{show,uGARCHpath-method}
\title{class: Univariate GARCH Path Simulation Class}
\description{Class for the univariate GARCH Path simulation.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{"\linkS4class{uGARCHpath}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHpath", distance 2.
}
\section{Methods}{
  \describe{
    \item{sigma}{\code{signature(object = "uGARCHpath")}: 
	Extracts the conditional sigma simulated values as a matrix of size n.sim x m.sim.}
	\item{fitted}{\code{signature(object = "uGARCHpath")}: 
	Extracts the conditional mean simulated values as a matrix of size n.sim x m.sim.}
	\item{quantile}{\code{signature(x = "uGARCHpath")}: 
	Calculates and returns, given a scalar for the probability (additional argument 
	\dQuote{probs}), the conditional quantile of the simulated object as an
	n.sim by m.sim matrix (with the same type of headings as the sigma and
	fitted methods).}
    \item{plot}{\code{signature(x = "uGARCHpath", y = "missing")}: path simulation plots. }
    \item{show}{\code{signature(object = "uGARCHpath")}: path simulation summary. }
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
Classes \code{\linkS4class{uGARCHsim}}, \code{\linkS4class{uGARCHfit}} and 
\code{\linkS4class{uGARCHspec}}.
}
\keyword{classes}