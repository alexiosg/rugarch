\name{arfimafilter-methods}
\docType{methods}
\alias{arfimafilter-methods}
\alias{arfimafilter,ANY-method}
\alias{arfimafilter,ARFIMAspec-method}
\alias{arfimafilter}
\title{function: ARFIMA Filtering}
\description{
Method for filtering an ARFIMA model.
}
\usage{
arfimafilter(spec, data, out.sample = 0, n.old=NULL, ...)
}
\arguments{
\item{data}{ A univariate data object. Can be a numeric vector, matrix, 
data.frame, zoo, xts, timeSeries, ts or irts object.}
\item{spec}{ An ARFIMA spec object of class \code{\linkS4class{ARFIMAspec}} 
with the fixed.pars argument having the model parameters on which the filtering 
is to take place.}
\item{out.sample}{ A positive integer indicating the number of periods before 
the last to keep for out of sample forecasting (as in \code{\link{arfimafit}} 
function).}
\item{n.old}{ For comparison with ARFIMA models using the out.sample argument,
this is the length of the original dataset (see details).}
\item{...}{ . }
}
\value{
A \code{\linkS4class{ARFIMAfilter}} object containing details of the ARFIMA 
filter.
}
\details{
The n.old argument is optional and indicates the length of the original data
(in cases when this represents a dataseries augmented by newer data). The reason
for using this is so that the old and new datasets agree since the original 
recursion uses the sum of the residuals to start the recursion and therefore is 
influenced by new data. For a small augmentation the values converge after x 
periods, but it is sometimes preferable to have this option so that there is no 
forward looking information contaminating the study.
}
\author{Alexios Ghalanos}
\keyword{methods}
