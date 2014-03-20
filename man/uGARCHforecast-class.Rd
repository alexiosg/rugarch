\name{uGARCHforecast-class}
\docType{class}
\alias{uGARCHforecast-class}
\alias{sigma,uGARCHforecast-method}
\alias{fitted,uGARCHforecast-method}
\alias{plot,uGARCHforecast,missing-method}
\alias{show,uGARCHforecast-method}
\alias{fpm}
\alias{fpm,ANY-method}
\alias{fpm,uGARCHforecast-method}
\alias{quantile,uGARCHforecast-method}
\title{class: Univariate GARCH Forecast Class}
\description{Class for the univariate GARCH forecast.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{\linkS4class{GARCHforecast}}, directly.
Class \code{\linkS4class{rGARCH}}, by class \code{\linkS4class{GARCHforecast}}, distance 2.
}
\section{Methods}{
  \describe{
   \item{sigma}{\code{signature(x = "uGARCHforecast")}: The n.ahead by n.roll+1
   matrix of conditional sigma forecasts. The column names are the T[0] dates.}
   \item{fitted}{\code{signature(x = "uGARCHforecast")}: The n.ahead by n.roll+1
   matrix of conditional mean forecasts. The column names are the T[0] dates.}
   	\item{quantile}{\code{signature(x = "uGARCHforecast")}: 
	Calculates and returns, given a scalar for the probability (additional argument 
	\dQuote{probs}), the conditional quantile of the forecast object as an
	n.ahead by n.roll+1 matrix (with the same type of headings as the sigma and
	fitted methods).}
    \item{plot}{\code{signature(x = "uGARCHforecast", y = "missing")}:
    Forecast plots with \code{n.roll} optional argument indicating the rolling 
    sequence to plot. }
    \item{fpm}{\code{signature(object = "uGARCHforecast")}: 
   Forecast performance measures.}
    \item{show}{\code{signature(object = "uGARCHforecast")}: 
    Forecast summary returning the 0-roll frame only.}
	 }
}
\note{
Since versions 1.01-3, a \code{sigma} and \code{fitted} methods have been introduced
which extract the n.ahead by (n.roll+1) matrix of conditional sigma and mean 
forecasts respectively, with column names the T[0] time index. This is unlike the
old \code{data.frame} which returned the T+1 etc dates. These two methods are the
default extractors in rugarch (used on estimated, filtered, forecast and 
simulation class objects) and the other methods, namely \code{as.data.frame} 
is now deprecated with the exception of a few classes where it is still used
(\code{\linkS4class{uGARCHdistribution}}, \code{\linkS4class{uGARCHboot}} 
and \code{\linkS4class{uGARCHroll}}).\cr
The plot method takes additional arguments \code{which} and \code{n.roll} 
indicating which roll frame to plot.\cr
The fpm method returns the Mean Squared Error (MSE), Mean Absolute Error (MAE), 
Directional Accuracy (DAC) and number of points used for the calculation (N), of 
forecast versus realized returns, if the extra \code{summary} option is set 
to TRUE (default). This is a 4 x (n.roll+1) matrix, with row headings the T[0]
time index, and requires at least 5 points to calculate the summary measures else
will return NA. When n.ahead>1, this method calculates the measures on the 
n.ahead>1 unconditional forecast, but if n.ahead=1 with n.roll>4, it will 
calculate the measures on the rolling forecast instead. Finally, when summary
is set to FALSE, the method will return a list of length n.roll+1 of xts objects
with the loss functions (Squared Error and Absolute Error and Directional Hits).
}
\seealso{
Classes \code{\linkS4class{uGARCHfit}}, \code{\linkS4class{uGARCHsim}} and 
\code{\linkS4class{uGARCHspec}}.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
# Basic GARCH(1,1) Spec
data(dmbp)
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec, out.sample = 100)
forc1 = ugarchforecast(fit, n.ahead=100, n.roll = 100)
forc
#plot(forc, which = "all")
}}
\keyword{classes}