\name{uGARCHmultifit-class}
\Rdversion{1.1}
\docType{class}
\alias{uGARCHmultifit-class}
\alias{residuals,uGARCHmultifit-method}
\alias{fitted,uGARCHmultifit-method}
\alias{coef,uGARCHmultifit-method}
\alias{show,uGARCHmultifit-method}
\alias{sigma,uGARCHmultifit-method}
\alias{likelihood,uGARCHmultifit-method}
\title{class: Univariate GARCH Multiple Fit Class}
\description{Class for the univariate GARCH Multiple fit.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{\linkS4class{GARCHfit}}, directly.
Class \code{\linkS4class{rGARCH}}, by class \code{\linkS4class{GARCHfit}}, distance 3.
}
\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "uGARCHmultifit")}: 
    Extracts the coefficients. }
    \item{likelihood}{\code{signature(object = "uGARCHmultifit")}: 
    Extracts the likelihood. }
    \item{sigma}{\code{signature(object = "uGARCHmultifit")}: 
    Extracts the conditional sigma values.}
    \item{fitted}{\code{signature(object = "uGARCHmultifit")}: 
    Extracts the fitted values.}
    \item{residuals}{\code{signature(object = "uGARCHmultifit")}: 
	Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{show}{\code{signature(object = "uGARCHmultifit")}: 
    Fit summary.}
	}
}
\note{
Methods for coef, likelihood, fitted, sigma and residuals provide extractor 
functions for those values.\cr}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHmultiforecast}}, \code{\linkS4class{uGARCHmultispec}} 
and \code{\linkS4class{uGARCHmultifilter}}.
}
\keyword{classes}