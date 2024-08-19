\name{ARFIMAforecast-class}
\Rdversion{1.1}
\docType{class}
\alias{ARFIMAforecast-class}
\alias{fitted,ARFIMAforecast-method}
\alias{show,ARFIMAforecast-method}
\alias{fpm,ARFIMAforecast-method}
\title{class: ARFIMA Forecast Class}
\description{
Class for the ARFIMA forecast.
}
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
   \item{fitted}{\code{signature(x = "ARFIMAforecast")}: 
   The n.ahead by n.roll+1 matrix of conditional mean forecasts. The column 
   names are the T[0] dates.}
   \item{fpm}{\code{signature(object = "ARFIMAforecast")}: 
   Forecast performance measures.}
   \item{show}{\code{signature(object = "ARFIMAforecast")}: 
   Forecast summary returning the 0-roll frame only.}
	}
}
\note{
Since versions 1.01-3, the \code{fitted} method has been introduced
which extracts the n.ahead by (n.roll+1) matrix of conditional mean forecasts, 
with column names the T[0] time index. This is unlike the old \code{data.frame} 
which returned the T+1 etc dates. This method is the default extractor in 
rugarch package for the conditional mean (whether from an estimated, filtered, 
forecast or simulated object) and the other method, namely \code{as.data.frame} 
is now deprecated with the exception of a few classes where it is still used
(\code{\linkS4class{ARFIMAdistribution}} and \code{\linkS4class{ARFIMAroll}}).\cr
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
\author{Alexios Ghalanos}

\keyword{classes}
