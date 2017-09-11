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
# include "distributions.h"
# include <R.h>
# include <limits.h>
# include "gig.h"
# include "nig.h"
# include <math.h>
# include <Rmath.h>

/*
 * -----------------------------------------
 * Key Functions
 * -----------------------------------------
 */
double dnormstd(const double x)
{
  double pdf;
  pdf = exp ( -0.5 * x * x ) / sqrt ( 2.0 * PI );
  if(pdf == 0.0) pdf = 0.0 + 2.22507e-24;
  return pdf;
}
double signum(const double x)
{
	double res=-(x<0)+(x>0);
	return  res;
}
double dhuge(void)
{
  return HUGE_VAL;
}
double heaviside(const double x, const double a){
	return( (signum(x-a) + 1.0)/2.0 );
}

double depsilon(void)
{
  double r;
  r = 1.0;
  while( 1.0 < (double)(1.0 + r)){
	r = r / 2.0;
  }
  return (2.0 * r);
}
double kappagh(const double x, const double lambda)
{
	double kappa=0;
	if(lambda == -0.5){
	kappa = 1/x;
	} else{
	kappa = (bessel_k(x, lambda+1, 2) / bessel_k(x, lambda, 2)) / x;
	}
	return kappa;
}
double deltakappagh(const double x, const double lambda)
{
	double deltakappa=0;
	if(lambda == -0.5){
		deltakappa = kappagh(x, lambda+1) - kappagh(x, lambda);
	} else{
		deltakappa = kappagh(x, lambda+1) - kappagh(x, lambda);
	}
	return deltakappa;
}
double* paramgh(const double rho, const double zeta, const double lambda)
{
	double *param = malloc(4*sizeof(double));
	double rho2 = 1 - pow(rho,2);
	double alpha = pow(zeta,2) * kappagh(zeta, lambda)/rho2;
	alpha = alpha * ( 1 + pow(rho,2) * pow(zeta,2) * deltakappagh(zeta, lambda)/rho2);
	alpha = sqrt(alpha);
	double beta = alpha * rho;
	double delta = zeta / ( alpha * sqrt(rho2) );
	double mu = -beta * pow(delta,2) * kappagh(zeta, lambda);
	param[0]=(double) alpha;
	param[1]=(double) beta;
	param[2]=(double) delta;
	param[3]=(double) mu;
	return param;
}
double* paramghskt(const double betabar, const double nu)
{
	double *param = malloc(4*sizeof(double));
	double delta = sqrt(1/( ((2 * betabar*betabar)/((nu-2)*(nu-2)*(nu-4))) + (1/(nu-2)) ));
	double beta = betabar/delta;
	double mu = -( (beta * (delta*delta))/(nu-2));
	param[0]=(double) nu;
	param[1]=(double) beta;
	param[2]=(double) delta;
	param[3]=(double) mu;
	return param;
}

/*
 * -----------------------------------------
 * GH Skew Student Distribution
 * -----------------------------------------
 */
double dghsktstd(const double x, const double betabar, const double nu)
{
	double *param;
	param = paramghskt(betabar, nu);
	double beta = param[1];
	double delta = param[2];
	double mu = param[3];
	double pdf = ((1 - nu)/2) * log(2) + nu * log(delta) + ((nu + 1)/2) * log(fabs(beta))
	+ log(bessel_k(sqrt(beta*beta * (delta*delta + (x - mu)*(x - mu))), (nu + 1)/2, 2)) - sqrt(beta*beta * (delta*delta
	+ (x - mu)*(x - mu))) + beta * (x - mu) - lgammafn(nu/2) - log(PI)/2 - ((nu + 1)/2) * log(delta*delta + (x - mu)*(x - mu))/2;
	free(param);
	pdf = exp(pdf);
	return pdf;
}

void c_dghst(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int* logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dghsktstd( (x[i]-mu[i])/sigma[i], skew[i], shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double rsghst(const double betabar, const double nu)
{
	// Note: for values of nu<5 it is likely that sd(r) will have a very large variance
	// Existence of moment conditions (vs lower parameter bounds) are defined in the paper.
	double *param;
	param = paramghskt(betabar, nu);
	double beta = param[1];
	double delta = param[2];
	double mu = param[3];
	double y = 1.0/rgamma(nu/2.0, 2.0/(delta*delta));
	double sigma = sqrt(y);
	double z = rnorm(0,1);
	double ans =  mu + beta * sigma*sigma + sigma * z;
	free(param);
	return ans;
}

void c_rghst(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans)
{
	GetRNGstate();
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rsghst(skew[i], shape[i])*sigma[i];
	}
	PutRNGstate();
}

/*
 * -----------------------------------------
 * GH Distribution
 * -----------------------------------------
 */
double dgh(const double x, const double alpha, const double beta, const double delta, const double mu, const double lambda)
{
	double pdf=0;
	if(alpha<=0){
		return pdf=0;
	}
	if(delta <= 0){
		return pdf=0;
	}
	if(fabs(beta) >= alpha){
		return pdf=0;
	}
	double arg = delta*sqrt(pow(alpha,2)-pow(beta,2));
	double a = (lambda/2.0)*log(pow(alpha,2)-pow(beta,2)) - (log(sqrt(2*PI)) + (lambda-0.5)*log(alpha)
			+ lambda*log(delta) + log(bessel_k(arg, lambda, 2)) - arg );
	double f = ((lambda-0.5)/2.0)*log(pow(delta,2)+pow((x - mu),2));
	arg = alpha * sqrt(pow(delta,2)+pow((x-mu),2));
	double k = log(bessel_k(arg, lambda-0.5, 2)) - arg;
	double e = beta*(x-mu);
	pdf = exp(a + f + k + e);
	return pdf;
}

void c_dgh(double *x, double *alpha, double *beta, double *delta, double *mu, double *lambda, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dgh(x[i], alpha[i], beta[i], delta[i], mu[i],lambda[i]);
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double dghstd(const double x, const double rho, const double zeta, const double lambda)
{
	double pdf;
	double *param;
	param = paramgh(rho, zeta, lambda);
	double alpha=param[0];
	double beta=param[1];
	double delta=param[2];
	double mu=param[3];
	pdf = dgh(x, alpha, beta, delta, mu, lambda);
	free(param);
	return pdf;
}

void c_dghyp(double *x, double *mu, double *sigma, double *skew, double *shape, double *lambda, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dghstd((x[i]-mu[i])/sigma[i], skew[i], shape[i], lambda[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double rghyp(const double rho, const double zeta, const double lambda)
{
	double *param;
	param = paramgh(rho, zeta, lambda);
	double alpha = param[0];
	double beta = param[1];
	double delta = param[2];
	double mu = param[3];
	double chi = delta*delta;
	double psi = (alpha * alpha) - (beta * beta);
	double W = rgig(lambda, chi, psi);
	double ans = mu + W*beta + sqrt(W) * rnorm(0, 1);
	free(param);
	return(ans);
}

void c_rghyp(int *n, double *mu, double *sigma, double *skew, double *shape, double *lambda, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rghyp(skew[i], shape[i], lambda[i])*sigma[i];
	}
}

/*
 * -----------------------------------------
 * NIG Distribution
 * -----------------------------------------
 */
double dnig(const double x, const double alpha, const double  beta, const double delta, const double mu)
{
	double pdf=0;
	double lambda=-0.5;
	pdf = dgh(x, alpha, beta, delta, mu, lambda);
	return pdf;
}

double dnigstd(const double x, const double rho, const double zeta)
{
	double pdf=0;
	double lambda=-0.5;
	double *param;
	param = paramgh(rho, zeta, lambda);
	double alpha=param[0];
	double beta=param[1];
	double delta=param[2];
	double mu=param[3];
	double d = delta*delta;
	double xm = x-mu;
	pdf =  -log(PI)+log(alpha)+log(delta)+log(bessel_k(alpha*sqrt(d+xm*xm), 1, 1))+
				delta*sqrt(alpha*alpha-beta*beta)+beta*xm-0.5*log(d+xm*xm);
	pdf = exp(pdf);
	free(param);
	return pdf;
}

void c_dsnig(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dnigstd((x[i]-mu[i])/sigma[i], skew[i], shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double rsnig(const double rho, const double zeta)
{
	double ans = rghyp(rho, zeta, -0.5);
	return(ans);
}

double rnig(const double alpha, const double beta, const double delta, const double mu)
{
	double chi = delta*delta;
	double psi = (alpha * alpha) - (beta * beta);
	double W = rgig(-0.5, chi, psi);
	double ans = mu + W*W*beta + sqrt(W) * rnorm(0, 1);
	return(ans);
}

void c_rsnig(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rghyp(skew[i], shape[i], -0.5)*sigma[i];
	}
}

/*
 * -----------------------------------------
 * Student Distribution
 * -----------------------------------------
 */

double rstd(const double nu)
{
	double ans = 0;
	if(nu > 2.0)
	{
	double s = sqrt(nu/(nu-2));
	ans = rt(nu) * 1.0 / s;
	}
	return(ans);
}

void c_rstd(int *n, double *mu, double *sigma, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rstd(shape[i])*sigma[i];
	}
}

double xdt(const double x, const double nu)
{
	double a, b, pdf;
	a = gammafn((nu+1.0)/2.0)/sqrt(PI*nu);
    b = gammafn(nu/2.0)*pow((1.0+(x*x)/nu),((nu+1.0)/2.0));
    pdf = a/b;
	return pdf;
}

double dstdstd(const double x, const double nu)
{
	double pdf, s;
	if(nu<=2){
		pdf = 999;
	} else{
		s = sqrt(nu/(nu-2.0));
		pdf = s*xdt(x*s,nu);
	}
	return pdf;
}

void c_dstd(double *x, double *mu, double *sigma, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dstdstd((x[i]-mu[i])/sigma[i], shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double pstd(const double q, const double mu, const double sigma, const double nu)
{
	double s = sqrt(nu/(nu-2.0));
	double z = (q-mu)/sigma;
	double p = pt(z*s, nu, 1, 0);
	return( p );
}

void c_pstd(double *q, double *mu, double *sigma, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = pstd(q[i],mu[i],sigma[i],shape[i]);
	}
}

double qstd(const double p, const double mu, const double sigma, const double nu)
{
	double s = sqrt(nu/(nu-2.0));
	double q = qt(p, nu, 1, 0) * sigma/s + mu;
	return( q );
}

void c_qstd(double *p, double *mu, double *sigma, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = qstd(p[i],mu[i],sigma[i],shape[i]);
	}
}

/*
 * -----------------------------------------
 * Skew Student Distribution (Fernandez & Steel)
 * -----------------------------------------
 */
double rsstd(const double xi, const double nu)
{
	double weight, z, rr, m1, mu, sigma, xx, ans;
	ans = 0.0;
	weight = xi / (xi + 1.0/xi);
	z = runif(-1.0 * weight, 1.0 - weight);
	xx = (z < 0)? 1.0/xi : xi;
	rr = -1.0 * fabs(rstd(nu))/xx * sign(z);
	m1 = 2.0 * sqrt(nu - 2.0) / (nu - 1.0) / beta(0.5, 0.5 * nu);
	mu = m1 * (xi - 1.0/xi);
	sigma =  sqrt((1.0 - (m1 * m1)) * ((xi * xi) + 1.0/(xi * xi)) + 2 * (m1 * m1) - 1.0);
	ans =  (rr - mu ) / sigma;
	return(ans);
}

void c_rsstd(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rsstd(skew[i], shape[i])*sigma[i];
	}
}

double dsstdstd(const double x, const double xi, const double nu)
{
	double mu, m1,beta, sigma, z, g,pdf,a,b, xxi;
	xxi=xi;
	a = 1.0/2.0;
	b = nu/2.0;
	beta = (gammafn(a)/gammafn(a+b))*gammafn(b);
	m1 = 2.0*sqrt(nu-2.0)/(nu-1.0)/beta;
	mu = m1*(xi-1.0/xi);
	sigma = sqrt((1.0-pow(m1,2))*(pow(xi,2)+1.0/(pow(xi,2)))+2.0*pow(m1,2)-1.0);
	z = x*sigma + mu;
	if(z==0){
		xxi=1;
	}
	if(z<0){
		xxi = 1/xi;
	}
	g = 2.0/(xi+1.0/xi);
	pdf = g*dstdstd(z/xxi,nu)*sigma;
	return pdf;
}

void c_dsstd(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dsstdstd((x[i]-mu[i])/sigma[i], skew[i], shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double psstd(const double q, const double mu, const double sigma, const double xi, const double nu)
{
	double qx = (q-mu)/sigma;
	double m1 = 2.0 * sqrt(nu-2.0) / (nu-1.0) / beta(0.5, nu/2.0);
	double mux = m1*(xi-1.0/xi);
	double sig =  sqrt((1-m1*m1)*(xi*xi+1/(xi*xi)) + 2*m1*m1 - 1);
	double z = qx*sig+mux;
	double Xi = (z<0)?1.0/xi:xi;
	double g = 2.0 / (xi + 1.0/xi);
	double p = heaviside(z, 0) - signum(z) * g * Xi * pstd(-fabs(z)/Xi, 0, 1, nu);
	return( p );
}

void c_psstd(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = psstd(q[i],mu[i],sigma[i],skew[i],shape[i]);
	}
}

double qsstd(const double p, const double xi, const double nu)
{
	double m1 = 2.0 * sqrt(nu-2.0) / (nu-1.0) / beta(0.5, nu/2.0);
	double mu = m1*(xi-1.0/xi);
	double sigma =  sqrt((1-m1*m1)*(xi*xi+1/(xi*xi)) + 2*m1*m1 - 1);
	double g = 2.0 / (xi + 1.0/xi);
	double z = p-0.5;
	double Xi = (z<0)?1.0/xi:xi;
	double tmp = (heaviside(z, 0) - signum(z)*p)/(g*Xi);
	double q = (-signum(z)*qstd(tmp, 0, 1, nu)*Xi - mu)/sigma;
	return( q );
}

void c_qsstd(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = qsstd(p[i],skew[i],shape[i])*sigma[i]+mu[i];
	}
}

/*
 * -----------------------------------------
 * Johnson's SU Distribution
 * -----------------------------------------
 */
//nu = skew, tau = shape (!)
double djsustd(const double x, const double nu, const double tau)
{
	double w, z, r, omega, c, pdf=0.0;
	double rtau=1.0/tau;
	if(rtau<0.0000001){
		w = 1.0;
	} else{
		w = exp(rtau*rtau);
	}
	omega=-nu*rtau;
	c=sqrt(1/(0.5*(w-1)*(w*cosh(2*omega)+1)));
	z=(x-(c*sqrt(w)*sinh(omega)))/c;
	r=-nu + asinh(z)/rtau;
	pdf= -log(c)-log(rtau)-0.5*log(z*z+1)-0.5*log(2*PI)-0.5*r*r;
	pdf=exp(pdf);
	return pdf;
}

void c_djsu(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = djsustd((x[i]-mu[i])/sigma[i],skew[i],shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double qjsu(const double p, const double nu, const double tau)
{
	double rtau, rr, z, w, omega, cc, ans;
	ans = 0.0;
	rtau = 1.0/tau;
	rr = qnorm(p, 0.0, 1.0, 1, 0);
	z = sinh(rtau * (rr + nu));
	w = (rtau<0.0000001) ? 1 : exp(rtau * rtau);
	omega = -1.0 * nu * rtau;
	cc = sqrt(1/(0.5 * (w - 1.0)*(w * cosh(2.0 * omega) + 1)));
	ans = (cc * sqrt(w) * sinh(omega)) + cc * z;
	return(ans);
}

void c_qjsu(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i]+qjsu(p[i],skew[i],shape[i])*sigma[i];
	}
}

double rjsu(const double nu, const double tau)
{
	double x, ans;
	ans = 0.0;
	x = runif(0, 1);
	ans = qjsu(x, nu, tau);
	return(ans);
}

void c_rjsu(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rjsu(skew[i], shape[i])*sigma[i];
	}
}

double pjsu(const double q, const double mu, const double sigma, const double nu, const double tau)
{
	double rtau = 1.0/tau;
	double w = (rtau<0.0000001)?1.0:exp(rtau*rtau);
	double omega = -1.0*nu*rtau;
	double c = 1/sqrt(0.5*(w-1.0)*(w*cosh(2*omega)+1));
	double z = (q-(mu+c*sigma*sqrt(w)*sinh(omega)))/(c*sigma);
	double r = -1.0*nu + asinh(z)/rtau;
	double p = pnorm(r,0,1,1,0);
	return( p );
}

void c_pjsu(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = pjsu(q[i], mu[i], sigma[i], skew[i],shape[i]);
	}
}

/*
 * -----------------------------------------
 * Skew Normal Distribution
 * -----------------------------------------
 */
double rsnorm(const double xi)
{
	double weight, z, rr, m1, mu, sigma, xx, ans;
	weight = xi / (xi + 1.0/xi);
	z = runif(-weight, 1.0 - weight);
	xx = (z < 0)? 1.0/xi : xi;
	rr = -1.0 * fabs(rnorm(0, 1))/xx * sign(z);
	m1 = 2.0/sqrt(2.0 * PI);
	mu = m1 * (xi - 1.0/xi);
	sigma = sqrt((1 - (m1 * m1)) * ( (xi * xi) + 1.0/(xi* xi) ) + 2 * (m1 * m1) - 1.0);
	ans = (rr - mu ) / sigma;
	return(ans);
}

void c_rsnorm(int *n, double *mu, double *sigma, double *skew, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rsnorm(skew[i])*sigma[i];
	}
}

double dsnormstd(const double x, const double xi)
{
	double pdf;
	double mu, sigma,z, xxi, g;
	double m1 = 2.0/sqrt(2.0*PI);
	double m12 = m1*m1;
	double xi2 = xi*xi;
	mu = m1*(xi-1.0/xi);
	sigma = sqrt((1-m12)*(xi2+1.0/xi2)+2*m12-1);
	z = x*sigma+mu;
	xxi = (z<0)? 1.0/xi : xi;
	g = 2.0/(xi + 1.0/xi);
	pdf = g * dnormstd(z/xxi)*sigma;
	return pdf;
}

void c_dsnorm(double *x, double *mu, double *sigma, double *skew, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dsnormstd((x[i]-mu[i])/sigma[i], skew[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double psnorm(const double q, const double mu, const double sigma, const double xi)
{
	double qx = (q-mu)/sigma;
	double m1 = 2.0/sqrt(2*PI);
	double mux = m1 * (xi - 1.0/xi);
	double sig = sqrt((1.0-m1*m1)*(xi*xi+1.0/(xi*xi)) + 2.0*m1*m1 - 1.0);
	double z = qx*sig + mux;
	double Xi = (z<0)?1.0/xi:xi;
	double g = 2.0/(xi + 1.0/xi);
	double p = heaviside(z, 0) - signum(z) * g * Xi * pnorm(-fabs(z)/Xi, 0, 1, 1, 0);
	return( p );
}

void c_psnorm(double *q, double *mu, double *sigma, double *skew, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = psnorm(q[i],mu[i],sigma[i],skew[i]);
	}
}

double qsnorm(const double p, const double xi)
{
	double m1 = 2.0/sqrt(2*PI);
	double mu = m1 * (xi - 1.0/xi);
	double sigma = sqrt((1.0-m1*m1)*(xi*xi+1.0/(xi*xi)) + 2.0*m1*m1 - 1.0);
	double g = 2.0/(xi + 1.0/xi);
	double z = p-0.5;
	double Xi = (z<0)?1.0/xi:xi;
	double tmp = (heaviside(z, 0) - signum(z) * p)/ (g* Xi);
	double q = (-1.0*signum(z)*qnorm(tmp, 0, Xi, 1, 0) - mu)/sigma;
	return( q );
}

void c_qsnorm(double *p, double *mu, double *sigma, double *skew, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i]+qsnorm(p[i],skew[i])*sigma[i];
	}
}

/*
 * -----------------------------------------
 * Generalized Error Distribution
 * -----------------------------------------
 */
double rged(const double nu)
{
	double lambda, rr, ans;
	ans = 0.0;
	lambda = sqrt ( pow(0.5, 2.0/nu) * gammafn(1.0/nu) / gammafn(3.0/nu) );
	rr = rgamma(1.0/nu, 1.0);
	ans =  lambda * pow(2*rr, 1/nu) * sign(runif(0, 1) - 0.5);
	return(ans);
}

void c_rged(int *n, double *mu, double *sigma, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rged(shape[i])*sigma[i];
	}
}

double dgedstd(const double x, const double nu)
{
	double lambda, g, pdf;
	lambda = sqrt(pow(1.0/2.0,2.0/nu)*gammafn( 1.0/nu )/gammafn( 3.0/nu));
    g = nu/(lambda*(pow(2.0,1.0+(1.0/nu)))*gammafn( 1.0/nu));
	pdf = g*exp(-0.5*pow(fabs(x/lambda),nu));
	return pdf;
}

void c_dged(double *x, double *mu, double *sigma, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dgedstd((x[i]-mu[i])/sigma[i], shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double pged(const double q, const double mu, const double sigma, const double nu)
{
	double qx = (q-mu)/sigma;
	double lambda = sqrt ( 1.0/pow(2.0, (2.0/nu)) * gammafn(1.0/nu) / gammafn(3.0/nu) );
	double g  = nu / ( lambda * (pow(2,(1+1.0/nu))) * gammafn(1.0/nu) );
	double h = pow(2.0, (1.0/nu)) * lambda * g * gammafn(1.0/nu) / nu;
	double s = 0.5 * pow( fabs(qx) / lambda , nu );
	double p = 0.5 + signum(qx) * h * pgamma(s, 1.0/nu, 1, 1, 0);
	return( p );
}

void c_pged(double *q, double *mu, double *sigma, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = pged(q[i],mu[i],sigma[i],shape[i]);
	}
}

double qged(const double p, const double shape)
{
	double y = 2.0*p-1.0;
	double lambda = sqrt ( 1.0/pow(2.0, (2.0/shape)) * gammafn(1.0/shape) / gammafn(3.0/shape) );
	double q = lambda * pow(2.0*qgamma(fabs(y), 1.0/shape, 1, 1, 0), 1.0/shape);
	q = q*signum(y);
	return( q );
}

void c_qged(double *p, double *mu, double *sigma, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = qged(p[i],shape[i]) * sigma[i] + mu[i];
	}
}

/*
 * -----------------------------------------
 * Skew Generalized Error Distribution (Fernandez & Steel)
 * -----------------------------------------
 */
double rsged(const double xi, const double nu)
{
	double weight, lambda, z, rr, m1, mu, sigma, xx, ans;
	weight = xi / (xi + 1.0/xi);
	z = runif(-1.0 * weight, 1.0 - weight);
	xx = (z < 0)? 1.0/xi : xi;
	rr = -1.0 * fabs(rged(nu))/xx * sign(z);
	lambda = sqrt ( pow(0.5, 2.0/nu) * gammafn(1.0/nu) / gammafn(3.0/nu) );
	//g  = nu / ( lambda * (pow(2, 1.0 +1.0/nu)) * gammafn(1.0/nu) );
	m1 = pow(2, 1.0/nu) * lambda * gammafn(2.0/nu) / gammafn(1.0/nu);
	mu = m1 * (xi - 1.0/xi);
	sigma = sqrt((1 - (m1 * m1)) * ( (xi * xi) + 1.0/(xi* xi) ) + 2 * (m1 * m1) - 1.0);
	ans = (rr - mu ) / sigma;
	return(ans);
}

void c_rsged(int *n, double *mu, double *sigma, double *skew, double *shape, double *ans)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = mu[i] + rsged(skew[i], shape[i])*sigma[i];
	}
}

double dsgedstd(const double x, const double xi, const double nu)
{
	double lambda, m1, mu, sigma, z, g, pdf, xxi;
	xxi=xi;
	lambda = sqrt(pow(1.0/2.0,(2/nu))*gammafn( 1.0/nu )/gammafn( 3.0/nu));
	g = nu/(lambda*(pow(2.0,1.0+(1.0/nu)))*gammafn( 1.0/nu));
	m1 = pow(2.0, (1.0/nu))*lambda*gammafn(2.0/nu)/gammafn(1.0/nu);
	mu = m1*(xi-1.0/xi);
	sigma = (1 - pow(m1,2.0))*(pow(xi,2.0)+1.0/(pow(xi,2.0))) + 2.0*(pow(m1,2))-1.0;
	sigma = sqrt(sigma);
	z = x*sigma+mu;
	if(z==0){
		xxi=1;
	}
	if(z<0){
		xxi = 1/xi;
	}
	g = 2.0/(xi + 1.0/xi);
	pdf = g*dgedstd(z/xxi, nu)*sigma;
	return pdf;
}

void c_dsged(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dsgedstd((x[i]-mu[i])/sigma[i],skew[i],shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}

double psged(const double q, const double mu, const double sigma, const double xi, const double nu)
{
	double qx = (q-mu)/sigma;
	double lambda = sqrt ( 1.0/pow(2.0, 2.0/nu) * gammafn(1.0/nu) / gammafn(3.0/nu) );
	double m1 = pow(2.0, 1.0/nu) * lambda * gammafn(2.0/nu) / gammafn(1.0/nu);
	double mux = m1*(xi-1.0/xi);
	double sig =  sqrt((1.0-m1*m1)*(xi*xi+1/(xi*xi)) + 2.0*m1*m1 - 1);
	double z = qx*sig + mux;
	double Xi = (z<0)?1.0/xi:xi;
	double g = 2.0/(xi + 1.0/xi);
	double p = heaviside(z, 0) - signum(z) * g * Xi * pged(-fabs(z)/Xi, 0, 1, nu);
	return( p );
}

void c_psged(double *q, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = psged(q[i],mu[i],sigma[i],skew[i],shape[i]);
	}
}

double qsged(const double p, const double xi, const double nu)
{
	double lambda = sqrt ( 1.0/pow(2.0, 2.0/nu) * gammafn(1.0/nu) / gammafn(3.0/nu) );
	double m1 = pow(2.0, 1.0/nu) * lambda * gammafn(2.0/nu) / gammafn(1.0/nu);
	double mu = m1*(xi-1.0/xi);
	double sigma =  sqrt((1.0-m1*m1)*(xi*xi+1/(xi*xi)) + 2.0*m1*m1 - 1);
	double g = 2.0/(xi + 1.0/xi);
	double z = p - 0.5;
	double Xi = (z<0)?1.0/xi:xi;
	double q = (heaviside(z, 0) - signum(z) * p)/ (g* Xi);
	q = (-signum(z)*qged(q, nu)*Xi - mu)/sigma;
	return( q );
}

void c_qsged(double *p, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = qsged(p[i],skew[i],shape[i]) * sigma[i] + mu[i];
	}
}

/*
 * -----------------------------------------
 * Hypebolic Distribution
 * -----------------------------------------
 */
double dhyp(const double x, const double alpha, const double beta, const double delta, const double mu)
{
	double pdf=0;
	if(alpha<=0){
		return pdf=0;
	}
	if(delta <= 0){
		return pdf=0;
	}
	if(fabs(beta) >= alpha){
		return pdf=0;
	}
	double g = alpha*alpha - beta*beta;
	double e = x - mu;
	pdf = 0.5*log(g) - log(2*alpha*delta*bessel_k(delta*sqrt(g),1,2)) - alpha*sqrt(delta*delta + e*e)  + beta*e;
	pdf = exp(pdf);
	return pdf;
}

double dhypstd(const double x,  const double rho, const double zeta)
{
	double pdf;
	double *param;
	param = paramgh(rho, zeta, 1);
	double alpha=param[0];
	double beta=param[1];
	double delta=param[2];
	double mu=param[3];
	pdf = dhyp(x, alpha, beta, delta, mu);
	free(param);
	return pdf;
}

void c_dhyp(double *x, double *mu, double *sigma, double *skew, double *shape, double *ans, int *n, int *logr)
{
	int i;
	for(i=0;i<*n;i++)
	{
		ans[i] = dhypstd((x[i]-mu[i])/sigma[i],skew[i],shape[i])/sigma[i];
		if(*logr==1) ans[i] = log(ans[i]);
	}
}
/*
 * -----------------------------------------
 * Calling Functions
 * -----------------------------------------
 */
double garchdistribution(const double zz, const double hh, const double skew, const double shape, const double dlambda, const int ndis){
	/*ndist: 1- normal
			 2 - skew-normal
			 3 - student
			 4 - skew-student
			 5 - ged
			 6 - skew-ged
			 7 - Normal Inverse Gaussian (NIG)
			 8 - Generalized Hyperbolic (GHYP) --> special HYP case handled separately for speed.
			 9 - JSU
			 10 - GH Skew Student
			 11 - Truncated Normal (skew = lower, shape = upper)
	distEq: [0]: Skew, [1]: Shape, ... additionally can be used for normal mixture
	(not yet implemented)
	*/
	double pdf=0;
	if(ndis==1)
	{
		pdf=dnormstd(zz)/hh;
	}
	if(ndis==2)
	{
		pdf=dsnormstd(zz,skew)/hh;
	}
	if(ndis==3)
	{
		pdf=dstdstd(zz,shape)/hh;
	}
	if(ndis==4)
	{
		pdf=dsstdstd(zz,skew,shape)/hh;
	}
	if(ndis==5)
	{
		pdf=dgedstd(zz,shape)/hh;
	}
	if(ndis==6)
	{
		pdf=dsgedstd(zz,skew,shape)/hh;
	}
	if(ndis==7)
	{
		pdf=dnigstd(zz,skew,shape)/hh;
	}
	if(ndis==8)
	{
		if(dlambda==1){
			pdf=dhypstd(zz,skew,shape)/hh;
		} else{
			pdf=dghstd(zz,skew,shape,dlambda)/hh;
		}
	}
	if(ndis==9)
	{
		pdf=djsustd(zz,skew,shape)/hh;
	}
	if(ndis==10)
	{
		pdf = dghsktstd(zz,skew,shape)/hh;
	}
	return pdf;
}

double rgarchdist(const double shape, const double skew, const double lambda, const int ndis){
	/*ndist: 1- normal
			 2 - skew-normal
			 3 - student
			 4 - skew-student
			 5 - ged
			 6 - skew-ged
			 7 - Normal Inverse Gaussian (NIG)
			 8 - Generalized Hyperbolic (GHYP)
			 9 - Johnson's SU (JSU)
	distEq: [0]: Skew, [1]: Shape, ... additionally can be used for normal mixture
	(not yet implemented)
	*/
	double ans=0.0;
	if(ndis==1)
	{
		ans=rnorm(0, 1);
	}
	if(ndis==2)
	{
		ans=rsnorm(skew);
	}
	if(ndis==3)
	{
		ans=rstd(shape);
	}
	if(ndis==4)
	{
		ans=rsstd(skew,shape);
	}
	if(ndis==5)
	{
		ans=rged(shape);
	}
	if(ndis==6)
	{
		ans=rsged(skew,shape);
	}
	if(ndis==7)
	{
		ans = rsnig(skew,shape);
	}
	if(ndis==8)
	{
		ans = rghyp(skew,shape,lambda);
	}
	if(ndis==9)
	{
		ans = rjsu(skew,shape);
	}
	return(ans);
}

double pgarchdist(const double q, const double mu, const double sigma, const double shape, const double skew, const double lambda, const int ndis)
{
	/*ndist: 1- normal
			 2 - skew-normal
			 3 - student
			 4 - skew-student
			 5 - ged
			 6 - skew-ged
			 7 - Normal Inverse Gaussian (NIG)
			 8 - Generalized Hyperbolic (GHYP)
			 9 - Johnson's SU (JSU)
	distEq: [0]: Skew, [1]: Shape, ... additionally can be used for normal mixture
	(not yet implemented)
	*/
	double ans=0.0;
	if(ndis==1)
	{
		ans=pnorm(q, mu, sigma, 1, 0);
	}
	if(ndis==2)
	{
		ans=psnorm(q, mu, sigma, skew);
	}
	if(ndis==3)
	{
		ans=pstd(q, mu, sigma, shape);
	}
	if(ndis==4)
	{
		ans=psstd(q, mu, sigma, skew, shape);
	}
	if(ndis==5)
	{
		ans=pged(q, mu, sigma, shape);
	}
	if(ndis==6)
	{
		ans=psged(q, mu, sigma, skew, shape);
	}
	if(ndis==7)
	{
		// Not Yet Implemented in C code
		ans = 0.5;
	}
	if(ndis==8)
	{
		// Not Yet Implemented in C code
		ans = 0.5;
	}
	if(ndis==9)
	{
		ans = pjsu(q, mu, sigma, skew, shape);
	}
	return(ans);
}


double svfun(const double x, const double res, const double h, const double skew, const double shape,
		const double dlambda, const double lmu, const double lsigma, const int ndis)
{
	double svh = sqrt(h+x);
	double svz = res/svh;
	double pdf=0;
	switch(ndis)
	{
	case 1:
		pdf=dnormstd(svz)/svh;
		break;

	case 2:
		pdf=dsnormstd(svz, skew)/svh;
		break;
	case 3:
		pdf=dstdstd(svz, shape)/svh;
		break;
	case 4:
		pdf=dsstdstd(svz, skew, shape)/svh;
		break;
	case 5:
		pdf=dgedstd(svz, shape)/svh;
		break;
	case 6:
		pdf=dsgedstd(svz, skew, shape)/svh;
		break;
	case 7:
		pdf=dnigstd(svz, skew, shape)/svh;
		break;
		break;
	case 8:
		if(dlambda==1){
			pdf=dhypstd(svz, skew, shape)/svh;
		} else{
			pdf=dghstd(svz,  skew, shape, dlambda)/svh;
		}
		break;
	case 9:
		pdf=djsustd(svz,skew, shape)/svh;
		break;
	case 10:
		pdf = dghsktstd(svz, skew, shape)/svh;
		break;
	}
	double svi = pdf*dlnorm(x, lmu, lsigma, 0);
	return(svi);
}
