\name{arfimacv}
\alias{arfimacv}
\title{
	ARFIMAX time series cross validation
}
\description{
	Implements a cross validation method for ARFIMAX models
}
\usage{
arfimacv(data, indexin, indexout, ar.max = 2, ma.max = 2, 
criterion = c("rmse","mae","berkowitzp"),berkowitz.significance = 0.05, 
arfima = FALSE, include.mean = NULL, distribution.model = "norm",
cluster = NULL, external.regressors = NULL, solver = "solnp", 
solver.control=list(), fit.control=list(), return.best=TRUE)
}
\arguments{
	\item{data}{
		A univariate xts vector.
	}
	\item{indexin}{
		A list of the training set indices
	}
	\item{indexout}{
		A list of the testing set indices, the same list length as that of indexin. This should be a numeric index
		of points immediately after those in the equivalent indexin slot and contiguous (for time series cross validation).
	}
	\item{ar.max}{
	Maximum AR order to test for.}
	\item{ma.max}{
	Maximum MA order to test for.}
	\item{criterion}{
	The cv criterion on which the forecasts will be tested against the realized values. Currently \dQuote{rmse},
	\dQuote{mae} and experimentally \dQuote{berkowitzp} are implemented. The latter is the Berkowitz test p-value
	(maximized) and should not be used if your indexout set is very small.
	}
	\item{berkowitz.significance}{
	The significance level at which the Berkowitz test is evaluated at (this has no value at the moment since
	we are only looking at the p-values, but may be used in futures to instead aggregate across pass-fail).
	}
	\item{arfima}{
	Can be TRUE, FALSE or NULL in which case it is tested.}
	\item{include.mean}{
	Can be TRUE, FALSE or NULL in which case it is tested.}
	\item{cluster}{
	A cluster object created by calling \code{makeCluster} from the parallel 
	package. If it is not NULL, then this will be used for parallel estimation.
	}
	\item{external.regressors}{An xts matrix object containing the pre-lagged external regressors to 
	 include in the mean equation with the same indices as those of the data supplied.}
	\item{distribution.model}{
	The distribution density to use for the innovations (defaults to Normal).}
	\item{solver}{One of either \dQuote{nlminb}, \dQuote{solnp}, \dQuote{gosolnp}
	or \dQuote{nloptr}.}
	\item{solver.control}{Control arguments list passed to optimizer.}
	\item{fit.control}{Control arguments passed to the fitting routine.}
	\item{return.best}{
	On completion of the cross-validation, should the best model be re-estimated on the complete dataset
	and returned (defaults to TRUE).
	}
}
\details{
	The function evaluates all possible combinations of the ARFIMAX model for all the training and testing
	sets supplied. For the ARMA orders, the orders are evaluated fully (e.g. for ar.max=2, all possible combinations
	are evaluated including AR(0,0), AR(0,1), AR(0,2), AR(1,0), AR(2,0) AR(1,2), AR(2,1), and AR(2,2)). For each training
	set in indexin, all model combinations are evaluated and the 1-ahead rolling forecast for the indexout testing set 
	is produced and compared to the realized values under the 3 criteria listed. Once all training/testing is done on all
	model combinations, the criteria are averaged across all the sets for each combination and the results returned.
}
\value{
	A list with the following items:\cr
	\item{bestmodel}{ The best model based on the criterion chosen is re-estimated on the complete data set and returned.}
	\item{cv_matrix}{ The model combinations and their average criteria statistics across the training/testing sets.}
}
\author{Alexios Ghalanos}
\note{
Use a cluster...this is an expensive computation, particularly for large ar.max and ma.max orders. The indexin and indexout
lists are left to the user to decide how to implement.
}
\examples{
\dontrun{
require(xts)
require(parallel)
data(sp500ret)
spx = as.xts(sp500ret)
nn = nrow(spx)
nx = nn-round(0.9*nn,0)
if(nx%%50!=0) nx = nx+(50-nx%%50)
h = (nx/50)-1
indexin = lapply(1:h, function(j){ tail(seq(1,(nn-nx)+j*50, by=1),250) })
indexout = lapply(indexin, function(x){ (tail(x,1)+1):(tail(x,1)+50) })
cl = makePSOCKcluster(5)
mod = arfimacv(spx, indexin, indexout, ar.max = 2, ma.max = 2, 
criterion = c("rmse","mae","berkowitzp")[1],
berkowitz.significance = 0.05, arfima = FALSE, include.mean = NULL, 
distribution.model = "norm", cluster = cl, external.regressors = NULL, 
solver = "solnp")
stopCluster(cl)
}
}
