\name{ARFIMAfilter-class}
\docType{class}
\alias{ARFIMAfilter-class}
\alias{coef,ARFIMAfilter-method}
\alias{fitted,ARFIMAfilter-method}
\alias{infocriteria,ARFIMAfilter-method}
\alias{likelihood,ARFIMAfilter-method}
\alias{residuals,ARFIMAfilter-method}
\alias{show,ARFIMAfilter-method}
\alias{uncmean,ARFIMAfilter-method}
\title{class: ARFIMA Filter Class}
\description{Class for the ARFIMA filter.}
\section{Slots}{
  \describe{
    \item{\code{filter}:}{Object of class \code{"vector"} }
    \item{\code{model}:}{Object of class \code{"vector"}  }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "ARFIMAfilter")}: 
    Extracts the coefficients.}
    \item{fitted}{\code{signature(object = "ARFIMAfilter")}: 
    Extracts the filtered values.}
    \item{infocriteria}{\code{signature(object = "ARFIMAfilter")}: 
    Calculates and returns various information criteria.}
    \item{likelihood}{\code{signature(object = "ARFIMAfilter")}: 
    Extracts the likelihood. }
    \item{residuals}{\code{signature(object = "ARFIMAfilter")}: 
    Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{show}{\code{signature(object = "ARFIMAfilter")}: 
    Filter summary.}
    \item{uncmean}{\code{signature(object = "ARFIMAfilter")}: 
    Calculates and returns the unconditional mean. Takes additional arguments 
    \sQuote{method} with option for \dQuote{analytical} or \dQuote{simulation}, 
    \sQuote{n.sim} for the number of simulations (if that method was chosen, and 
    defaults to 100000) and \sQuote{rseed} for the simulation random generator 
    initialization seed. Note that the simulation method is only available for 
    a fitted object or specification with fixed parameters, and not for the 
    filtered object.}
	}
}
\author{Alexios Ghalanos}

\examples{
showClass("ARFIMAfilter")
}
\keyword{classes}
