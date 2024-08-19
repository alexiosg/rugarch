\name{uGARCHboot-class}
\docType{class}
\alias{uGARCHboot-class}
\alias{as.data.frame,uGARCHboot-method}
\alias{plot,uGARCHboot,missing-method}
\alias{show,uGARCHboot-method}
\title{class: Univariate GARCH Bootstrap Class}
\description{Class for the univariate GARCH Bootstrap based Forecasts.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{"\linkS4class{GARCHboot}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHboot", distance 2.
}
\section{Methods}{
\describe{
\item{as.data.frame}{\code{signature(x = "uGARCHboot")}: 
extracts various values from object (see note).}
\item{plot}{\code{signature(x = "uGARCHboot", y = "missing")}: 
bootstrap forecast plots. }
\item{show}{\code{signature(object = "uGARCHboot")}: 
bootstrap forecast summary. }
}
}
\note{
The \code{as.data.frame} function takes optionally the arguments \code{which}, 
being either \dQuote{sigma} or \dQuote{series}, the argument \code{type}, 
with the options \dQuote{raw} for the bootstrapped series, \dQuote{summary} for 
summary statistics per n.ahead, and \dQuote{q} for the quantiles of the n.ahead 
bootstrapped series, for which the option \code{qtile} is then required and 
takes a numeric vector of quantiles (e.g. c(0.05, 0.95) ).\cr
The plot method provides for a Parameter Density Plots (only valid for the 
\dQuote{full} method), and the series and sigma forecast plots with quantile 
error lines from the bootstrapped n.ahead distribution. The plot option 
\code{which} relates to either a numeric choice (1:3), an interactive choice 
(\dQuote{ask} which is the default) and an all plot choice (\dQuote{all}) for 
which only plots 2 and 3 are included.
}
\references{
Pascual, L., Romo, J. and Ruiz, E. 2004, Bootstrap predictive inference for 
ARIMA processes, \emph{Journal of Time Series Analysis}.\cr
Pascual, L., Romo, J. and Ruiz, E. 2006, Bootstrap prediction for returns and 
volatilities in GARCH models, \emph{Computational Statistics and Data Analysis}.\cr
}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHforecast}}, \code{\linkS4class{uGARCHfit}} and 
\code{\linkS4class{uGARCHspec}}.
}
\keyword{classes}