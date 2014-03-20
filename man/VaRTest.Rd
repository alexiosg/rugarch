\name{VaRTest}
\alias{VaRTest}
\title{
  Value at Risk Exceedances Test
}
\description{
Implements the unconditional and conditional coverage Value at Risk
Exceedances Test. 
}
\usage{
VaRTest(alpha = 0.05, actual, VaR, conf.level = 0.95)
}
\arguments{
\item{alpha}{
The quantile (coverage) used for the VaR.}
\item{actual}{
A numeric vector of the actual (realized) values.}
\item{VaR}{
The numeric vector of VaR.
}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
}
\details{
The test implements both the unconditional (Kupiec) and conditional(Christoffersen)
coverage tests for the correct number of exceedances.
See the references for further details.
}
\value{
	A list with the following items:\cr
	\item{expected.exceed}{ The expected number of exceedances 
	(length actual x coverage).}
	\item{actual.exceed}{ The actual number of exceedances.}
	\item{uc.H0}{The unconditional coverage test Null Hypothesis.}
	\item{uc.LRstat}{The unconditional coverage test Likelihood Ratio statistic.}
	\item{uc.critical}{The unconditional coverage test critical value.} 
	\item{uc.LRp}{ The unconditional coverage test p-value.}
	\item{uc.H0}{The unconditional coverage test Null Hypothesis.}
	\item{uc.Decision}{The unconditional coverage test Decision on H0 given the
	confidence level.}
	\item{cc.H0}{The conditional coverage test Null Hypothesis.}
	\item{cc.LRstat}{The conditional coverage test Likelihood Ratio statistic.}
	\item{cc.critical}{The conditional coverage test critical value.} 
	\item{cc.LRp}{ The conditional coverage test p-value.}
	\item{cc.H0}{The conditional coverage test Null Hypothesis.}
	\item{cc.Decision}{The conditional coverage test Decision on H0 given the
	confidence level.}
}
\references{
Christoffersen, P. (1998), Evaluating Interval Forecasts, 
\emph{International Economic Review}, \bold{39}, 841--862.\cr
Christoffersen, P., Hahn,J. and Inoue, A. (2001), Testing and Comparing 
Value-at-Risk Measures, \emph{Journal of Empirical Finance}, \bold{8}, 325--342.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec(mean.model = list(armaOrder = c(1,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "sstd")
fit = ugarchfit(spec, data = dji30ret[1:1000, 1, drop = FALSE])
spec2 = spec
setfixed(spec2)<-as.list(coef(fit))
filt = ugarchfilter(spec2, dji30ret[1001:2500, 1, drop = FALSE], n.old = 1000)
actual = dji30ret[1001:2500,1]
# location+scale invariance allows to use [mu + sigma*q(p,0,1,skew,shape)]
VaR = fitted(filt) + sigma(filt)*qdist("sstd", p=0.05, mu = 0, sigma = 1, 
skew  = coef(fit)["skew"], shape=coef(fit)["shape"])
print(VaRTest(0.05, as.numeric(actual), as.numeric(VaR)))
}}
