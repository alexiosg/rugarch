\name{ARFIMAroll-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAroll-class}
\alias{as.data.frame,ARFIMAroll-method}
\alias{report,ARFIMAroll-method}
\alias{fpm,ARFIMAroll-method}
\alias{coef,ARFIMAroll-method}
\alias{resume,ARFIMAroll-method}
\alias{show,ARFIMAroll-method}
\title{class: ARFIMA Rolling Forecast Class}
\description{
Class for the ARFIMA rolling forecast.}
\section{Slots}{
  \describe{
    \item{\code{forecast}:}{Object of class \code{"vector"} }
    \item{\code{model}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{as.data.frame}{\code{signature(x = "ARFIMAroll")}: extracts various 
    values from object (see note). }
    \item{resume}{\code{signature(object = "ARFIMAroll")}:
	Resumes a rolling backtest which has non-converged windows using 
	alternative solver and control parameters.}
   \item{fpm}{\code{signature(object = "ARFIMAroll")}: 
   Forecast performance measures.}
   \item{coef}{\code{signature(object = "ARFIMAroll")}: 
    Extracts the list of coefficients for each estimated window in the 
    rolling backtest.}
    \item{report}{\code{signature(object = "ARFIMAroll")}: roll backtest reports 
    (see note).}
    \item{show}{\code{signature(object = "ARFIMAroll")}:
	Summary.}
	 }
}
\note{
The \code{as.data.frame} extractor method allows the extraction of either the
conditional forecast density or the VaR. It takes additional argument
\code{which} with valid values either \dQuote{density} or \dQuote{VaR}.\cr
The \code{coef} method will return a list of the coefficients and their robust 
standard errors (assuming the keep.coef argument was set to TRUE in the 
ugarchroll function), and the ending date of each estimation window.\cr
The \code{report} method takes the following additional arguments:\cr
1.\emph{type} for the report type. Valid values are \dQuote{VaR} for the VaR
report based on the unconditional and conditional coverage tests for exceedances 
(discussed below) and \dQuote{fpm} for forecast performance measures.\cr
2.\emph{VaR.alpha} (for the VaR backtest report) is the tail probability and 
defaults to 0.01.\cr
3.\emph{conf.level} the confidence level upon which the conditional coverage 
hypothesis test will be based on (defaults to 0.95).\cr
Kupiec's unconditional coverage test looks at whether the amount of expected 
versus actual exceedances given the tail probability of VaR actually occur as 
predicted, while the conditional coverage test of Christoffersen is a joint test 
of the unconditional coverage and the independence of the exceedances. Both the 
joint and the separate unconditional test are reported since it is always 
possible that the joint test passes while failing either the independence or 
unconditional coverage test.
The \code{fpm} method (separately from report) takes additional logical argument 
\emph{summary}, which when TRUE will return the mean squared error (MSE), 
mean absolute error (MAE) and directional accuracy of the forecast versus 
realized returns. When FALSE, it will return a data.frame of the time series 
of squared (SE) errors, absolute errors (AE), directional hits (HITS), and a
VaR Loss function described in Gonzalez-Rivera, Lee, and Mishra (2004)
for each coverage level where it was calculated. This can then be compared, with
the VaR loss of competing models using such tests as the model confidence set 
(MCS) of Hansen, Lunde and Nason (2011).
}
\author{Alexios Ghalanos}
\keyword{classes}