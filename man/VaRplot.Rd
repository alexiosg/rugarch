\name{VaRplot}
\alias{VaRplot}
\title{
	Value at Risk Exceedances plot
}
\description{
Plot the VaR at a given coverage rate against the realized returns for the same
period, highlighting the exceedances.
}
\usage{
VaRplot(alpha, actual, VaR, title = paste("Daily Returns and Value-at-Risk 
Exceedances\n","(alpha=", alpha,")",sep=""), ylab = "Daily Log Returns", 
xlab = "Time")
}
\arguments{
\item{alpha}{
The quantile (coverage) used for the VaR.}
\item{actual}{
An xts object of the realized returns.}
\item{VaR}{
An xts object of the forecast VaR, at the given coverage rate p, with the same 
index as the actual.}
\item{title}{Plot title.}
\item{xlab}{Plot x-axis label.}
\item{ylab}{Plot y-axis label.}
}
\author{Alexios Ghalanos}