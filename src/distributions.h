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
#ifndef DISTRIBUTIONS_H
#define DISTRIBUTIONS_H
/*
 * -----------------------------------------
 * Key Functions
 * -----------------------------------------
 */
double dnormstd(const double );
double signum(const double );
double dhuge(void);
double Heaviside(const double , const double );
double depsilon(void);
double kappagh(const double , const double );
double deltakappagh(const double , const double );
double* paramgh(const double , const double , const double );
double* paramghskt(const double , const double );
/*
 * -----------------------------------------
 * GH Skew Student Distribution
 * -----------------------------------------
 */
double dghsktstd(const double , const double , const double );
void c_dghst(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int* logr);
double rsghst(const double , const double );
void c_rghst(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans);
/*
 * -----------------------------------------
 * GH Distribution
 * -----------------------------------------
 */
double dgh(const double , const double , const double , const double , const double , const double);
void c_dgh(double *x, double *alpha, double *beta, double *delta, double *mu, double *lambda, double *ans, int *n, int *logr);
double dghstd(const double , const double , const double , const double);
void c_dghyp(double *x, double *mu, double *sigma, double *skew, double *shape, double *lambda, double *ans, int *n, int *logr);
double rghyp(const double , const double , const double );
void c_rghyp(int *n, double *mu, double *sigma, double *skew, double *shape, double *lambda, double *ans);
/*
 * -----------------------------------------
 * NIG Distribution
 * -----------------------------------------
 */
double dnig(const double , const double , const double  , const double , const double);
double dnigstd(const double , const double , const double);
void c_dsnig(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr);
double rsnig(const double , const double );
double rnig(const double , const double , const double , const double );
void c_rsnig(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans);
/*
 * -----------------------------------------
 * Student Distribution
 * -----------------------------------------
 */
double rstd(const double );
void c_rstd(int *n, double *mu, double *sigma, double *shape, double *ans);
double xdt(const double , const double );
double dstdstd(const double , const double );
void c_dstd(double *x, double *mu, double *sigma, double *shape, double *ans, int *n, int *logr);
double pstd(const double , const double , const double , const double );
void c_pstd(double *q, double *mu, double *sigma, double *shape, double *ans, int *n);
double qstd(const double , const double , const double , const double );
void c_qstd(double *p, double *mu, double *sigma, double *shape, double *ans, int *n);
/*
 * -----------------------------------------
 * Skew Student Distribution (Fernandez & Steel)
 * -----------------------------------------
 */
double rsstd(const double , const double );
void c_rsstd(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans);
double dsstdstd(const double , const double , const double );
void c_dsstd(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr);
double psstd(const double , const double , const double , const double , const double );
void c_psstd(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
double qsstd(const double , const double , const double );
void c_qsstd(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
/*
 * -----------------------------------------
 * Johnson's SU Distribution
 * -----------------------------------------
 */
double djsustd(const double , const double , const double );
void c_djsu(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr);
double qjsu(const double , const double , const double );
void c_qjsu(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
double rjsu(const double n, const double );
void c_rjsu(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans);
double pjsu(const double , const double , const double , const double , const double );
void c_pjsu(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
/*
 * -----------------------------------------
 * Skew Normal Distribution
 * -----------------------------------------
 */
double rsnorm(const double );
void c_rsnorm(int *n, double *mu, double *sigma, double *skew, double *ans);
double dsnormstd(const double , const double );
void c_dsnorm(double *x, double *mu, double *sigma, double *skew, double *ans, int *n, int *logr);
double psnorm(const double , const double , const double , const double );
void c_psnorm(double *q, double *mu, double *sigma, double *skew, double *ans, int *n);
double qsnorm(const double , const double );
void c_qsnorm(double *p, double *mu, double *sigma, double *skew, double *ans, int *n);
/*
 * -----------------------------------------
 * Generalized Error Distribution
 * -----------------------------------------
 */
double rged(const double );
void c_rged(int *n, double *mu, double *sigma, double *shape, double *ans);
double dgedstd(const double , const double );
void c_dged(double *x, double *mu, double *sigma, double *shape, double *ans, int *n, int *logr);
double pged(const double , const double , const double , const double );
void c_pged(double *q, double *mu, double *sigma, double *shape, double *ans, int *n);
double qged(const double , const double );
void c_qged(double *p, double *mu, double *sigma, double *shape, double *ans, int *n);
/*
 * -----------------------------------------
 * Skew Generalized Error Distribution (Fernandez & Steel)
 * -----------------------------------------
 */
double rsged(const double , const double );
void c_rsged(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans);
double dsgedstd(const double , const double , const double );
void c_dsged(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr);
double psged(const double , const double , const double , const double , const double );
void c_psged(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
double qsged(const double , const double, const double );
void c_qsged(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n);
/*
 * -----------------------------------------
 * Hypebolic Distribution
 * -----------------------------------------
 */
double dhyp(const double , const double , const double , const double , const double);
double dhypstd(const double ,  const double , const double);
void c_dhyp(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr);
/*
 * -----------------------------------------
 * GARCH routine calling functions
 * -----------------------------------------
 */
double garchdistribution(const double , const double , const double , const double , const double , const int );
double rgarchdist(const double , const double , const double , const int );
double pgarchdist(const double , const double , const double , const double , const double , const double , const int );
double svfun(const double , const double , const double , const double , const double , const double , const double ,
		const double , const int );
#endif /* DISTRIBUTIONS_H */
