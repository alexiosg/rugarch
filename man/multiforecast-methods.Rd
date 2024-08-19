\name{multiforecast-methods}
\docType{methods}
\alias{multiforecast}
\alias{multiforecast-methods}
\alias{multiforecast,ANY-method}
\alias{multiforecast,uGARCHmultifit-method}
\alias{multiforecast,uGARCHmultispec-method}
\alias{multiforecast,ARFIMAmultifit-method}
\alias{multiforecast,ARFIMAmultispec-method}
\title{function: Univariate GARCH and ARFIMA Multiple Forecasting}
\description{
Method for multiple forecasting from a variety of univariate GARCH and ARFIMA 
models.
}
\usage{
multiforecast(multifitORspec, data = NULL, n.ahead = 1, n.roll = 0, 
out.sample = 0, external.forecasts = list(mregfor = NULL, vregfor = NULL), 
cluster = NULL, ...)
}
\arguments{
\item{multifitORspec}{
Either a univariate GARCH or ARFIMA multiple fit object \code{\linkS4class{uGARCHmultifit}} 
and \code{\linkS4class{ARFIMAmultifit}}, or alternatively a univariate GARCH or 
ARFIMA multiple specification object of class \code{\linkS4class{uGARCHmultispec}} 
and \code{\linkS4class{ARFIMAmultispec}} with valid parameters supplied via the 
\code{setfixed<-} function in the individual specifications.}
\item{data}{
Required if a multiple specification rather than a multiple fit object is 
supplied. A multivariate data object. Can be a matrix or data.frame object, no 
other class supported at present.}
\item{n.ahead}{
The forecast horizon.}
\item{n.roll}{
The no. of rolling forecasts to create beyond the first one.}
\item{out.sample}{
Optional. If a specification object is supplied, indicates how many data points
to keep for out of sample testing. If this is not a vector equal to the column 
dimension of the data, then it will be replicated to that dimension, else it must 
be of same length as the data column dimension.}
\item{external.forecasts}{
A list with forecasts for the external regressors in the mean and/or variance 
equations if specified.}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation
of the refits (remember to stop the cluster on completion).
}
\item{...}{ . }
}
\value{
A \code{\linkS4class{uGARCHmultiforecast}} or \code{\linkS4class{ARFIMAmultiforecast}} 
object containing details of the multiple GARCH or ARFIMA forecasts. See the 
class for details.
}
\author{Alexios Ghalanos}
\keyword{methods}