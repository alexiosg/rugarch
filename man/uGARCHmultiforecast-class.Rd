\name{uGARCHmultiforecast-class}
\docType{class}
\alias{uGARCHmultiforecast-class}
\alias{sigma,uGARCHmultiforecast-method}
\alias{fitted,uGARCHmultiforecast-method}
\alias{show,uGARCHmultiforecast-method}
\title{class: Univariate GARCH Multiple Forecast Class}
\description{Class for the univariate GARCH Multiple forecast.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{\linkS4class{GARCHforecast}}, directly.
Class \code{\linkS4class{rGARCH}}, by class \code{\linkS4class{GARCHforecast}}, distance 3.
}
\section{Methods}{
\describe{
  \item{sigma}{\code{signature(x = "uGARCHmultiforecast")}: 
   		extracts the n.ahead by (n.roll+1) by n.assets array of conditional sigma 
   		forecasts.}
     \item{fitted}{\code{signature(x = "uGARCHforecast")}: 
     extracts the n.ahead by (n.roll+1) by n.assets array of conditional mean
   		forecasts.}
    \item{show}{\code{signature(object = "uGARCHforecast")}: forecast summary.}
  }
}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHmultifilter}}, \code{\linkS4class{uGARCHmultifit}} and 
\code{\linkS4class{uGARCHmultispec}}.
}
\keyword{classes}