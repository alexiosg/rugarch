\name{uGARCHmultifilter-class}
\docType{class}
\alias{uGARCHmultifilter-class}
\alias{coef,uGARCHmultifilter-method}
\alias{fitted,uGARCHmultifilter-method}
\alias{likelihood,uGARCHmultifilter-method}
\alias{residuals,uGARCHmultifilter-method}
\alias{sigma,uGARCHmultifilter-method}
\alias{show,uGARCHmultifilter-method}
\title{class: Univariate GARCH Multiple Filter Class}
\description{Class for the univariate GARCH Multiple filter.}
\section{Extends}{
Class \code{"\linkS4class{GARCHfilter}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "GARCHfilter", distance 3.
}
\section{Methods}{
  \describe{
    \item{fitted}{\code{signature(object = "uGARCHmultifilter")}:
    Extracts the fitted values.}
    \item{residuals}{\code{signature(object = "uGARCHmultifilter")}: 
    Extracts the residuals. Optional logical argument \code{standardize} 
	(default is FALSE) allows to extract the standardized residuals.}
    \item{sigma}{\code{signature(object = "uGARCHmultifilter")}:
    Extracts the conditional sigma values.}
    \item{coef}{\code{signature(object = "uGARCHmultifilter")}:
    Extracts the coefficients.}
    \item{likelihood}{\code{signature(object = "uGARCHmultifilter")}:
    Extracts the likelihood. }
    \item{show}{\code{signature(object = "uGARCHmultifilter")}: 
    Filter summary. }
	}
}
\author{Alexios Ghalanos}
\seealso{
Classes \code{\linkS4class{uGARCHmultiforecast}}, \code{\linkS4class{uGARCHmultifit}} 
and \code{\linkS4class{uGARCHmultispec}}.
}
\keyword{classes}