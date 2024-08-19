\name{GMMTest}
\alias{GMMTest}
\title{
The GMM Orthogonality Test of Hansen
}
\description{
Implements the GMM Orthogonality Test of Hansen.

}
\usage{
GMMTest(z, lags = 1, skew=0, kurt=3, conf.level = 0.95)
}
\arguments{
\item{z}{
A numeric vector the standardized residuals.}
\item{lags}{
The number of lags to test for.}
\item{skew}{
The skewness of the standardized residuals (derived from the estimated model). 
This can be either a scalar or numeric vector the same size as z.}
\item{kurt}{
The kurtosis (not excess) of the standardized residuals (derived from the 
estimated model). This can be either a scalar or numeric vector the same size 
as z.}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
}
\details{
This is a mispecification test based on Hansen's GMM procedure. Under a correctly 
specified model, certain population moment conditions should be satisfied and 
hold in the sample using the standardized residuals. The moment conditions can 
be tested both individually using a t-test or jointly using a Wald test 
(the vignette gives more details). The test returns a matrix (moment.mat) 
containing the first 4 moments statistics, their standard errors and t-values 
(2-sided t-test with alternative hypothesis that the value is not equal to zero). 
The matrix of joint conditions (joint.mat) contains the t-values and critical 
values of \sQuote{Q2}, \sQuote{Q3} and \sQuote{Q4} representing the 
autocorrelation, given the chosen lags in the second, third and fourth moments 
and distributed as chi-squared with n.lag d.o.f, and the joint test (\sQuote{J}) 
for all moment conditions distributed chi-squared with 4+(n.lagx3) d.o.f.}
\value{
A list with the following items:\cr
\item{joint.mat}{ The matrix of the joint tests.}
\item{moment.mat}{ The matrix of the individual moment tests.}
\item{H0}{ The Null Hypothesis.}
\item{Decision}{Whether to reject or not the Null given the conf.level.}
}
\references{
Hansen, L. (1982), Large Sample Properties of Generalized Method of Moments 
Estimators, \emph{Econometrica}, \bold{50(4)}, 1029--1054.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec(mean.model = list(armaOrder = c(1,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "sstd")
fit = ugarchfit(spec, data = dji30ret[, 1, drop = FALSE])
z = residuals(fit)\/sigma(fit)
skew = dskewness("sstd",skew = coef(fit)["skew"], shape= coef(fit)["shape"])
# add back 3 since dkurtosis returns the excess kurtosis
kurt = 3+dkurtosis("sstd",skew = coef(fit)["skew"], shape= coef(fit)["shape"])
print(GMMTest(z, lags = 1, skew=skew, kurt=kurt))
}}