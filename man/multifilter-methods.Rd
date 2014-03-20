\name{multifilter-methods}
\docType{methods}
\alias{multifilter}
\alias{multifilter-methods}
\alias{multifilter,ANY-method}
\alias{multifilter,uGARCHmultifit-method}
\alias{multifilter,uGARCHmultispec-method}
\alias{multifilter,ARFIMAmultifit-method}
\alias{multifilter,ARFIMAmultispec-method}
\title{function: Univariate GARCH and ARFIMA Multiple Filtering}
\description{
Method for multiple filtering of a variety of univariate GARCH and ARFIMA models.
}
\usage{
multifilter(multifitORspec, data = NULL, out.sample = 0, n.old = NULL, 
rec.init = "all", cluster = NULL, ...)
}
\arguments{
\item{multifitORspec}{
Either a univariate GARCH or ARFIMA multiple fit object of class 
\code{\linkS4class{uGARCHmultifit}} and \code{\linkS4class{ARFIMAmultifit}}, or
alternatively a univariate GARCH or ARFIMA multiple specification object of 
class \code{\linkS4class{uGARCHmultispec}}  and \code{\linkS4class{ARFIMAmultispec}}
with valid parameters supplied via the \code{fixed.pars} argument in the 
individual specifications.}
\item{data}{
Required if a multiple specification rather than a multiple fit object is 
supplied. A multivariate data object. Can be a matrix or data.frame object, 
no other class supported at present.}
\item{out.sample}{
A positive integer indicating the number of periods before the last to keep for 
out of sample forecasting (as in \code{\link{ugarchfit}} function).}
\item{n.old}{
For comparison with uGARCHfit or ARFIMAfit models using the out.sample argument,
this is the length of the original dataset (see details).}
\item{rec.init}{
Recursion initialization method (as in \code{\link{ugarchfit}} function), valid
only for GARCH models, and can be a vector of length equal to the number of 
assets being modelled.}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation.
}
\item{...}{ . }
}
\value{
A \code{\linkS4class{uGARCHmultifilter}} object containing details of the multiple GARCH filter.
A \code{\linkS4class{ARFIMAmultifilter}} object containing details of the multiple ARFIMA filter.
}
\author{Alexios Ghalanos}