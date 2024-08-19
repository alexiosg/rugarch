\name{ARFIMAsim-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAsim-class}
\alias{fitted,ARFIMAsim-method}
\alias{show,ARFIMAsim-method}
\title{class: ARFIMA Simulation Class}
\description{
Class for the ARFIMA simulation.
}
\section{Slots}{
  \describe{
    \item{\code{simulation}:}{Object of class \code{"vector"} }
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
    \item{fitted}{\code{signature(x = "ARFIMAsim")}: extracts the simulated values 
    as a matrix of dimension n.sim by m.sim.}
    \item{show}{\code{signature(object = "ARFIMAsim")}: simulation summary. }
	 }
}
\author{Alexios Ghalanos}
\keyword{classes}
