\name{uGARCHfit-class}
\docType{class}
\alias{uGARCHfit-class}
\alias{residuals,uGARCHfit-method}
\alias{fitted,uGARCHfit-method}
\alias{vcov,uGARCHfit-method}
\alias{coef,uGARCHfit-method}
\alias{confinterval,uGARCHfit-method}
\alias{confinterval,ANY-method}
\alias{confinterval}
\alias{infocriteria,uGARCHfit-method}
\alias{infocriteria,ANY-method}
\alias{infocriteria}
\alias{nyblom,uGARCHfit-method}
\alias{nyblom,ANY-method}
\alias{nyblom}
\alias{getspec,uGARCHfit-method}
\alias{getspec,ANY-method}
\alias{getspec}
\alias{signbias,uGARCHfit-method}
\alias{signbias,ANY-method}
\alias{signbias-methods}
\alias{signbias}
\alias{sigma,uGARCHfit-method}
\alias{sigma,ANY-method}
\alias{sigma}
\alias{gof,ANY,ANY-method}
\alias{gof,uGARCHfit,numeric-method}
\alias{gof}
\alias{quantile,uGARCHfit-method}
\alias{pit,uGARCHfit-method}
\alias{pit,ANY-method}
\alias{pit}
\alias{likelihood,uGARCHfit-method}
\alias{likelihood,ANY-method}
\alias{likelihood}
\alias{newsimpact,ANY-method}
\alias{newsimpact,uGARCHfit-method}
\alias{newsimpact}
\alias{halflife,ANY,ANY,ANY,ANY,ANY-method}
\alias{halflife,missing,numeric,character,character,ANY-method}
\alias{halflife,uGARCHfit,missing,missing,missing,missing-method}
\alias{halflife}
\alias{persistence,ANY,ANY,ANY,ANY,ANY-method}
\alias{persistence,missing,numeric,character,character,ANY-method}
\alias{persistence,uGARCHfit,missing,missing,missing,missing-method}
\alias{persistence}
\alias{uncvariance,ANY,ANY,ANY,ANY,ANY,ANY-method}
\alias{uncvariance,missing,numeric,character,character,ANY,ANY-method}
\alias{uncvariance,uGARCHfit,missing,missing,missing,missing,missing-method}
\alias{uncvariance}
\alias{uncmean,uGARCHfit-method}
\alias{uncmean,ANY-method}
\alias{uncmean}
\alias{convergence,uGARCHfit-method}
\alias{convergence,ANY-method}
\alias{convergence}
\alias{reduce,uGARCHfit-method}
\alias{reduce,ANY-method}
\alias{reduce}
\alias{plot,uGARCHfit,missing-method}
\alias{show,uGARCHfit-method}
\title{class: Univariate GARCH Fit Class}
\description{Class for the univariate GARCH fit.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Extends}{
Class \code{\linkS4class{GARCHfit}}, directly.
Class \code{\linkS4class{rGARCH}}, by class \code{\linkS4class{GARCHfit}}, distance 2.
}
\section{Slots}{
  \describe{
    \item{\code{fit}:}{Object of class \code{"vector"}
    Holds data on the fitted model.}
    \item{\code{model}:}{Object of class \code{"vector"}
    The model specification common to all objects.}
  }
}
\section{Methods}{
\describe{
\item{coef}{\code{signature(object = "uGARCHfit")}: 
Extracts the coefficients. }
\item{cofinterval}{\code{signature(object = "uGARCHfit")}: 
Similar to the stats S3 method \code{\link{confint}}, extracts coefficient 
confidence intervals taking additional optional arguments \code{parm} and 
\code{level}, as well as \code{robust} (default: FALSE) indicating whether
to use the robust covariance matrix for the calculations.}
\item{vcov}{\code{signature(object = "uGARCHfit")}: 
Extracts the covariance matrix of the parameters. Additional logical option of 
\sQuote{robust} indicates whether to extract the robust based covariance matrix. }
\item{infocriteria}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns various information criteria. }
\item{nyblom}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns the Hansen-Nyblom stability test (1990). }
\item{gof}{\code{signature(object = "uGARCHfit", groups = "numeric")}: 
Calculates and returns the adjusted goodness of fit statistic and p-values 
for the fitted distribution based on the Vlaar and Palm paper (1993). Groups is 
a numeric vector of bin sizes.}
\item{newsimpact}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns the news impact curve.}
\item{signbias}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns the sign bias test of Engle and Ng (1993). }
\item{likelihood}{\code{signature(object = "uGARCHfit")}: 
Extracts the likelihood. }
\item{sigma}{\code{signature(object = "uGARCHfit")}: 
Extracts the conditional sigma values.}
\item{fitted}{\code{signature(object = "uGARCHfit")}: 
Extracts the fitted values.}
\item{residuals}{\code{signature(object = "uGARCHfit")}: 
Extracts the residuals. Optional logical argument \code{standardize} 
(default is FALSE) allows to extract the standardized residuals.}
\item{getspec}{\code{signature(object = "uGARCHfit")}: 
Extracts and returns the GARCH specification from a fit object.}
\item{uncvariance}{\code{signature(object = "uGARCHfit", pars = "missing", 
distribution="missing", model = "missing", vexdata = "missing")}: 
Calculates and returns the long run unconditional variance of the GARCH fit 
given a \code{\linkS4class{uGARCHfit}} object.}
\item{uncvariance}{\code{signature(object = "missing", pars = "numeric", 
distribution = "character", model = "character", submodel = "ANY", 
vexdata = "ANY")}: 
Calculates and returns the long run unconditional variance of the GARCH fit 
given a named parameter vector as returned by the fit, a distribution model 
name and a GARCH model name with a submodel included if the model is of the 
nested type such as fGARCH and any external regressor data.}
\item{uncmean}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns the unconditional mean of the conditional mean equation 
(constant, ARMAX, arch-in-mean). }
\item{persistence}{\code{signature(object = "uGARCHfit", pars = "missing", 
distribution = "missing", model = "missing")}: 
Calculates and returns the persistence of the GARCH fit model given a 
\code{\linkS4class{uGARCHfit}} object.}
\item{persistence}{\code{signature(object = "missing", pars = "numeric", 
distribution = "character", model = "character")}: 
Calculates and returns the persistence of the GARCH fit model given a named 
parameter vector as returned by the fit, a distribution model name and a 
GARCH model name with a submodel included if the model is of the nested type 
such as fGARCH.}
\item{halflife}{\code{signature(object = "uGARCHfit", pars = "missing", 
distribution = "missing", model = "missing")}: 
Calculates and returns the halflife of the GARCH fit variance given a 
\code{\linkS4class{uGARCHfit}} object.}
\item{halflife}{\code{signature(object = "missing", pars = "numeric", 
distribution = "character", model = "character")}: 
Calculates and returns the halflife of the GARCH fit variance given a named 
parameter vector as returned by the fit, a distribution model name and a 
GARCH model name with a submodel included if the model is of the nested 
type such as fGARCH.}
\item{convergence}{\code{signature(object = "uGARCHfit")}: 
Returns the solver convergence code for the fitted object (zero denotes
convergence). }
\item{quantile}{\code{signature(x = "uGARCHfit")}: 
Calculates and returns, given a vector of probabilities (additional argument 
\dQuote{probs}), the conditional quantiles of the fitted object (x).}
\item{pit}{\code{signature(object = "uGARCHfit")}: 
Calculates and returns the conditional probability integral transform given the
data and estimated density.}
\item{reduce}{\code{signature(object = "uGARCHfit")}: 
Zeros parameters (fixing to zero in rugarch is equivalent to eliminating them 
in estimation) with p-values (optional argument \dQuote{pvalue}) greater 
than 0.1 (default), and re-estimates the model. Additional arguments are passed
to \code{\link{ugarchfit}}.}
\item{plot}{\code{signature(x = "uGARCHfit", y = "missing")}: 
Fit plots. }
\item{show}{\code{signature(object = "uGARCHfit")}: 
Fit summary. }
}
}
\author{Alexios Ghalanos}
\note{
Methods for coef, likelihood, fitted, sigma and residuals provide extractor 
functions for those values.\cr
Method for show gives detailed summary of GARCH fit with various tests.\cr
Method for plot provides for interactive choice of plots, option of choosing
a particular plot (option \dQuote{which} equal to a valid plot number) or a 
grand plot including all subplots on one page (option \dQuote{which}=\dQuote{all}).\cr
The infocriteria method calculates and returns the information criteria 
(AIC, BIC etc) of the GARCH fit.\cr
The nyblom method calculates and returns the Hansen-Nyblom joint and individual 
coefficient stability test statistic and critical values.\cr
The gof methods calculates and returns the adjusted goodness of fit statistic 
and p-values for the fitted distribution. The groups parameter is a numeric
vector of grouped bin sizes for the test. See the references in the package 
introduction for the original paper by Vlaar and Palm explaining the test.\cr
The signbias methods calculates and returns the sign bias test of Engle and Ng 
(see the references in the package introduction).\cr
Methods for calculating and extracting persistence, unconditional variance and
half-life of the GARCH shocks exist and take either the GARCH fit object as a 
single value otherwise you may provide a named parameter vector (see 
\code{\linkS4class{uGARCHspec}} section for parameter names of the various GARCH 
models), a distribution name and the GARCH model (with submodel argument for the 
fGARCH model).\cr
Unconditional mean and variance of the model may be extracted by means of the
uncmean and uncvariance methods. The uncvariance may take either a fit object or
a named parameter list, distribution and GARCH model name. The uncmean will only
take a fit object due to the complexity of the calculation requiring much more
information than the uncoditional variance.\cr
The news impact method returns a list with the calculated values (zx, zy) and 
the expression (xexpr, yexpr) which can be used to illustrate the plot.}
\seealso{
Classes \code{\linkS4class{uGARCHforecast}}, \code{\linkS4class{uGARCHsim}} and 
\code{\linkS4class{uGARCHspec}}.
}
\examples{
\dontrun{
# Basic GARCH(1,1) Spec
data(dmbp)
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec)
fit
# object fit:
slotNames(fit)
# sublist fit@fit
names(fit@fit)
coef(fit)
infocriteria(fit)
likelihood(fit)
nyblom(fit)
signbias(fit)
head(sigma(fit))
head(residuals(fit))
head(fitted(fit))
gof(fit,c(20,30,40,50))
uncmean(fit)
uncvariance(fit)
#plot(fit,which="all")
# news impact example
spec = ugarchspec(variance.model=list(model="apARCH"))
fit = ugarchfit(data = dmbp[,1], spec = spec)
# note that newsimpact does not require the residuals (z) as it
# will discover the relevant range to plot against by using the min/max
# of the fitted residuals.
ni=newsimpact(z = NULL, fit)
#plot(ni$zx, ni$zy, ylab=ni$yexpr, xlab=ni$xexpr, type="l", main = "News Impact Curve")
}}
\keyword{classes}