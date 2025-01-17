 <!-- badges: start -->
  [![R-CMD-check](https://github.com/alexiosg/rugarch/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/alexiosg/rugarch/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->
  
# rugarch #

The rugarch package is the premier open source software for univariate GARCH modelling. It is written in R using S4 methods and classes with a significant part of the code in C and C++ for speed. It contains a number of GARCH models beyond the vanilla version including IGARCH, EGARCH, GJR, APARCH, FGARCH, Component-GARCH, multiplicative Component-GARCH for high frequency returns and the realized-GARCH model, as well as a very large number of conditional distributions including (Skew)-Normal, (Skew)-GED, (Skew)-Student (Fernandez/Steel), (Skew)-Student (GH), Normal Inverse Gaussian (NIG), Generalized Hyperbolic (GH) and Johnson?s SU (JSU). The conditional mean equation includes ARFIMA and ARCH-in-mean, and is estimated in a joint step with the GARCH model. Both the conditional mean and variance parts allow for external regressors to be used. A comprehensive set of methods to work with these models are implemented, and include estimation, filtering, forecasting, simulation, inference tests and plots, with additional functionality in the form of the GARCH bootstrap, parameter uncertainty via the GARCH distribution function, misspecification tests (Hansen's GMM and Hong & Li Portmanteau type test), predictive accuracy tests (Pesaran & Timmermann, Anatolyev  & Gerko), and Value at Risk tests (VaR Exceedances and Expected Shortfall tests).

The stable version is on [CRAN](https://CRAN.R-project.org/package=rugarch).
The development version is now on [github](https://github.com/alexiosg/rugarch).

**Update 2025: The rugarch package will no longer be updated. Maintenance for bug fixes will continue until about 2027. 
Users should switch to the new [tsgarch](https://github.com/tsmodels/tsgarch) package instead.**
