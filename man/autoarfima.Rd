\name{autoarfima}
\alias{autoarfima}
\title{
	Automatic Model Selection for ARFIMA models
}
\description{
Select best fitting ARFIMA models based on information criteria.
}
\usage{
autoarfima(data, ar.max = 2, ma.max = 2, criterion = c("AIC","BIC","SIC","HQIC"),
method = c("partial", "full"), arfima = FALSE, include.mean = NULL, 
distribution.model = "norm", cluster = NULL, external.regressors = NULL, 
solver = "solnp", solver.control=list(), fit.control=list(), return.all = FALSE)
}
\arguments{
\item{data}{ A univariate data object. Can be a numeric vector, matrix, 
data.frame, zoo, xts, timeSeries, ts or irts object.}
\item{ar.max}{
Maximum AR order to test for.}
\item{ma.max}{
Maximum MA order to test for.}
\item{criterion}{
Information Criterion to use for selecting the best model.}
\item{method}{
The partial method tests combinations of consecutive orders of AR and 
MA i.e. 1:2, 1:3 etc, while the full method tests all possible combinations
within the consecutive orders thus enumerating the complete combination space
of the MA and AR orders.
.}
\item{arfima}{
Can be TRUE, FALSE or NULL in which case it is tested.}
\item{include.mean}{
Can be TRUE, FALSE or NULL in which case it is tested.}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation.
}
\item{external.regressors}{A matrix object containing the external regressors to 
 include in the mean equation with as many rows as will be included in the
 data (which is passed in the fit function).}
\item{distribution.model}{
The distribution density to use for the innovations (defaults to Normal).}
\item{solver}{One of either \dQuote{nlminb}, \dQuote{solnp}, \dQuote{gosolnp}
or \dQuote{nloptr}.}
\item{solver.control}{Control arguments list passed to optimizer.}
\item{fit.control}{Control arguments passed to the fitting routine.}
\item{return.all}{Whether to return all the fitted models or only the best one.}
}
\value{
	A list with the following items:\cr
	\item{fit}{ Either the best fitted model or all the fitted models if the 
	option \sQuote{return.all} was selected.}
	\item{rank.matrix}{ Either a sorted matrix of the models and their information
	criterion, else an unsorted matrix of the models and their information criterion
	if the option \sQuote{return.all} was selected.}
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(sp500ret)
fit = autoarfima(data = sp500ret[1:1000,], ar.max = 2, ma.max = 2, 
criterion = "AIC", method = "full")
}}