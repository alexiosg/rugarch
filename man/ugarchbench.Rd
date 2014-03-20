\name{ugarchbench}
\alias{ugarchbench}
\title{
Benchmark: The Benchmark Test Suite
}
\description{
Function for running the rugarch benchmark suite.
}
\usage{
ugarchbench( benchmark = c("commercial", "published") )
}
\arguments{
\item{benchmark}{ The type of benchmark to run against (see details).}
}
\details{
Currently, 2 benchmark suites are available. The \dQuote{commercial} option runs
the standard GARCH, apARCH and gjrGARCH against a commercial based product and 
reports the results. The data for this bechmarks is \dQuote{AA} in the dji30ret 
dataset. The \dQuote{published} option is based on the published benchmark of 
Bollerslev and Ghysels for the standard and exponential GARCH models on the dmbp
data.
}
\source{
\sQuote{http://www.stanford.edu/~clint/bench/index.htm}
}
\references{
Brooks, C. 1997, GARCH Modelling in Finance: A review of the Software Options,
\emph{Economic Journal}, \bold{107(443)}, 1271--1276.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
ugarchbench( benchmark = "published" )
}
}
