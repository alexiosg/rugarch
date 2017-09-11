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
#ifndef RUGARCH_H
#define RUGARCH_H

void arfimafitC(int *model, double *pars, int *idx, double *x, double *res,
		double *mexdata, double *zrf, double *constm, double *condm, int *m, int *T,
		double *z, double *llh, double *LHT);

void arfimaxfilterC(int *model, double *pars, int *idx, double *x, double *res, double *mexdata,
		double *zrf, double *constm, double *condm, double *h, int *m, int *T);

void sgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *x, double *res,
		double *e, double *mexdata, double *vexdata, double *zrf, double *constm, double *condm,
		int *m, int *T, double *h, double *z, double *llh, double *LHT);

void sgarchsimC(int *model, double *pars, int *idx, double *h, double *z, double *res, double *e,
		double *vexdata, int *T, int *m);

void figarchfilterC(int *model, double *pars, int *idx, double *hEst, double *x, double *res,
                    double *e, double *ebar, double *eps, double *be, double *mexdata, double *vexdata,
                    double *zrf, double *constm, double *condm, int *m, int *T, int *N,
                    double *h, double *z, double *llh, double *LHT);

void aparchfilterC(int *model, double *pars, int *idx, double *hEst, double *x, double *res, double *e,
		double *mexdata, double *vexdata, double *zrf, double *constm, double *condm,
		int *m, int *T, double *h, double *z, double *llh, double *LHT);

void aparchsimC(int *model, double *pars, int *idx, double *h, double *z, double *res, double *vexdata,
		int *T, int *m);

void egarchfilterC(int *model, double *pars, int *idx, double *hEst, double *meanz,
		double *x, double *res, double *e, double *mexdata, double *vexdata, double *zrf,
		double *constm, double *condm, int *m, int *T, double *h, double *z, double *llh, double *LHT);

void egarchsimC(int *model, double *pars, int *idx, double *meanz, double *h, double *z, double *res,
		double *vexdata, int *T, int *m);

void fgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *kdelta, double *x,
		double *res,double *e, double *mexdata, double *vexdata, double *zrf, double *constm,
		double *condm, int *m, int *T, double *h, double *z, double *llh, double *LHT);

void fgarchsimC(int *model, double *pars, int *idx, double *kdelta, double *h, double *z, double *res,
		double *vexdata, int *T, int *m);

void gjrgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *x,
		double *res, double *nres, double *e, double *mexdata, double *vexdata, double *zrf,
		double *constm, double *condm, int *m, int *T, double *h, double *z, double *llh, double *LHT);

void gjrgarchsimC(int *model, double *pars, int *idx, double *h, double *z, double *res, double *e, double *nres,
		double *vexdata, int *T, int *m);

void csgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *x, double *res,
		double *e, double *mexdata, double *vexdata, double *zrf, double *constm, double *condm,
		int *m, int *T, double *h, double *q, double *z, double *llh, double *LHT);

void csgarchsimC(int *model, double *pars, int *idx, double *h, double *q, double *z, double *res, double *e,
		double *vexdata, int *T, int *m);

void mcsgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *res, double *e,
		double *s, double *v, double *vexdata, int *m, int *T, double *h, double *z, double *llh, double *LHT);

void mcsgarchsimC(int *model, double *pars, int *idx, double *h, double *z, double *eres, double *e,
		double *vexdata, int *T, int *m);

void realgarchfilterC(int *model, double *pars, int *idx, double *hEst, double *x, double *res,
		double *mexdata, double *vexdata, double *zrf, double *constm, double *condm,
		int *m, int *T, double *h, double *z, double *tau, double *r, double *u, double *llh,
		double *LHT1P, double *LHT);

void realgarchsimC(int *model, double *pars, int *idx, double *res, double *vexdata, int *m,
		int *T, double *h, double *z, double *tau, double *r, double *u);
#endif /* RUGARCH_H */
