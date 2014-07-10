/*################################################################################
##
##   R package rugarch by Alexios Ghalanos Copyright (C) 2008-2013.
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
# include <R.h>
# include <math.h>
# include "filters.h"

void sgarchfilter(int *model, double *pars, int *idx, double *vexdata, double *e, int T, int i, double *h)
{
	int j, ind;
	h[i] = h[i] + pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i] = h[i] + pars[idx[7]+j]*e[i-(j+1)];
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i] = h[i] + pars[idx[8]+j]*h[i-(j+1)];
	}
}

void gjrgarchfilter(int *model, double *pars, int *idx, double *vexdata, double *nres, double *e, int T, int i, double *h)
{
	int j, ind;
	h[i] = h[i] + pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i] = h[i] + pars[idx[7]+j]*e[i-(j+1)]+pars[idx[9]+j]*nres[i-(j+1)];
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i] = h[i] + pars[idx[8]+j]*h[i-(j+1)];
	}
}

void aparchfilter(int *model, double *pars, int *idx, double *vexdata, double *res, int T, int i, double *h)
{
	int j, ind;
	h[i] = h[i] + pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i]+= pars[idx[7]+j]*pow(fabs(res[i-(j+1)])-pars[idx[9]+j]*res[i-(j+1)], pars[idx[12]]);
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i]+= pars[idx[8]+j]*pow( h[i-(j+1)], pars[idx[12]] );
	}
	h[i] = pow( h[i], 1.0/pars[idx[12]] );
}

void egarchfilter(int *model, double *pars, int *idx, double meanz, double *z, double *vexdata, int T, int i, double *h)
{
	// lower bounds of variance to protect against special case
	double lbeh = h[0]/10000;
	int j, ind;
	h[i] = h[i] +  pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i] = h[i] + pars[idx[7]+j]*z[i-(j+1)] + pars[idx[9]+j]*( fabs(z[i-(j+1)]) - meanz );
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i] = h[i] +  pars[idx[8]+j]*log( h[i-(j+1)] );
	}

	h[i] = exp( h[i] );
	if(h[i]<=lbeh){
		h[i]=lbeh;
	}
	if(h[i]>=1E20){
		h[i] = 1E20;
	}
}

void fgarchfilter(int *model, double *pars, int *idx, double kdelta, double *z, double *vexdata, int T, int i, double *h)
{
	int j, ind;
	h[i] = h[i] +  pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i]= h[i] + pars[idx[7]+j] * ( pow(sqrt(pow(0.001,2) + pow( z[i-(j+1)] - pars[idx[11]+j],2) )- pars[idx[10]+j] *(z[i-(j+1)] - pars[idx[11]+j]), kdelta ) * pow( h[i-(j+1)], pars[idx[13]]) );
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i]= h[i] + pars[idx[8]+j] * pow( h[i-(j+1)], pars[idx[13]] );
	}
	h[i] = pow( h[i], 1/pars[idx[13]] );
}

void csgarchfilter(int *model, double *pars, int *idx, double *e, double *vexdata, int T, int i, double *h, double *q)
{
	int j, ind;
	q[i] = pars[idx[6]] + pars[idx[10]]*q[i-1] + pars[idx[11]]*(e[i-1] - h[i-1]);
	// External Regressors are added to the Permanent Component
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			q[i] = q[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	h[i] = h[i] + q[i];
	for( j=0; j<model[7]; j++ )
	{
		h[i] = h[i] + pars[idx[7]+j]*(e[i-(j+1)] - q[i-(j+1)]);
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i] = h[i] + pars[idx[8]+j]*(h[i-(j+1)] - q[i-(j+1)]);
	}
}

void realgarchfilter(int *model, double *pars, int *idx, double *res, double *z, double *vexdata, int T, int i, double *h, double *r,
		double *tau, double *u)
{
	int j, ind;
	h[i] = h[i] +  pars[idx[6]];
	if( model[14]>0 )
	{
		for( j=0; j<model[14]; j++ )
		{
			ind = i + ( T * j );
			h[i] = h[i] + pars[idx[14]+j]*vexdata[ind];
		}
	}
	for( j=0; j<model[7]; j++ )
	{
		h[i] = h[i] + pars[idx[7]+j]*log(r[i-(j+1)]);
	}
	for( j=0; j<model[8]; j++ )
	{
		h[i] = h[i] + pars[idx[8]+j]*log(h[i-(j+1)]);
	}
	h[i] = exp(h[i]);
	z[i] = res[i]/sqrt(h[i]);
	tau[i] = pars[idx[10]]*z[i] +  pars[idx[11]]*(z[i]*z[i]-1);
	u[i] = log(r[i])-pars[idx[18]] - pars[idx[12]]*log(h[i]) - tau[i];
}

void arfimaxfilter(int* model, double *pars, int *idx, double *x, double *res,
		double *mexdata, double *zrf, double *constm, double *condm, double h,
		int m, int i, int T)
{
/* --------------------------------------------------------------------------------
 * ARFIMA Process :
 * (1-L)^(-darfima).e[t] = phi(1-L)(y[t] - mu[t]) - psi(L).e[t]
 * where mu[t] includes constant, external and arch-in-mean
 * L is the lag operator
 * --------------------------------------------------------------------------------
 * */
	/*0 constm, 1 condm, 2 res*/
	int j, k, ind;
	constm[i] = pars[0];
	// GARCH-In-Mean Initialization (h is always the sigma, not sigma^2 so that h^model[4] is correct)
	if(model[4]>0)
	{
		constm[i]+=pars[idx[4]]*pow(h, model[4]);
	}
	// Exogenous Regressor Initialization
	if(model[5]>0)
	{
		if(model[19]==0){
			for(k=0;k<model[5];k++)
			{
				ind=i+(T*k);
				constm[i]+=pars[idx[5]+k]*mexdata[ind];
			}
		} else{
			if(model[19] == model[5]){
				for(k=0;k<model[5];k++)
				{
					ind=i+(T*k);
					constm[i]+=pars[idx[5]+k]*(mexdata[ind]*h);
				}
			} else{
				int tmpi = model[5]-model[19];
				for(k=0;k<tmpi;k++)
				{
					ind=i+(T*k);
					constm[i]+=pars[idx[5]+k]*mexdata[ind];
				}
				for(k=tmpi;k<model[5];k++)
				{
					ind=i+(T*k);
					constm[i]+=pars[idx[5]+k]*(mexdata[ind]*h);
				}
			}
		}
	}
	condm[i]+=constm[i];
	//ARMA initialization
	if(model[1]>0 || model[2]>0)
	{
		if(i>=model[1])
		{
			if(model[1]>0)
			{
				for(j=0; j<model[1];j++)
				{
					condm[i]+=pars[idx[1]+j]*(x[i-(j+1)]-constm[i-(j+1)]);
				}
			}
			if(model[2]>0)
			{
				for(j=0; j<model[2];j++)
				{
					if(i-j-1>=0)
					{
						condm[i]+=pars[idx[2]+j]*(x[i-(j+1)]-condm[i-(j+1)]);
					}
				}
			}
		}
	}
	res[i]=x[i]-condm[i];
	//arfima initialization
	if(model[3]>0)
	{
		if(i>0 && i<m)
		{
			double tmp=0;
			for(k=1;k<=i;k++)
			{
				tmp+=(zrf[i-k+1]*res[k-1]) ;
			}
			res[i]=-1.0 * tmp;
		}
		if(i>0 && i>=m)
		{
			double tmp=0;
			for(k=i;k>0;k--)
			{
				// quicker to count down
				tmp+=zrf[k]*(x[i-k] - condm[i-k]) ;
			}
			res[i]+= tmp;
		}
	}
}

/* We are passing (1-sum(ar))*mu in constm (this is not the case in fracsim).
 * r[t] = (1-ar)*mu[t] + ar*(r[t-1]) + ma*(res[t-1]) + res[t]
 * r[t] - mu[t]  = ar*(r[t-1]-mu[t]) + ma*(res[t-1]) + res[t]
 * */
void armaxsim(int *model, double *pars, int *idx, double *x, double *res, double *constm, int *m, int *T)
{
	int j, i;
	for(i=*m; i<*T; i++)
	{
		x[i] = constm[i];
		for( j=0; j<model[1]; j++ )
		{
			x[i]+= pars[idx[1]+j] * (x[i-(j+1)] - constm[i-(j+1)]);
		}
		for ( j=0; j<model[2]; j++ )
		{
			x[i]+= pars[idx[2]+j] * res[i-(j+1)];
		}
		x[i]+= res[i];
	}
}
