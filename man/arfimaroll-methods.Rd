\name{arfimaroll-methods}
\docType{methods}
\alias{arfimaroll-methods}
\alias{arfimaroll,ANY-method}
\alias{arfimaroll,ARFIMAspec-method}
\alias{arfimaroll}
\title{function: ARFIMA Rolling Density Forecast and Backtesting}
\description{
Method for creating rolling density forecast from ARFIMA models with option
for refitting every n periods with parallel functionality.}
\usage{
arfimaroll(spec, data, n.ahead = 1, forecast.length = 500, 
n.start = NULL, refit.every = 25, refit.window = c("recursive", "moving"), 
window.size = NULL, solver = "hybrid", fit.control = list(), 
solver.control = list(), calculate.VaR = TRUE, VaR.alpha = c(0.01, 0.05), 
cluster = NULL, keep.coef = TRUE, ...)
}
\arguments{
\item{spec}{
A univariate ARFIMA specification object.}
\item{data}{
A univariate dataset, ideally with time based index.
}
\item{n.ahead}{
The number of periods to forecast (only n.ahead=1 supported).
}
\item{forecast.length}{
The length of the total forecast for which out of sample data 
from the dataset will be used for testing.
}
\item{n.start}{
Instead of forecast.length, this determines the starting point in the dataset
from which to initialize the rolling forecast.
}
\item{refit.every}{
Determines every how many periods the model is re-estimated.
}
\item{refit.window}{
Whether the refit is done on an expanding window including all the previous data 
or a moving window where all previous data is used for the first estimation 
and then moved by a length equal to refit.every (unless the window.size option 
is used instead).
}
\item{window.size}{
If not NULL, determines the size of the moving window in the rolling estimation,
which also determines the first point used.
}
\item{solver}{
The solver to use.
}
\item{fit.control}{
Control parameters parameters passed to the fitting function.
}
\item{solver.control}{
Control parameters passed to the solver.
}
\item{calculate.VaR}{
Whether to calculate forecast Value at Risk during the estimation.
}
\item{VaR.alpha}{
The Value at Risk tail level to calculate.
}
\item{cluster}{
A cluster object created by calling \code{makeCluster} from the parallel 
package. If it is not NULL, then this will be used for parallel estimation
of the refits (remember to stop the cluster on completion).
}
\item{keep.coef}{
Whether to return the list of coefficients and their robust standard errors.
}
\item{...}{ . }
}
\details{
This is a wrapper function for creating rolling forecasts of the conditional
ARFIMA density, and optionally calculating the Value at Risk at specified levels.
The argument \code{refit.every} determines every how many periods the model is
re-estimated. Given a dataset of length N, it is possible to choose either
how many periods from the end to use for out of sample forecasting (using the
forecast.length option), or the starting point for initializing the rolling
forecast (and using all the data after that for the out of sample forecast).
Only rolling 1-ahead forecasts are supported spanning the dataset, which should
be useful for backtesting models. Anything more complicated should be wrapped by 
the user by making use of the underlying functions in the package.
The function has 2 main methods for viewing the data, a standard plot method and
a report methods (see class \code{\linkS4class{ARFIMAroll}} for details on 
how to use these methods).
In case of no-convergence in some of all the windows, a new method called 
\code{\link{resume}} now allows to pass the returned (non-converged) object with
new solver and control parameters to be re-estimated (only the non-converged
windows are re-estimated).
Parallel functionality is now based entirely on the parallel package, and it is
up to the user to pass a cluster object, and then stop it once the routine is
completed.
}
\value{
An object of class \code{\linkS4class{ARFIMAroll}}.
}
\author{Alexios Ghalanos}
\examples{
\dontrun{
data(sp500ret)
spec = arfimaspec(distribution.model = "std")
mod = arfimaroll(spec, data = sp500ret, n.ahead = 1, 
n.start = 1000,  refit.every = 100, refit.window = "moving", 
solver = "hybrid", fit.control = list(),
calculate.VaR = TRUE, VaR.alpha = c(0.01, 0.025, 0.05),
keep.coef = TRUE)
report(sp500.bktest, type="VaR", VaR.alpha = 0.01, conf.level = 0.95) 
report(sp500.bktest, type="fpm")
}}
\keyword{methods}
