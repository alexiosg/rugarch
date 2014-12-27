/*################################################################################
##
##   R package rugarch by Alexios Ghalanos Copyright (C) 2008-2014.
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
