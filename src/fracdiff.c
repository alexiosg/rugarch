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
#include <R.h>
#include <math.h>
#include "fracdiff.h"

void fracdiff(int *n, double *d, double *p, double *x, double *ydiff)
{
	int i,j;
	for(i=1;i<*n;i++)
	{
		p[i]=p[i-1]*(i-*d)/(i+1);
	}
	for(i=1;i<*n;i++)
	{
		ydiff[i]=x[i];
		for(j=0;j<i;j++)
		{
			ydiff[i] = ydiff[i]+p[j]*x[i-j-1];
		}

	}

}

void c_binexpansion(int *n, double *d, double *ans)
{
  int i;
  ans[0]=1.0;
  for(i=1;i<*n;i++){
    ans[i]=(i-1-*d)/i*ans[i-1];
  }
}

void c_figarchcons(double *alpha1, double *delta, double *beta1, double *g, double *psi, int* truncLag)
{
  int j,k;
  double b;
  if(*beta1>0){
    if(*alpha1<=((1.0-*delta)/2.0)){
      k=1;
    } else{
      k = (int) ceil((1+*delta)/(1-*alpha1));
    }
    psi[0]=*delta+*alpha1-*beta1;
    if(k>1){
      for(j=2;j<k;j++){
        psi[0]=*beta1*psi[0]+((j-1-*delta)/j-*alpha1)*(g[j-1]);
      }
    }
  } else{
    for(j=3;j<=*truncLag;j++){
     b=*beta1*((j-2-*delta)/(j-1)-*alpha1)+((j-1-*delta)/j-*alpha1)*(j-2-*delta)/(j-1);
      if(b>=0){
        k=j;
        break;
      }
    }
    psi[0]=*delta+*alpha1-*beta1;
    psi[1]=*beta1*psi[0]+((2-1-*delta)/2-*alpha1)*(*delta);
    for(j=3;j<k;j++){
      psi[0]=psi[1];
      psi[1]=*beta1*psi[0]+((j-1-*delta)/j-*alpha1)*(-1.0*g[j-1]);
    }
  }
}

