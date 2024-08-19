\name{multispec-methods}
\docType{methods}
\alias{multispec}
\alias{multispec-methods}
\alias{multispec,ANY-method}
\alias{multispec,vector-method}
\title{function: Univariate multiple GARCH Specification}
\description{
Method for creating a univariate multiple GARCH or ARFIMA specification object 
prior to fitting.
}
\usage{
multispec( speclist )
}
\arguments{
\item{speclist}{
A list with as many univariate GARCH or ARFIMA specifications of class 
\code{\linkS4class{uGARCHspec}} and \code{\linkS4class{ARFIMAspec}}  as there 
will be columns in the data object passed to one of the other methods which uses 
a multiple specification object (fitting, filtering and forecasting).}
}
\value{
A \code{\linkS4class{uGARCHmultispec}} or \code{\linkS4class{ARFIMAmultispec}} 
object containing details of the multiple GARCH or ARFIMA specifications.
}
\author{Alexios Ghalanos}
\examples{
# how to make a list with 2 uGARCHspec objects of the same type
spec = ugarchspec()
mspec = multispec( replicate(2, spec) )
# note that replicate(spec, 2) does not work...be careful about the order 
# else explicity name 'n' (i.e. n = 2)

# or simply combine disparate objects
spec1 = ugarchspec(distribution = "norm")
spec2 = ugarchspec(distribution = "std")
mspec = multispec( c( spec1, spec2 ) )
}
\keyword{methods}