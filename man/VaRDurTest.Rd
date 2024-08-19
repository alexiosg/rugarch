\name{VaRDurTest}
\alias{VaRDurTest}
\title{
  VaR Duration Test
}
\description{
Implements the VaR Duration Test of Christoffersen and Pelletier.
}
\usage{
VaRDurTest(alpha, actual, VaR, conf.level = 0.95)
}
\arguments{
\item{alpha}{
The quantile (coverage) used for the VaR.}
\item{actual}{
A numeric vector of the actual (realized) values.}
\item{VaR}{The numeric vector of VaR.}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
}
\details{
The duration of time between VaR violations (no-hits) should ideally be 
independent and not cluster. Under the null hypothesis of a correctly specified 
risk model, the no-hit duration should have no memory. Since the only continuous
distribution which is memory free is the exponential, the test can conducted on
any distribution which embeds the exponential as a restricted case, and a 
likelihood ratio test then conducted to see whether the restriction holds. 
Following Christoffersen and Pelletier (2004), the Weibull distribution is used 
with parameter \sQuote{b=1} representing the case of the exponential. A future
release will include the choice of using a bootstrap method to evaluate the 
p-value, and until then care should be taken when evaluating series of length
less than 1000 as a rule of thumb.
}
\value{
	A list with the following items:\cr
	\item{b}{ The estimated Weibull parameter which when restricted to the value 
	of 1 results in the Exponential distribution.}
	\item{uLL}{ The unrestricted Log-Likelihood value.}
	\item{rLL}{The restricted Log-Likelihood value.}
	\item{LRp}{The Likelihood Ratio Test Statistic.}
	\item{H0}{The Null Hypothesis.} 
	\item{Decision}{ The on H0 given the confidence level}
	}
\references{
Christoffersen, P. and Pelletier, D. 2004, Backtesting value-at-risk: A 
duration-based approach, \emph{Journal of Financial Econometrics}, \bold{2(1)},
84--108.
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
print(VaRDurTest(0.05, actual, VaR))

# Try with the Normal Distribution (it fails)
spec = ugarchspec(mean.model = list(armaOrder = c(1,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "norm")
fit = ugarchfit(spec, data = dji30ret[1:1000, 1, drop = FALSE])
spec2 = spec
setfixed(spec2)<-as.list(coef(fit))
filt = ugarchfilter(spec2, dji30ret[1001:2500, 1, drop = FALSE], n.old = 1000)
actual = dji30ret[1001:2500,1]
# location+scale invariance allows to use [mu + sigma*q(p,0,1,skew,shape)]
VaR = fitted(filt) + sigma(filt)*qdist("norm", p=0.05, mu = 0, sigma = 1)
print(VaRDurTest(0.05, actual, VaR))
}}