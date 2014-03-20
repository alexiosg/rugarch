\name{uGARCHroll-class}
\docType{class}
\alias{uGARCHroll-class}
\alias{as.data.frame,uGARCHroll-method}
\alias{plot,uGARCHroll,missing-method}
\alias{report,uGARCHroll-method}
\alias{show,uGARCHroll-method}
\alias{report,ANY-method}
\alias{report}
\alias{resume,ANY-method}
\alias{resume}
\alias{resume,uGARCHroll-method}
\alias{fpm,uGARCHroll-method}
\alias{quantile,uGARCHroll-method}
\alias{pit,uGARCHroll-method}
\alias{convergence,uGARCHroll-method}
\alias{coef,uGARCHroll-method}
\title{class: Univariate GARCH Rolling Forecast Class}
\description{Class for the univariate GARCH rolling forecast.}
\section{Slots}{
  \describe{
    \item{\code{forecast}:}{Object of class \code{"vector"} }
    \item{\code{model}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{GARCHroll}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHroll", distance 2.
}
\section{Methods}{
  \describe{
    \item{as.data.frame}{\code{signature(x = "uGARCHroll")}: 
    Extracts various values from object (see note).}
    \item{plot}{\code{signature(x = "uGARCHroll", y = "missing")}:
    Roll result backtest plots (see note).}
    \item{report}{\code{signature(object = "uGARCHroll")}:
	Roll backtest reports (see note).}
	\item{resume}{\code{signature(object = "uGARCHroll")}:
	Resumes a rolling backtest which has non-converged windows using 
	alternative solver and control parameters.}
	\item{fpm}{\code{signature(object = "uGARCHroll")}: 
    Forecast performance measures.}
    \item{coef}{\code{signature(object = "uGARCHroll")}: 
    Extracts the list of coefficients for each estimated window in the 
    rolling backtest.}
    \item{quantile}{\code{signature(x = "uGARCHroll")}: 
	Calculates and returns, given a vector of probabilities (additional argument 
	\dQuote{probs}), the conditional quantiles of the rolling object as an
	xts matrix.}
	\item{pit}{\code{signature(object = "uGARCHroll")}: 
	Calculates and returns the conditional probability integral transform given the 
	realized data and forecast density.}
    \item{convergence}{\code{signature(object = "uGARCHroll")}: 
    Returns the convergence code for the estimation windows, with 0 indicating
    that all have converged and 1 that there were non-converged windows. In 
    the latter case the \sQuote{nonconverged} attribute is also printed of those 
    windows which failed to converge.}
    \item{show}{\code{signature(object = "uGARCHroll")}:
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
The \code{plot} method takes the following additional arguments:\cr
1.\emph{which} allows for either a numeric value of 1:4, else will default to 
\dQuote{ask} for interactive printing of the options in the command windows.
Additionally, the value of \dQuote{all} wil create a 2x2 chart with all plots.\cr
2.\emph{VaR.alpha} for the Value at Risk backtest plot, this is the tail 
probability and defaults to 0.01.\cr
3.\emph{density.support} the support for the time varying density plot density, 
defaults to c(-0.15, 0.15) but you should change this to something more 
appropriate for your data and period under consideration.\cr
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