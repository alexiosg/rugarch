#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <setjmp.h>
#include <R.h>
#include <Rdefines.h>
#include <Rmath.h>
#include <Rinternals.h>
#include "nig.h"

#define  SIGN(a,b) ((b) >= 0.0 ? fabs(a) : -fabs(a))
#define  MIN(a, b) ((a) < (b) ? (a) : (b))
#define  MAX(a, b) ((a) > (b) ? (a) : (b))

#define  pi 3.14159265358979
#define  EPS   1e-12
#define  XLEAST 2.23e-308
#define  XSMALL 1.11e-16
#define  XINF 1.79e308
#define  XMAX 705.343
#define  MAX_ITER 5000
#define  ITMAX 100


/* nig.c code from package fBasics of the Rmetrics group*/
/*
////////////////////////////////////////////////////////////////////////////////
//
// pnigC and qnigC Code
//
// Author:  Kjersti Aas, 2000
//          Diethelm Wuertz, added to fBasics
//          Nikolai Eurich, bug fixed which appeared in R 2.7
//
////////////////////////////////////////////////////////////////////////////////
*/
/*
FUNCTION NAME:       	heap_sort
AUTHOR     :        	Kjersti Aas, NR
DATE       :        	March 2000
ARGUMENTS  :        	n      Number of elements in the vector to be sorted
						x      Vector to be sorted (n x 1)
                     	order  Order of sorted values (n x 1)
DESCRIPTION:        	Returns order of sorted values in index array.
*/
void heapSort(int n, double *x, int *order)
{
  int i,j,l;
  int ir, ordert;
  double q;
  for(j = 0; j < n; j++) order[j] = j;
  if(n <= 1) return;
  l = (n >> 1) + 1;   /* shift n one bit to the right, i.e divide it by two.*/
  ir = n;
  for(;;)                        /* Indefinite loop */
  {
    if(l > 1)
    {
      /* Decrement l before evaluating the expression */
      q = x[(ordert = order[--l-1])];
    }
    else
    {
      q = x[(ordert = order[ir-1])];
      order[ir-1] = order[0];
      /* Decrement ir before its value is used */
      if(--ir == 1)
      {
        order[0] = ordert;
        return;
      }
    }
    i = l;
    j = l << 1;
    while(j <= ir)
    {
      if((j < ir) && (x[order[j-1]] > x[order[j]])) j++;
      if(q > x[order[j-1]])
      {
        order[i-1] = order[j-1];
        j += (i=j);
      }
      else j = ir + 1;
    }
    order[i-1] = ordert;
  }
}

double bessk1(double x)
{
  int i;
  double y, k1;
  double sump, sumq, sumf, sumg;
  static double p[5] =
  {
    4.8127070456878442310e-1, 9.9991373567429309922e+1,
    7.1885382604084798576e+3, 1.7733324035147015630e+5,
    7.1938920065420586101e+5
  };
  static double q[3] =
  {
    -2.8143915754538725829e+2, 3.7264298672067697862e+4,
    -2.2149374878243304548e+6
  };
  static double f[5] =
  {
    -2.2795590826955002390e-1,-5.3103913335180275253e+1,
    -4.5051623763436087023e+3,-1.4758069205414222471e+5,
    -1.3531161492785421328e+6
  };
  static double g[3] =
  {
    -3.0507151578787595807e+2, 4.3117653211351080007e+4,
    -2.7062322985570842656e+6
  };
  static double pp[11] =
  {
    6.4257745859173138767e-2, 7.5584584631176030810e+0,
    1.3182609918569941308e+2, 8.1094256146537402173e+2,
    2.3123742209168871550e+3, 3.4540675585544584407e+3,
    2.8590657697910288226e+3, 1.3319486433183221990e+3,
    3.4122953486801312910e+2, 4.4137176114230414036e+1,
    2.2196792496874548962e+0
  };
  static double qq[9] =
  {
    3.6001069306861518855e+1, 3.3031020088765390854e+2,
    1.2082692316002348638e+3, 2.1181000487171943810e+3,
    1.9448440788918006154e+3, 9.6929165726802648634e+2,
    2.5951223655579051357e+2, 3.4552228452758912848e+1,
    1.7710478032601086579e+0
  };
  if(x < XLEAST)
  {
    k1 = XINF;
  }
  else if(x <= 1.0)
  {
    if(x < XSMALL)
    {
      k1 = 1.0/x;
    }
    else
    {
      y = x*x;
      sump = ((((p[0]*y + p[1])*y + p[2])*y + p[3])*y + p[4])*y + q[2];
      sumq = ((y + q[0])*y + q[1])*y + q[2];
      sumf = (((f[0]*y + f[1])*y + f[2])*y + f[3])*y + f[4];
      sumg = ((y + g[0])*y + g[1])*y + g[2];
      k1 = (y*log(x)*sumf/sumg + sump/sumq)/x;
    }
  }
  else if(x > XMAX)
  {
    k1 = 0.0;
  }
  else
  {
    y = 1.0/x;
    sump = pp[0];
    for(i = 1; i < 11; i++)
    {
      sump = sump*y + pp[i];
    }
    sumq = y;
    for(i = 0; i < 8; i++)
    {
      sumq = (sumq + qq[i]) * y;
    }
    sumq = sumq + qq[8];
    k1 = sump/sumq/sqrt(x)*exp(-x);
  }
  return(k1);
}

void dNIG(double* x, double* mu, double* delta, double* alpha,
    double* beta, int* n, double* d)
{
  int i;
  double xarg, exparg;
  for(i = 0; i < *n; i++)
  {
    xarg = *alpha*sqrt(pow(*delta,2.0)+pow((x[i]-*mu),2.0));
    exparg = *delta*sqrt(pow(*alpha,2.0)-pow(*beta,2.0))+*beta*(x[i]-*mu);
    if(exparg < -XMAX) exparg = -XMAX;
    if(exparg > XMAX) exparg = XMAX;
    d[i] = (*alpha*(*delta)/pi)*exp(exparg)*bessk1(xarg)/sqrt(pow(*delta,2.0) +
      pow((x[i]-*mu),2.0));
  }
}

double fdNIG(double x, double mu, double delta, double alpha, double beta)
{
  int i = 1;
  double f;
  dNIG(&x, &mu, &delta, &alpha, &beta, &i, &f);
  return(f);
}

void intdei(double a, double mu, double delta, double alpha, double beta,
    double *i, double *err)
{
  /* ---- adjustable parameters ---- */
  int mmax = 512;
  double efs = 0.1, hoff = 11.0;
  /* ------------------------------ */
  int m;
  double pi4, epsln, epsh, h0, ehp, ehm, epst, ir, h;
  double iback, irback, t, ep, em, xp, xm, fp, fm, errt, errh, errd;

  pi4 = atan(1.0);
  epsln = 1 - log(efs * EPS);
  epsh = sqrt(efs * EPS);
  h0 = hoff / epsln;
  ehp = exp(h0);
  ehm = 1 / ehp;
  epst = exp(-ehm * epsln);
  ir = fdNIG(a + 1, mu, delta, alpha, beta);
  *i = ir * (2 * pi4);
  *err = fabs(*i) * epst;
  h = 2 * h0;
  m = 1;
  errh = 0;
  do
  {
    iback = *i;
    irback = ir;
    t = h * 0.5;
    do
    {
      em = exp(t);
      ep = pi4 * em;
      em = pi4 / em;
      do
      {
        xp = exp(ep - em);
        xm = 1 / xp;
        fp = fdNIG(a + xp, mu, delta, alpha, beta) * xp;
        fm = fdNIG(a + xm, mu, delta, alpha, beta) * xm;
        ir += fp + fm;
        *i += (fp + fm) * (ep + em);
        errt = (fabs(fp) + fabs(fm)) * (ep + em);
        if (m == 1) *err += errt * epst;
        ep *= ehp;
        em *= ehm;
      } while (errt > *err || xm > epsh);
      t += h;
    } while (t < h0);
    if (m == 1)
    {
      errh = (*err / epst) * epsh * h0;
      errd = 1 + 2 * errh;
    }
    else
    {
      errd = h * (fabs(*i - 2 * iback) + 4 * fabs(ir - 2 * irback));
    }
    h *= 0.5;
    m *= 2;
  } while (errd > errh && m < mmax);
  *i *= h;
  if (errd > errh)
  {
    *err = -errd * m;
  }
  else
  {
    *err = errh * epsh * m / (2 * efs);
  }
}
void pNIG(double *x, double *mu, double *delta, double *alpha, double *beta,
    int *n, double *p)
{
	 int i;
	  double err, v;
	  for(i = 0; i < *n; i++)
	  {
	    // Special cases (-Inf, Inf)
	    if(x[i] <= -XINF)
	    {
	      p[i] = 0.0;
	    }
	    else if(x[i] >= XINF)
	    {
	      p[i] = 1.0;
	    }
	    // Integrates density from x to Inf
	    else
	    {
	      // printf("intdei\n");
	      intdei(x[i], *mu, *delta, *alpha, *beta, &v, &err);
	      // Check that 0 <= v <= 1
	      if(v < 0.0) v = 0.0;
	      if(v > 1.0) v = 1.0;
	      // Computes integral from -Inf to x
	      p[i] = 1.0-v;
	    }
	  }
}

double fpNIG(double x, double mu, double delta, double alpha, double beta,
    double sp)
{
  double f;
  int i = 1;
  pNIG(&x, &mu, &delta, &alpha, &beta, &i, &f);
  f -= sp;
  return(f);
}
double zbrent(double x1, double x2, double mu, double delta, double alpha,
    double beta, double sp)
{
  int iter;
  double a, b, c, d, e, min1, min2;
  double fa, fb, fc, p, q, r, s, tol1, xm;

  d = 0;
  e = 0;

  a = x1;
  b = x2;
  c = x2;
  fa = fpNIG(a,mu,delta,alpha,beta,sp);
  fb = fpNIG(b,mu,delta,alpha,beta,sp);

  fc = fb;
  for(iter = 1; iter <= ITMAX; iter++)
  {
    if((fb > 0.0 && fc > 0.0)||(fb < 0.0 && fc < 0.0))
    {
      c = a;
      fc = fa;
      e = d = b-a;
    }
    if(fabs(fc) < fabs(fb))
    {
      a = b;
      b = c;
      c = a;
      fa = fb;
      fb = fc;
      fc = fa;
    }
    tol1 = 2.0*EPS*fabs(b)+0.5*EPS;
    xm = 0.5*(c-b);
    if(fabs(xm) <= tol1 || fb == 0.0) return b;
    if(fabs(e) >= tol1 && fabs(fa) > fabs(fb))
    {
      s = fb/fa;
      if(a == c)
      {
        p = 2.0*xm*s;
        q = 1.0-s;
      }
      else
      {
        q = fa/fc;
        r = fb/fc;
        p = s*(2.0*xm*q*(q-r)-(b-a)*(r-1.0));
        q = (q-1.0)*(r-1.0)*(s-1.0);
      }
      if(p > 0.0) q = -q;
      p = fabs(p);
      min1 = 3.0*xm*q-fabs(tol1*q);
      min2 = fabs(e*q);
      if(2.0*p < (min1 < min2 ? min1 : min2))
      {
        e = d;
        d = p/q;
      }
      else
      {
        d = xm;
        e = d;
      }
    }
    else
    {
      d = xm;
      e = d;
    }
    a = b;
    fa = fb;
    if(fabs(d) > tol1) b += d;
    else b += SIGN(tol1, xm);
    fb = fpNIG(b, mu, delta, alpha, beta, sp);
  }
  return 0.0;
}

void qNIG(double* p, double* i_mu, double* i_delta, double* i_alpha,
    double* i_beta, int* i_n, double* q)
{
  int i, n, counter, *pOrder;
  double mu, delta, alpha, beta, qTmp, sp, lpiv, rpiv, mpiv, div, lpivVal,
    rpivVal;
  n=*i_n; mu=*i_mu; delta=*i_delta; alpha=*i_alpha; beta=*i_beta;
  mpiv = mu+delta*beta/sqrt(alpha*alpha-beta*beta);
  div = sqrt(delta*alpha*alpha/pow(alpha*alpha-beta*beta,1.5));
  pOrder = malloc(n*sizeof(int));
  heapSort(n, p, pOrder);
  for(i=0;i<n;i++)
  {
    sp = p[pOrder[n-i-1]];
    if(p[pOrder[n-i-1]] == 0.0)
    {
      q[pOrder[n-i-1]] = -XINF;
    }
    else if(p[pOrder[n-i-1]] == 1.0)
    {
      q[pOrder[n-i-1]] = XINF;
    }
    else
    {
      lpiv = mpiv-div;
      rpiv = mpiv+div;
      counter = 0;
      if(i > 0)
      {
        lpiv = MAX(lpiv, q[pOrder[n-i]]);
        if(rpiv <= lpiv)
        {
          while(rpiv <= lpiv)
          {
            rpiv += 2*div;
          }
        }
      }
      lpivVal = fpNIG(lpiv,mu,delta,alpha,beta,sp);
      rpivVal = fpNIG(rpiv,mu,delta,alpha,beta,sp);
      if(lpivVal*rpivVal >= 0.0)
      {
        while(lpivVal*rpivVal >= 0.0)
        {
          counter++;
          lpiv = lpiv-pow(2.0, (double)counter)*div;
          rpiv = rpiv+pow(2.0, (double)counter)*div;
          lpivVal = fpNIG(lpiv,mu,delta,alpha,beta,sp);
          rpivVal = fpNIG(rpiv,mu,delta,alpha,beta,sp);
        }
      }
      qTmp = zbrent(lpiv, rpiv, mu, delta, alpha, beta, sp);
      q[pOrder[n-i-1]] = qTmp;
    }
  }
  free(pOrder);
}


