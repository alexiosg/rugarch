\name{BerkowitzTest}
\alias{BerkowitzTest}
\title{
	Berkowitz Density Forecast Likelihood Ratio Test
}
\description{
	Implements the Berkowitz Density Forecast Likelihood Ratio Test.
}
\usage{
BerkowitzTest(data, lags = 1, significance = 0.05, tail.test = FALSE, alpha = 0.05)
}
\arguments{
	\item{data}{
		A univariate vector of standard normal transformed values (see details 
		and example).
	}
	\item{lags}{
		The number of autoregressive lags (positive and greater than 0).
	}
	\item{significance}{
		The level of significance at which the Null Hypothesis is evaluated.
	}
	\item{tail.test}{
		Whether to use the tail test of Berkowitz using a censored likelihood.
	}
	\item{alpha}{
		The quantile level for the tail.test cuttoff.
	}
}
\details{
	See not below.
}
\value{
	A list with the following items:\cr
	\item{uLL}{ The unconditional Log-Likelihood of the maximized values.}
	\item{rLL}{ The restricted Log-Likelihood with zero mean, unit variance and 
	zero coefficients in the autoregressive lags.}
	\item{LR }{The Likelihood Ratio Test Statistic.}
	\item{LRp}{The LR test statistic p-value (distributed chisq with 2+lags 
	d.o.f).}
	\item{H0 }{The Null Hypothesis.} 
	\item{Test }{ The test of the Null Hypothesis at the requested level of 
	significance.}
	\item{mu }{The estimated mean of the model.}
	\item{sigma }{The estimated sd of the model.}
	\item{rho }{The estimated autoregressive coefficients of the model (not 
	calculated when tail.test is used).}
	\item{JB}{ The Jarque-Bera Test of Normality Statistic (not calculated when 
	tail.test is used).}
	\item{JBp}{ The Jarque-Beta Test Statistic p-value (not calculated when 
	tail.test is used).}
}
\references{
Berkowitz, J. 2001, Testing density forecasts, with applications to risk 
management, \emph{Journal of Business and Economic Statistics}, 
\bold{19(4)}, 465--474.\cr
Dowd, K. 2004, A modified Berkowitz back-test, \emph{RISK Magazine}, 
\bold{17(4)}, 86--87.\cr
Jarque, C.M. and Bera, A.K. 1987, A test for normality of observations and 
regression residuals, \emph{International Statistical Review}, \bold{55(2)}, 
163--172.\cr
Rosenblatt, M. 1952, Remarks on a multivariate transformation, \emph{The Annals 
of Mathematical Statistics}, \bold{23(3)}, 470--472.
}
\author{Alexios Ghalanos}
\note{
The data must first be transformed before being submitted to the function as 
described here. Given a forecast density (d*) at time t, transform the 
actual(observed) realizations of the data by applying the distribution function 
of the forecast density (p*). This will result in a set of uniform values 
(see Rosenblatt (1952)). Transform those value into standard normal variates by 
applying the standard normal quantile function (qnorm). The example below 
hopefully clarifies this. The function also returns the Jarque Bera Normality 
Test statistic as an additional check of the normality assumption which the test 
does not explicitly account for (see Dowd reference). When tail.test is used, 
the test of the tail at the \dQuote{alpha} quantile level is performed using
a censored normal likelihood.
}
\examples{
\dontrun{
#  A univariate GARCH model is used with rolling out of sample forecasts.
data(dji30ret)
spec = ugarchspec(mean.model = list(armaOrder = c(6,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "nig")
fit = ugarchfit(spec, data = dji30ret[, 1, drop = FALSE], out.sample = 1000)
pred = ugarchforecast(fit, n.ahead = 1, n.roll = 999)
dmatrix = cbind(as.array(pred)[,2,],as.array(pred)[,1,], coef(fit)["skew"], 
coef(fit)["shape"])
colnames(dmatrix) = c("mu", "sigma", "skew", "shape")

# Get Realized (Oberved) Data
obsx = tail(dji30ret[,1], 1000)
# you can check that this is correct by looking at the dates of the first and 
# last predictions:
as.data.frame(pred, rollframe = 0)
head(tail(dji30ret[,1, drop = FALSE], 1000), 1)

as.data.frame(pred, rollframe = 999)
tail(dji30ret[,1, drop = FALSE], 1)

# Transform to Uniform
uvector = apply(cbind(obsx,dmatrix), 1, FUN = function(x) pdist("nig", q = x[1],
mu = x[2], sigma = x[3], skew = x[4], shape = x[5]))

# hist(uvector)
# transform to N(0,1)
nvector = qnorm(uvector)
test1 = BerkowitzTest(data = nvector, lags = 1, significance = 0.05)
test2 = BerkowitzTest(data = nvector, alpha = 0.05, significance = 0.05, 
tail.test=TRUE)
test3 = BerkowitzTest(data = nvector, alpha = 0.01, significance = 0.05, 
tail.test=TRUE)
}
}
