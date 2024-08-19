/*################################################################################
##
##   R package rugarch by Alexios Ghalanos Copyright (C) 2008-2015.
##   This file is part of the R package rugarch.
##
##   The R package rugarch is free software: you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
##
##   The R package rugarch is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
#################################################################################*/

#include "garchsim.h"
using namespace Rcpp;

SEXP marmaxsim(SEXP model, SEXP pars, SEXP idx, SEXP mu, SEXP x, SEXP res, SEXP N)
{
	try {
			Rcpp::NumericMatrix xx(x);
			Rcpp::NumericMatrix xres(res);
			Rcpp::NumericMatrix xmu(mu);
			int *xidx = INTEGER(idx);
			int *xmodel = INTEGER(model);
			double *xpars = REAL(pars);
			int *xN = INTEGER(N);
			int m = (int) xN[0];
			int n = (int) xN[1];
			int T = n + m;
			int nr = xx.nrow(), nc = xx.ncol(), i, j;
			arma::mat Qx(xx.begin(), nr, nc, true);
			arma::mat Qres(xres.begin(), nr, nc, true);
			arma::mat Qmu(xmu.begin(), nr, nc, true);

			for(i=m; i<T; i++)
			{
				Qx.row(i) = Qmu.row(i);
				for( j=0; j<xmodel[1]; j++ )
				{
					Qx.row(i) = Qx.row(i) + xpars[xidx[1]+j] * (Qx.row(i-(j+1)) - Qmu.row(i - (j+1)));
				}
				for( j=0; j<xmodel[2]; j++ )
				{
					Qx.row(i) = Qx.row(i) + xpars[xidx[2]+j] * Qres.row(i-(j+1));
				}
				Qx.row(i) = Qx.row(i) + Qres.row(i);
			}
			return Rcpp::List::create(Rcpp::Named("x") = Qx);
		} catch( std::exception &ex ) {
			forward_exception_to_r( ex );
	    } catch(...) {
			::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
	    }
	    return R_NilValue;
}

SEXP msgarchsim(SEXP model, SEXP pars, SEXP idx, SEXP h, SEXP z, SEXP res,
		SEXP e, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xe(e);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qe(xe.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);

		for( i=m; i<nr; i++ )
		{
			Qh.row(i) = Qh.row(i) + xpars[xidx[6]];
			Qh.row(i) = Qh.row(i) + Qvxs.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j]*Qe.row(i-(j+1));
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*Qh.row(i-(j+1));
			}
			Qres.row(i) = arma::pow( Qh.row(i), 0.5 ) % Qz.row(i);
			Qe.row(i) = Qres.row(i) % Qres.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}


SEXP mgjrgarchsim(SEXP model, SEXP pars, SEXP idx, SEXP h, SEXP z, SEXP res, SEXP e,
		SEXP nres, SEXP nindx, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xe(e);
		Rcpp::NumericMatrix xnres(nres);
		Rcpp::NumericMatrix xneg(nindx);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qe(xe.begin(), nr, nc, false);
		arma::mat Qnres(xnres.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);
		arma::mat Qneg(xneg.begin(), nr, nc, false);

		for( i=m; i<nr; i++ )
		{
			Qh.row(i) = Qh.row(i) + xpars[xidx[6]];
			Qh.row(i) = Qh.row(i) + Qvxs.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j]*Qe.row(i-(j+1)) + xpars[xidx[9]+j]*Qnres.row(i-(j+1));
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*Qh.row(i-(j+1));
			}
			Qres.row(i) = arma::pow( Qh.row(i), 0.5 ) % Qz.row(i);
			Qe.row(i) = Qres.row(i) % Qres.row(i);
			Qnres.row(i) = Qneg.row(i) % Qe.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}

SEXP maparchsim(SEXP model, SEXP pars, SEXP idx, SEXP h, SEXP z, SEXP res, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);

		for( i=m; i<nr; i++ )
		{
			Qh.row(i) = Qh.row(i) + xpars[xidx[6]];
			Qh.row(i) = Qh.row(i) + Qvxs.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j]*arma::pow(arma::abs(Qres.row(i-(j+1))) - xpars[xidx[9]+j]*Qres.row(i-(j+1)), xpars[xidx[12]]);
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*arma::pow(Qh.row(i-(j+1)), xpars[xidx[12]]);
			}
			Qh.row(i) = arma::pow(Qh.row(i), 1/xpars[xidx[12]]);
			Qres.row(i) = Qh.row(i) % Qz.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}

SEXP mfgarchsim(SEXP model, SEXP pars, SEXP idx, SEXP kdelta, SEXP h, SEXP z,
		SEXP res, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);

		double *qkdelta  = REAL(kdelta);
		double cnst = 0.001 * 0.001;

		for( i=m; i<nr; i++ )
		{
			Qh.row(i) = Qh.row(i) + xpars[xidx[6]];
			Qh.row(i) = Qh.row(i) + Qvxs.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j] * ( arma::pow(arma::pow(cnst + arma::pow( Qz.row(i-(j+1)) - xpars[xidx[11]+j],2), 0.5) - xpars[xidx[10]+j] *(Qz.row(i-(j+1)) - xpars[xidx[11]+j]), qkdelta[0] ) % arma::pow( Qh.row(i-(j+1)), xpars[xidx[13]]) );
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*arma::pow(Qh.row(i-(j+1)), xpars[xidx[13]]);
			}
			Qh.row(i) = arma::pow(Qh.row(i), 1/xpars[xidx[13]]);
			Qres.row(i) = Qh.row(i) % Qz.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}

SEXP megarchsim(SEXP model, SEXP pars, SEXP idx, SEXP meanz, SEXP h, SEXP z,
		SEXP res, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);
		double *qmeanz = REAL(meanz);

		for( i=m; i<nr; i++ )
		{
			Qh.row(i) = Qh.row(i) + xpars[xidx[6]];
			Qh.row(i) = Qh.row(i) + Qvxs.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j]*Qz.row(i-(j+1)) + xpars[xidx[9]+j]*(arma::abs(Qz.row(i-(j+1))) - qmeanz[0]);
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*arma::log(Qh.row(i-(j+1)));
			}
			Qh.row(i) = arma::exp( Qh.row(i) );
			Qres.row(i) = arma::pow( Qh.row(i), 0.5 ) % Qz.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}

SEXP mcsgarchsim(SEXP model, SEXP pars, SEXP idx, SEXP h, SEXP q, SEXP z, SEXP res,
		SEXP e, SEXP vxs, SEXP N)
{
	try {
		Rcpp::NumericMatrix xh(h);
		Rcpp::NumericMatrix xq(q);
		Rcpp::NumericMatrix xz(z);
		Rcpp::NumericMatrix xres(res);
		Rcpp::NumericMatrix xe(e);
		Rcpp::NumericMatrix xvxs(vxs);

		int *xidx = INTEGER(idx);
		double *xpars = REAL(pars);
		int *xmodel = INTEGER(model);
		int *xN = INTEGER(N);
		int m = (int) xN[0];
		int nr = xh.nrow(), nc = xh.ncol(), i, j;

		arma::mat Qh(xh.begin(), nr, nc, false);
		arma::mat Qq(xq.begin(), nr, nc, false);
		arma::mat Qz(xz.begin(), nr, nc, false);
		arma::mat Qres(xres.begin(), nr, nc, false);
		arma::mat Qe(xe.begin(), nr, nc, false);
		arma::mat Qvxs(xvxs.begin(), nr, nc, false);

		for( i=m; i<nr; i++ )
		{
			Qq.row(i) = xpars[xidx[6]] + Qvxs.row(i) + xpars[xidx[10]]*Qq.row(i-1) + xpars[xidx[11]]*(Qe.row(i-1) - Qh.row(i-1));
			Qh.row(i) = Qh.row(i) + Qq.row(i);
			for( j=0; j<xmodel[7]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[7]+j]*(Qe.row(i-(j+1)) - Qq.row(i-(j+1)));
			}
			for( j=0; j<xmodel[8]; j++ )
			{
				Qh.row(i) = Qh.row(i) + xpars[xidx[8]+j]*(Qh.row(i-(j+1)) - Qq.row(i-(j+1)));
			}
			Qres.row(i) = arma::pow( Qh.row(i), 0.5 ) % Qz.row(i);
			Qe.row(i) = Qres.row(i) % Qres.row(i);
		}
		return Rcpp::List::create(Rcpp::Named("h") = Qh, Rcpp::Named("res") = Qres, Rcpp::Named("q") = Qq);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
    } catch(...) {
		::Rf_error( "rugarch-->ugarchsim c++ exception (unknown reason)" );
    }
    return R_NilValue;
}

SEXP colMaxRcpp(SEXP X_){
	Rcpp::NumericMatrix X(X_);
	int n = X.ncol();
	Rcpp::NumericVector V(n);
	for (int i=0; i<n; i++) {
	Rcpp::NumericVector W = X.column(i);
	V[i] = *std::max_element(W.begin(), W.end());
	}
	return(V);
}
