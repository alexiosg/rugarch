\name{uGARCHdistribution-class}
\docType{class}
\alias{uGARCHdistribution-class}
\alias{as.data.frame,uGARCHdistribution-method}
\alias{plot,uGARCHdistribution,missing-method}
\alias{show,uGARCHdistribution-method}
\title{class: Univariate GARCH Parameter Distribution Class}
\description{Class for the univariate GARCH Parameter Distribution.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{"\linkS4class{GARCHdistribution}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHdistribution", distance 2.
}
\section{Methods}{
\describe{
\item{as.data.frame}{\code{signature(x = "uGARCHdistribution")}: 
Extracts various values from object (see note).}
\item{plot}{\code{signature(x = "uGARCHdistribution", y = "missing")}: 
Parameter Distribution Plots. }
\item{show}{\code{signature(object = "uGARCHdistribution")}: 
Parameter Distribution Summary. }
}
}
\note{
The \code{as.data.frame} function takes optionally 2 additional arguments, 
namely \code{window} which indicates the particular distribution window number 
for which data is required (is usually just 1 unless the recursive option was 
used), and \code{which} indicating the type of data required. Valid values for 
the latter are \dQuote{rmse} for the root mean squared error between simulation 
fit and actual parameters, \dQuote{stats} for various statistics computed for 
the simulations such as log likelihood, persistence, unconditional variance and 
mean, \dQuote{coef} for the estimated coefficients (i.e. the parameter 
distribution and is the default choice), and \dQuote{coefse} for the estimated 
robust standard errors of the coefficients (i.e. the parameter standard error 
distribution).\cr
The plot method offers 4 plot types, namely, Parameter Density Plots (take 
\code{window} as additional argument), Bivariate Plots (take \code{window} as 
additional argument), Stats and RMSE (only when recursive option used) Plots.
The standard option for \code{which} is used, allowing for a numeric arguments 
to one of the four plot types else interactive choice via \dQuote{ask}.}
\seealso{
Classes \code{\linkS4class{uGARCHforecast}}, \code{\linkS4class{uGARCHfit}} and 
\code{\linkS4class{uGARCHspec}}.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(sp500ret)
spec = ugarchspec(variance.model=list(model="gjrGARCH", garchOrder=c(1,1)), 
		mean.model=list(armaOrder=c(1,1), arfima=FALSE, include.mean=TRUE, 
		archm = FALSE, archpow = 1), distribution.model="std")
		
fit = ugarchfit(data=sp500ret[, 1, drop = FALSE], out.sample = 0, 
				spec = spec, solver = "solnp")
	
dist = ugarchdistribution(fit, n.sim = 2000, n.start = 50, m.sim = 5)
}}
\keyword{classes}
