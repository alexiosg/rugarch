\name{ghyptransform}
\alias{ghyptransform}
\title{Distribution: Generalized Hyperbolic Transformation and Scaling}
\description{
The function scales the distributions from the (0, 1) zeta-rho GARCH 
parametrization to the alpha-beta parametrization and performs the appropriate
scaling to the parameters given the estimated sigma and mu.
}
\usage{
ghyptransform(mu = 0, sigma = 1,  skew = 0, shape = 3, lambda = -0.5)
}
\arguments{
\item{mu}{
Either the conditional time-varying (vector) or unconditional mean estimated 
from the GARCH process.}
\item{sigma}{
The conditional time-varying (vector) sigma estimated from the GARCH process.}
\item{skew, shape, lambda}{
The conditional non-time varying skewness (rho) and shape (zeta) parameters 
estimated from the GARCH process (zeta-rho), and the GHYP lambda parameter 
(\sQuote{dlambda} in the estimation).}
}
\value{
A matrix of size nrows(sigma) x 4 of the scaled and transformed parameters to be
used in the alpha-beta parametrized GHYP distribution functions.
}
\details{
The GHYP transformation is taken from Rmetrics internal function and scaled as 
in Blaesild (see references).
}
\references{
Blaesild, P. 1981, The two-dimensional hyperbolic distribution and related 
distributions, with an application to Johannsen's bean data, \emph{Biometrika},
\bold{68}, 251--263.\cr
Eberlein, E. and Prauss, K. 2000, The Generalized Hyperbolic Model Financial 
Derivatives and Risk Measures, \emph{Mathematical Finance Bachelier Congress},
245--267.
}
\author{
Diethelm Wuertz for the Rmetrics \R-port of the nig transformation function.\cr
Alexios Ghalanos for rugarch implementation.\cr
}