\name{mcsTest}
\alias{mcsTest}
\title{
Model Confidence Set Test
}
\description{
Implements the Model Confidence Set Test procedure of Hansen, Lunde and 
}
\usage{
mcsTest(losses, alpha, nboot = 100, nblock = 1, boot = c("stationary", "block"))
}
\arguments{
\item{losses}{
A matrix of losses from competing models.}
\item{alpha}{
The p-value used in the test.}
\item{nboot}{
The number of bootstrap replications.}
\item{nblock}{
The block length to use in the bootstrap.
}
\item{boot}{
A choice of either the stationary or block boostrap.
}
}
\details{
Calculates and returns the results of both the R (range) and SQ (semi-quadratic) statistics.
}
\value{
	A list with the following items:\cr
	\item{includedR}{ The models included based on the R statistic.}
	\item{pvalsR}{ The final p-values of each model under the R statistic.}
	\item{excludedR}{The excluded models based on the R statistic.}
	\item{includedSQ}{ The models included based on the SQ statistic.}
	\item{pvalsSQ}{ The final p-values of each model under the SQ statistic.}
	\item{excludedSQ}{The excluded models based on the SQ statistic.}
}
\references{
Hansen, P. R., Lunde, A., and Nason, J. M., 2011. The model confidence set. 
\emph{Econometrica}, \bold{79(2)}, 453--497.\cr
}
\author{Alexios Ghalanos}