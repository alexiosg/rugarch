\name{VaRloss}
\alias{VaRloss}
\title{
	Value at Risk loss function of Gonzalez-Rivera, Lee, and Mishra (2004)
}
\description{
Returns the VaR loss function described in  Gonzalez-Rivera, Lee, and 
Mishra (2004) which is an appropriate function on which to compare models using
such methods as the Model Confidence Set (MCS).
}
\usage{
VaRloss(alpha, actual, VaR)
}
\arguments{
\item{alpha}{
The quantile (coverage) used for the VaR.}
\item{actual}{
A numeric vector of the actual (realized) values.}
\item{VaR}{
The numeric vector of VaR.}
}
\author{Alexios Ghalanos}
\references{
Gonzalez-Rivera, G., Lee, T. H., and Mishra, S. 2004, Forecasting volatility: 
A reality check based on option pricing, utility function, value-at-risk, 
and predictive likelihood. \emph{International Journal of Forecasting}, 
\bold{20(4)}, 629--645.
}
