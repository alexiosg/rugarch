\name{dmbp}
\docType{data}
\alias{dmbp}
\title{data: Deutschemark/British pound Exchange Rate}
\description{
The Bollerslev-Ghysel benchmark dataset. The variables in the data set are: \cr
\code{1.} The daily percentage nominal returns computed as 100 [ln(Pt) - ln(Pt-1)], 
where Pt is the bilateral Deutschemark/British pound rate constructed from the 
corresponding U.S. dollar rates.\cr
\code{2.} A dummy variable that takes the value of 1 on Mondays and other days 
following no trading in the Deutschemark or British pound/ U.S. dollar market 
during regular European trading hours and 0 otherwise.\cr
}
\usage{data(dmbp)}
\format{A data.frame containing 2x1974 observations.}
\references{
Bollerslev, T. and Ghysels, E. 1996, Periodic Autoregressive Conditional 
Heteroscedasticity , \emph{Journal of Business and Economic Statistics}, \bold{14},
139--151.}
\keyword{datasets}
