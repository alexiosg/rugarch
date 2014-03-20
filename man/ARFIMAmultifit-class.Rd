\name{ARFIMAmultifit-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAmultifit-class}
\alias{coef,ARFIMAmultifit-method}
\alias{fitted,ARFIMAmultifit-method}
\alias{likelihood,ARFIMAmultifit-method}
\alias{residuals,ARFIMAmultifit-method}
\alias{show,ARFIMAmultifit-method}
\title{class: ARFIMA Multiple Fit Class}
\description{
Class for the ARFIMA Multiple fit.}
\section{Slots}{
  \describe{
    \item{\code{fit}:}{Object of class \code{"vector"} }
    \item{\code{desc}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "ARFIMAmultifit")}: 
    	Extracts the coefficients. }
    \item{likelihood}{\code{signature(object = "ARFIMAmultifit")}: 
    	Extracts the likelihood. }
    \item{fitted}{\code{signature(object = "ARFIMAmultifit")}: 
    	Extracts the fitted values.}
    \item{residuals}{\code{signature(object = "ARFIMAmultifit")}: 
    	Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{show}{\code{signature(object = "ARFIMAmultifit")}: 
    	Fit summary.}
	 }
}
\author{Alexios Ghalanos}
\keyword{classes}