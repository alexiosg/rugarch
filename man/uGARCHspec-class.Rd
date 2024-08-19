\name{uGARCHspec-class}
\docType{class}
\alias{uGARCHspec-class}
\alias{uncmean,uGARCHspec-method}
\alias{uncvariance,uGARCHspec,missing,missing,missing,missing,missing-method}
\alias{setfixed<-}
\alias{setfixed<-,ANY,ANY-method}
\alias{setfixed<-,uGARCHspec,vector-method}
\alias{setstart<-}
\alias{setstart<-,ANY,ANY-method}
\alias{setstart<-,uGARCHspec,vector-method}
\alias{setbounds<-}
\alias{setbounds<-,ANY,ANY-method}
\alias{setbounds<-,uGARCHspec,vector-method}
\alias{halflife,uGARCHspec,missing,missing,missing,missing-method}
\alias{persistence,uGARCHspec,missing,missing,missing,missing-method}
\alias{show,uGARCHspec-method}
\title{class: Univariate GARCH Specification Class}
\description{Class for the univariate GARCH specification.}
\section{Extends}{
Class \code{"\linkS4class{GARCHspec}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHspec", distance 2.
}
\section{Slots}{
  \describe{
    \item{\code{model}:}{Object of class \code{"vector"}
     The model specification common to all objects.}
    }
}
\section{Methods}{
  \describe{
	\item{show}{\code{signature(object = "uGARCHspec")}: 
	Specification summary.}
	\item{setfixed<-}{\code{signature(object = "uGARCHspec", value = "vector")}: 
	Sets the fixed parameters (which must be supplied as a named list). }
	\item{setstart<-}{\code{signature(object = "uGARCHspec", value = "vector")}: 
	Sets the starting parameters (which must be supplied as a named list). }
	\item{setbounds<-}{\code{signature(object = "uGARCHspec", value = "vector")}: 
	Sets the parameters lower and upper bounds, which must be supplied as a named 
	list with each parameter being a numeric vector of length 2 i.e. 
	"alpha1"=c(0,1)). If the vector is of length 1, then this is assumed to be 
	the lower bound, and the upper bound will be set to its default value prior
	to estimation. Some of the parameters in the fGARCH model are not allowed to 
	take on custom bounds (since they determine the class of the model) nor the 
	beta parameter(s) in the iGARCH model.}
	\item{uncmean}{\code{signature(object = "uGARCHspec")}: 
	Unconditional mean of model for a specification with fixed.pars list.}
	\item{uncvariance}{\code{signature(object = "uGARCHspec")}: 
	Unconditional variance of model for a  specification with fixed.pars list.}
    \item{uncvariance}{\code{signature(object = "uGARCHspec", pars = "missing", 
    distribution = "missing", model = "missing", submodel = "missing", 
    vexdata = "missing")}:
	Calculates and returns the long run unconditional variance of the GARCH fit 
	given a \code{\linkS4class{uGARCHfit}} object.}
	\item{halflife}{\code{signature(object = "uGARCHspec", pars = "missing", 
	distribution = "missing", model = "missing")}: 
	Calculates and returns the halflife of the GARCH fit variance given a 
	\code{\linkS4class{uGARCHspec}} object with fixed parameters.}
	\item{persistence}{\code{signature(object = "uGARCHfit", pars = "missing", 
	distribution = "missing", model = "missing")}: 
	Calculates and returns the persistence of the GARCH fit model given a 
	\code{\linkS4class{uGARCHspec}} object with fixed parameters.}
	}
}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHfit}}, \code{\linkS4class{uGARCHsim}} and 
\code{\linkS4class{uGARCHforecast}}.
}
\examples{
# Basic GARCH(1,1) Spec
spec = ugarchspec()
spec
}
\keyword{classes}