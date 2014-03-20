\name{ARFIMAmultiforecast-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAmultiforecast-class}
\alias{fitted,ARFIMAmultiforecast-method}
\alias{show,ARFIMAmultiforecast-method}

\title{class: ARFIMA Multiple Forecast Class}
\description{
Class for the ARFIMA Multiple forecast.}
\section{Slots}{
  \describe{
    \item{\code{forecast}:}{Object of class \code{"vector"} }
    \item{\code{desc}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{fitted}{\code{signature(x = "ARFIMAmultiforecast")}: 
    Extracts the conditional mean forecast from the object, and returns an
    array of the n.ahead by (n.roll+1) by n.assets.}
    \item{show}{\code{signature(object = "ARFIMAmultiforecast")}: forecast summary. }
	 }
}
\author{Alexios Ghalanos}
\keyword{classes}