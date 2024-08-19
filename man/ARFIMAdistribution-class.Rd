\name{ARFIMAdistribution-class}
\docType{class}
\alias{ARFIMAdistribution-class}
\alias{as.data.frame,ARFIMAdistribution-method}
\alias{show,ARFIMAdistribution-method}

\title{class: ARFIMA Parameter Distribution Class}
\description{
Class for the ARFIMA Parameter Distribution, objects of which are created by 
calling function \code{\link{arfimadistribution}}.
}
\section{Slots}{
  \describe{
    \item{\code{dist}:}{Object of class \code{"vector"} Details of fitted 
    parameters.}
    \item{\code{truecoef}:}{Object of class \code{"matrix"} The actual 
    coefficients.}
    \item{\code{model}:}{Object of class \code{"list"} The model specification.}
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{as.data.frame}{\code{signature(x = "ARFIMAdistribution")}: extracts 
    various values from object (see note). }
    \item{show}{\code{signature(object = "ARFIMAdistribution")}: parameter 
    distribution summary. }
	 }
}
\note{
The \code{as.data.frame} function takes optionally 2 additional arguments, 
namely \code{window} which indicates the particular distribution window number 
for which data is required (is usually just 1 unless the recursive option was 
used), and \code{which} indicating the type of data required. Valid values for 
the latter are \dQuote{rmse} for the root mean squared error between simulation 
fit and actual parameters, \dQuote{stats} for various statistics computed for 
the simulations such as log likelihood, persistence, unconditional variance and 
mean, \dQuote{coef} for the estimated coefficients (i.e. the parameter 
distribution and is the default choice), and \dQuote{coefse} for the estimated 
robust standard errors of the coefficients (i.e. the parameter standard error 
distribution).}
\author{Alexios Ghalanos}
\keyword{classes}