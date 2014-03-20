#ifndef NIG_H
#define NIG_H

void heapSort(int n, double *x, int *order);
double bessk1(double);
void dNIG(double* x, double* mu, double* delta, double* alpha, double* beta, int* n, double* d);
double fdNIG(double, double, double, double, double);
void intdei(double a, double mu, double delta, double alpha, double beta,double *i, double *err);
void pNIG(double *x, double *mu, double *delta, double *alpha, double *beta, int *n, double *p);
double fpNIG(double, double, double, double, double, double);
double zbrent(double, double, double, double, double,double, double);
void qNIG(double* p, double* i_mu, double* i_delta, double* i_alpha,double* i_beta, int* i_n, double* q);


#endif /* NIG_H */
