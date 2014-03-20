\name{ESTest}
\alias{ESTest}
\title{
  Expected Shortfall Test.
}
\description{
Implements the Expected Shortfall Test of McNeil and Frey. 
}
\usage{
ESTest(alpha = 0.05, actual, ES, VaR, conf.level = 0.95, 
boot = FALSE, n.boot = 1000)
}
\arguments{
\item{alpha}{
The quantile (coverage) used for the VaR.}
\item{actual}{
A numeric vector of the actual (realized) values.}
\item{ES}{
The numeric vector of the Expected Shortfall (ES).
}
\item{VaR}{
The numeric vector of VaR.
}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
\item{boot}{
Whether to bootstrap the test.
}
\item{n.boot}{
Number of bootstrap replications to use.
}
}
\details{
The Null hypothesis is that the excess conditional shortfall (excess
of the actual series when VaR is violated), is i.i.d. and has zero mean. The 
test is a one sided t-test against the alternative that the excess shortfall has
mean greater than zero and thus that the conditional shortfall is systematically
underestimated. Using the bootstrap to obtain the p-value should alleviate any 
bias with respect to assumptions about the underlying distribution of the excess 
shortfall.
}
\value{
	A list with the following items:\cr
	\item{expected.exceed}{ The expected number of exceedances 
	(length actual x coverage).}
	\item{actual.exceed}{ The actual number of exceedances.}
	\item{H1}{The Alternative Hypothesis of the one sided test (see details).}
	\item{boot.p.value}{The bootstrapped p-value (if used).}
	\item{p.value}{The p-value.} 
	\item{Decision}{The one-sided test Decision on H0 given the
	confidence level and p-value (not the bootstrapped).}
}
\references{
McNeil, A.J. and Frey, R. and Embrechts, P. (2000), Estimation of tail-related 
risk measures for heteroscedastic financial time series: an extreme value 
approach, \emph{Journal of Empirical Finance},\bold{7}, 271--300.
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
# calculate ES
f = function(x) qdist("sstd", p=x, mu = 0, sigma = 1, 
skew  = coef(fit)["skew"], shape=coef(fit)["shape"])
ES = fitted(filt) + sigma(filt)*integrate(f, 0, 0.05)$value/0.05
print(ESTest(0.05, actual, ES, VaR, boot = TRUE))
}}