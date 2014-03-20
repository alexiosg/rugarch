\name{ARFIMAspec-class}
\docType{class}
\alias{ARFIMAspec-class}
\alias{show,ARFIMAspec-method}
\alias{setfixed<-,ARFIMAspec,vector-method}
\alias{setstart<-,ARFIMAspec,vector-method}
\alias{setbounds<-,ARFIMAspec,vector-method}
\alias{uncmean,ARFIMAspec-method}
\title{class: ARFIMA Specification Class}
\description{
Class for the ARFIMA specification.
}
\section{Slots}{
  \describe{
    \item{\code{model}:}{Object of class \code{"vector"} }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ARFIMA}"}, directly.
Class \code{"\linkS4class{rGARCH}"}, by class "ARFIMA", distance 2.
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "ARFIMAspec")}: 
    Specification summary.}
    \item{setfixed<-}{\code{signature(object = "ARFIMAspec", 
    value = "vector")}: 
    Sets the fixed parameters (which must be supplied as a named list). }
    \item{setstart<-}{\code{signature(object = "ARFIMAspec", 
    value = "vector")}: 
    Sets the starting parameters (which must be supplied as a named list). }
    \item{setbounds<-}{\code{signature(object = "ARFIMAspec", value = "vector")}: 
	Sets the parameters lower and upper bounds, which must be supplied as a named 
	list with each parameter being a numeric vector of length 2 i.e. 
	"ar1"=c(-1,1)). If the vector is of length 1, then this is assumed to be 
	the lower bound, and the upper bound will be set to its default value prior
	to estimation.}
    \item{uncmean}{\code{signature(object = "ARFIMAspec")}: 
    Returns the unconditional mean of a specification which has been assigned 
    fixed parameters.}
    }
}
\author{Alexios Ghalanos}
\keyword{classes}
