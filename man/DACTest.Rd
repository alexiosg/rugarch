\name{DACTest}
\alias{DACTest}
\title{
  Directional Accuracy Test
}
\description{
Implements the Directional Accuracy Test of Pesaran and Timmerman and Excess 
Profitability Test of Anatolyev and Gerko. 
}
\usage{
DACTest(forecast, actual, test = c("PT", "AG"), conf.level = 0.95)
}
\arguments{
\item{forecast}{
A numeric vector of the forecasted values.}
\item{actual}{
A numeric vector of the actual (realized) values.}
\item{test}{
Choice of Pesaran and Timmermann (\sQuote{PT}) or Anatolyev and Gerko (\sQuote{AG}) 
tests.}
\item{conf.level}{
The confidence level at which the Null Hypothesis is evaluated.}
}
\details{
See the references for details on the tests. The Null is effectively that of 
independence, and distributed as N(0,1).
}
\value{
	A list with the following items:\cr
	\item{Test}{ The type of test performed.}
	\item{Stat}{ The test statistic.}
	\item{p-value}{The p-value of the test statistic.}
	\item{H0}{The Null Hypothesis.}
	\item{Decision}{Whether to reject or not the Null given the conf.level.} 
	\item{DirAcc}{ The directional accuracy of the forecast.}
}
\references{
Anatolyev, S. and Gerko, A. 2005, A trading approach to testing for 
predictability, \emph{Journal of Business and Economic Statistics}, \bold{23(4)}, 
455--461.\cr
Pesaran, M.H. and Timmermann, A. 1992, A simple nonparametric test of predictive 
performance, \emph{Journal of Business and Economic Statistics}, 
\bold{10(4)}, 461--465.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(dji30ret)
spec = ugarchspec(mean.model = list(armaOrder = c(6,1), include.mean = TRUE),
variance.model = list(model = "gjrGARCH"), distribution.model = "nig")
fit = ugarchfit(spec, data = dji30ret[, 1, drop = FALSE], out.sample = 1000)
pred = ugarchforecast(fit, n.ahead = 1, n.roll = 999)
# Get Realized (Oberved) Data
obsx = tail(dji30ret[,1], 1000)
forc = as.numeric(as.data.frame(pred,rollframe="all",align=FALSE,which="series"))
print(DACTest(forc, obsx, test = "PT", conf.level = 0.95))
print(DACTest(forc, obsx, test = "AG", conf.level = 0.95))
}}
