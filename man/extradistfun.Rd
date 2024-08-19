\name{qnig}
\alias{qnig}
\alias{qgh}
\title{
Functions exported for use in rmgarch
}
\description{
Quantile for NIG and GH distributions in alpha, beta,
delta, mu and lambda parametrizations.
}
\usage{
qnig(p, alpha = 1, beta = 0, delta = 1, mu = 0)
qgh(p, alpha = 1, beta = 0, delta = 1, mu = 0, lambda = 1)
}
\arguments{
\item{p}{
Probabilities
}
\item{alpha}{
parameter in alpha, beta, delta, mu, lambda parametrization
of the gh distribution.
}
\item{beta}{
parameter in alpha, beta, delta, mu, lambda parametrization
of the gh distribution.
}
\item{delta}{
parameter in alpha, beta, delta, mu, lambda parametrization
of the gh distribution.
}
\item{mu}{
parameter in alpha, beta, delta, mu, lambda parametrization
of the gh distribution.
}
\item{lambda}{
parameter in alpha, beta, delta, mu, lambda parametrization
of the gh distribution.
}
}
\details{
For use internally by rmgarch.
}
\value{
A vector
}
\author{
Alexios Galanos
}
