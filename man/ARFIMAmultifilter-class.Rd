\name{ARFIMAmultifilter-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAmultifilter-class}
\alias{coef,ARFIMAmultifilter-method}
\alias{fitted,ARFIMAmultifilter-method}
\alias{likelihood,ARFIMAmultifilter-method}
\alias{residuals,ARFIMAmultifilter-method}
\alias{show,ARFIMAmultifilter-method}
\title{class: ARFIMA Multiple Filter Class}
\description{
Class for the ARFIMA Multiple filter.}
\section{Slots}{
  \describe{
    \item{\code{filter}:}{Object of class \code{"vector"} }
    \item{\code{desc}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{fitted}{\code{signature(object = "ARFIMAmultifilter")}:
    	Extracts the fitted values.}
    \item{residuals}{\code{signature(object = "ARFIMAmultifilter")}: 
    	Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{coef}{\code{signature(object = "ARFIMAmultifilter")}:
    	Extracts the coefficients.}
    \item{likelihood}{\code{signature(object = "ARFIMAmultifilter")}:
    	Extracts the likelihood. }
    \item{show}{\code{signature(object = "ARFIMAmultifilter")}: Filter summary. }
	 }
}
\author{Alexios Ghalanos}
\keyword{classes}