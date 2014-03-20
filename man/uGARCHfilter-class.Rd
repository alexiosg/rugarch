\name{uGARCHfilter-class}
\docType{class}
\alias{uGARCHfilter-class}
\alias{coef,uGARCHfilter-method}
\alias{fitted,uGARCHfilter-method}
\alias{likelihood,uGARCHfilter-method}
\alias{infocriteria,uGARCHfilter-method}
\alias{newsimpact,uGARCHfilter-method}
\alias{signbias,uGARCHfilter-method}
\alias{gof,uGARCHfilter,numeric-method}
\alias{persistence,uGARCHfilter,missing,missing,missing,missing-method}
\alias{halflife,uGARCHfilter,missing,missing,missing,missing-method}
\alias{plot,uGARCHfilter,missing-method}
\alias{residuals,uGARCHfilter-method}
\alias{sigma,uGARCHfilter-method}
\alias{uncmean,uGARCHfilter-method}
\alias{quantile,uGARCHfilter-method}
\alias{pit,uGARCHfilter-method}
\alias{uncvariance,uGARCHfilter,missing,missing,missing,missing,missing-method}
\alias{show,uGARCHfilter-method}
\title{class: Univariate GARCH Filter Class}
\description{Class for the univariate GARCH filter.}
\section{Extends}{
Class \code{"\linkS4class{GARCHfilter}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHfilter", distance 2.
}
\section{Methods}{
 \describe{
\item{fitted}{\code{signature(object = "uGARCHfilter")}: 
	Extracts the fitted values.}
\item{residuals}{\code{signature(object = "uGARCHfilter")}: 
	Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
\item{sigma}{\code{signature(object = "uGARCHfilter")}:
	Extracts the conditional sigma values.}
\item{coef}{\code{signature(object = "uGARCHfilter")}:
	Extracts the coefficients.}
\item{infocriteria}{\code{signature(object = "uGARCHfilter")}: 
	Calculates and returns various information criteria. }
\item{newsimpact}{\code{signature(object = "uGARCHfilter")}:
	Calculates and returns the news impact curve.}
\item{likelihood}{\code{signature(object = "uGARCHfilter")}:
	Extracts the likelihood.}
\item{signbias}{\code{signature(object = "uGARCHfilter")}: 
	Calculates and returns the sign bias test of Engle and Ng (1993). }
\item{gof}{\code{signature(object = "uGARCHfilter", groups = "numeric")}: 
	Calculates and returns the adjusted goodness of fit statistic and p-values 
	for the fitted distribution based on the Vlaar and Palm paper (1993). 
	Groups is a numeric vector of bin sizes.}
\item{persistence}{\code{signature(object = "uGARCHfilter", pars = "missing", 
distribution = "missing", model = "missing", submodel = "missing")}: 
	Calculates and returns the persistence of the garch filter model.}
\item{halflife}{\code{signature(object = "uGARCHfilter", pars = "missing", 
distribution = "missing", model = "missing")}: 
	Calculates and returns the halflife of the garch fit variance given a 
	\code{\linkS4class{uGARCHfilter}} object.}
\item{uncmean}{\code{signature(object = "uGARCHfilter")}:
	Calculates and returns the unconditional mean of the conditional mean 
	equation (constant, ARMAX, arch-in-mean). }
\item{uncvariance}{\code{signature(object = "uGARCHfilter", pars = "missing", 
	distribution = "missing", model = "missing", submodel = "missing")}: 
	Calculates and  returns the long run unconditional variance of the garch 
	filter given a \code{\linkS4class{uGARCHfilter}} object.}
\item{quantile}{\code{signature(x = "uGARCHfilter")}: 
	Calculates and returns, given a vector of probabilities (additional argument 
	\dQuote{probs}), the conditional quantiles of the filtered object (x).}
\item{pit}{\code{signature(object = "uGARCHfilter")}: 
Calculates and returns the conditional probability integral transform given the
data and estimated density.}
\item{plot}{\code{signature(x = "uGARCHfilter", y = "missing")}:
	Filter plots}
\item{show}{\code{signature(object = "uGARCHfilter")}: 
	Filter summary.}
}}
\author{Alexios Ghalanos}
\note{The \code{\linkS4class{uGARCHfilter}} class contains almost all the methods 
available with the \code{\linkS4class{uGARCHfit}} with the exception of those 
requiring the scores of the likelihood (i.e the optimization process) such as 
the nyblom test.
}
\examples{
\dontrun{
data(dji30ret)
ctrl = list(rho = 1, delta = 1e-8, outer.iter = 100, inner.iter = 650, 
tol = 1e-6)
spec = ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), 
		mean.model = list(armaOrder = c(1,1), include.mean = TRUE), 
		distribution.model = "std")
sgarch.fit = ugarchfit(data = dji30ret[,"AA",drop=FALSE], spec = spec, 
		solver = "solnp", solver.control = ctrl)
		
spec = ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)), 
		mean.model = list(armaOrder = c(1,1), include.mean = TRUE), 
		distribution.model = "std", fixed.pars = as.list(coef(sgarch.fit)))
sgarch.filter = ugarchfilter(data = dji30ret[,"AA",drop=FALSE], spec = spec)

c(likelihood(sgarch.filter), likelihood(sgarch.fit))
c(uncmean(sgarch.filter), uncmean(sgarch.fit))
c(uncvariance(sgarch.filter), uncvariance(sgarch.fit))
}}
\keyword{classes}