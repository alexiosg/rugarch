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
#ifndef FILTERS_H
#define FILTERS_H

void sgarchfilter(int *model, double *pars, int *idx, double *vexdata, double *e, int T, int i, double *h);

void gjrgarchfilter(int *model, double *pars, int *idx, double *vexdata, double *nres, double *e, int T, int i, double *h);

void aparchfilter(int *model, double *pars, int *idx, double *vexdata, double *res, int T, int i, double *h);

void egarchfilter(int *model, double *pars, int *idx, double meanz, double *z, double *vexdata, int T, int i, double *h);

void fgarchfilter(int *model, double *pars, int *idx, double kdelta, double *z, double *vexdata, int T, int i, double *h);

void csgarchfilter(int *model, double *pars, int *idx, double *vexdata, double *e, int T, int i, double *h, double *q);

void realgarchfilter(int *model, double *pars, int *idx, double *res, double *z, double *vexdata, int T, int i, double *h,
		double *r, double *tau, double *u);

void arfimaxfilter(int* model, double *pars, int *idx, double *x, double *res,
		double *mexdata, double *zrf, double *constm, double *condm, double h, int m, int i, int T);

void armaxsim(int *model, double *pars, int *idx, double *x, double *res, double *constm, int *m, int *T);

#endif /* FILTERS_H */
