\name{ARFIMAfit-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAfit-class}
\alias{coef,ARFIMAfit-method}
\alias{fitted,ARFIMAfit-method}
\alias{getspec,ARFIMAfit-method}
\alias{infocriteria,ARFIMAfit-method}
\alias{likelihood,ARFIMAfit-method}
\alias{residuals,ARFIMAfit-method}
\alias{getspec,ARFIMAfit-method}
\alias{reduce,ARFIMAfit-method}
\alias{show,ARFIMAfit-method}
\alias{uncmean,ARFIMAfit-method}
\alias{convergence,ARFIMAfit-method}
\alias{vcov,ARFIMAfit-method}

\title{class: ARFIMA Fit Class}
\description{
Class for the ARFIMA fit.
}
\section{Slots}{
  \describe{
    \item{\code{fit}:}{Object of class \code{"vector"} }
    \item{\code{model}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{coef}{\code{signature(object = "ARFIMAfit")}: 
    Extracts the coefficients.}
    \item{fitted}{\code{signature(object = "ARFIMAfit")}: 
    Extracts the fitted values.}
    \item{infocriteria}{\code{signature(object = "ARFIMAfit")}: 
    Calculates and returns various information criteria.}
    \item{likelihood}{\code{signature(object = "ARFIMAfit")}: 
    Extracts the likelihood.}
    \item{residuals}{\code{signature(object = "ARFIMAfit")}: 
    Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{show}{\code{signature(object = "ARFIMAfit")}: 
    Fit summary.}
    \item{uncmean}{\code{signature(object = "ARFIMAfit")}: 
    Calculates and returns the unconditional mean. Takes additional arguments 
    \sQuote{method} with option for \dQuote{analytical} or \dQuote{simulation}, 
    \sQuote{n.sim} for the number of simulations (if that method was chosen, 
    and defaults to 100000) and \sQuote{rseed} for the simulation random 
    generator initialization seed.}
    \item{vcov}{\code{signature(object = "ARFIMAfit")}: 
	Extracts the covariance matrix of the parameters. Additional logical option of 
	\sQuote{robust} indicates whether to extract the robust based covariance matrix. }
	\item{convergence}{\code{signature(object = "ARFIMAfit")}: 
	Returns the solver convergence code for the fitted object (zero denotes
	convergence). }
	\item{reduce}{\code{signature(object = "ARFIMAfit")}: 
	Zeros parameters (fixing to zero in rugarch is equivalent to eliminating them 
	in estimation) with p-values (optional argument \dQuote{pvalue}) greater 
	than 0.1 (default), and re-estimates the model. Additional arguments are passed
	to \code{\link{arfimafit}}.An additional option \dQuote{use.robust} (default TRUE) 
	asks whether to use the robust calculated p-values.}
	\item{getspec}{\code{signature(object = "ARFIMAfit")}: 
	Extracts and returns the ARFIMA specification from a fitted object.}
	}
}
\author{Alexios Ghalanos}
\examples{
showClass("ARFIMAfit")
}
\keyword{classes}
