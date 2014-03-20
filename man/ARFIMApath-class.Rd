\name{ARFIMApath-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMApath-class}
\alias{fitted,ARFIMApath-method}
\alias{show,ARFIMApath-method}

\title{class: ARFIMA Path Simulation Class}
\description{
Class for the ARFIMA Path simulation.}
\section{Slots}{
  \describe{
    \item{\code{path}:}{Object of class \code{"vector"} }
    \item{\code{model}:}{Object of class \code{"vector"} }
    \item{\code{seed}:}{Object of class \code{"integer"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{fitted}{\code{signature(x = "ARFIMApath")}: 
    Extracts the simulated path values as a matrix of dimension n.sim by m.sim.}
    \item{show}{\code{signature(object = "ARFIMApath")}: path simulation summary. }
	 }
}
\author{Alexios Ghalanos}
\keyword{classes}
