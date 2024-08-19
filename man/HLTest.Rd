\name{HLTest}
\alias{HLTest}
\title{
  The Non-Parametric Density Test of Hong and Li
}
\description{
Implements the Non-Parametric Density Test of Hong and Li. 
}
\usage{
HLTest(PIT, lags = 4, kernel = "quartic", conf.level = 0.95)
}
\arguments{
\item{PIT}{
This represents the actual data transformed into a U(0,1) series by applying the
distribution function of the estimated model conditional on the parameters.}
\item{lags}{
The number of lags to use for testing the joint hypothesis.}
\item{kernel}{
The kernel to use for the comparison against the PIT series (only the 
\sQuote{quartic} currently implemented).}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
}
\details{
A novel method to analyze how well a conditional density fits the underlying 
data is through the probability integral transformation (PIT) discussed in 
Rosenblatt (1952) and used in the \code{\link{BerkowitzTest}}. 
More recently, Hong and Li (2005) introduced a nonparametric portmanteau test, 
building on the work of Ait-Sahalia (1996), which tests the joint hypothesis of 
i.i.d and uniformity for a series of PIT transformed data. To achieve this, it 
tests for misspecification in the conditional moments of the model transformed 
standardized residuals, and is distributed as N(0, 1) under the Null of 
a correctly specified model. These moment tests are reported as \sQuote{M(1,1)} 
to \sQuote{M(4,4)} in the output, with \sQuote{M(1,2)} related to ARCH-in-mean
effects, and \sQuote{M(2,1)} to leverage, while \sQuote{W} is the Portmanteu type 
test statistic for general misspecification (using p lags) and also distributed 
as N(0, 1) under the Null of a correctly specified model. Only upper tail critical 
values are used in this test. The interested reader is referred to the paper 
for more details.
}
\value{
	A list with the following items:\cr
	\item{statistic}{ The individual moment and joint test statistics.}
	\item{Decision}{Whether to reject or not the Null given the conf.level.} 
}
\references{
Ait-Sahalia, Y. (1996), Testing continuous-time models of the spot interest 
rate, \emph{Review of Financial Studies}, \bold{9(2)}, 385--426.\cr
Berkowitz, J. (2001), Testing density forecasts, with applications to risk
management, \emph{Journal of Business and Economic Statistics}, \bold{19(4)}, 
465--474.\cr
Hong, Y., and Li, H.  (2005), Nonparametric specification testing for
continuous-time models with applications to term structure of interest
rates, \emph{Review of Financial Studies}, \bold{18(1)}, 37--84.\cr
Rosenblatt, M. (1952), Remarks on a multivariate transformation, \emph{The
Annals of Mathematical Statistics}, \bold{23(3)}, 470--472.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec(mean.model = list(armaOrder = c(1,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "sstd")
fit = ugarchfit(spec, data = dji30ret[, 1, drop = FALSE])
z = residuals(fit)/sigma(fit)
PIT = pdist("sstd",z, mu = 0, sigma = 1, skew = coef(fit)["skew"], 
shape=coef(fit)["shape"])
print(HLTest(PIT, lags=4))
}}