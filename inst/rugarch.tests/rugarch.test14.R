#################################################################################
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
#################################################################################

# The fiGARCH model
rugarch.test14a = function(cluster=NULL)
{
  # replicate results of paper for the SPY dataset
  data(sp500ret)
  x = as.xts(sp500ret)
  spec = ugarchspec(mean.model=list(armaOrder=c(1,1), include.mean=TRUE),
                    variance.model = list(model = "fiGARCH", garchOrder = c(1,1)),
                    distribution="norm")
  fit = ugarchfit(spec, x, solver.control=list(trace=1), fit.control=list(trunclag=2000),
                  numderiv.control=list(grad.zero.tol = 1e-9), solver="solnp")
  specx = spec
  setfixed(specx)<-as.list(coef(fit))
  filt = ugarchfilter(specx, x, n.old=nrow(x),trunclag = 2000)
  test1 = all.equal(as.numeric(sigma(fit)),as.numeric(sigma(filt)))

  cf = coef(fit)
  se = fit@fit$matcoef[,2]
  names(se) = names(cf)
  #
  benchmark.pars=c("mu"=0.000533,"ar1"=0.844162,"ma1"=-0.872833,"omega"=3.9307e-06,"alpha1"= 0.217573,"beta1"= 0.553202,
                   "delta"=0.437525)
  benchmark.se  = c("mu" = 9.4081e-005, "ar1" = 0.063690, "ma1" = 0.057052, "omega" = 4.5147e-07,
                    "alpha1" = 0.027765, "beta1" =  0.040060, "delta" = 0.028236)

  benchmark.LL = c("logL" =  17918.604)
  rugarch.LL = c("logL" =	likelihood(fit))
  rugarch.pars = c("mu"=cf["mu"],"ar1"=cf["ar1"],"ma1"=cf["ma1"],"omega"=cf["omega"],"alpha1"= cf["alpha1"],
                   "beta1"= cf["beta1"],"delta"=cf["delta"])
  rugarch.se =  c("mu"=se["mu"],"ar1"=se["ar1"],"ma1"=se["ma1"],"omega"=se["omega"],"alpha1"= se["alpha1"],
                  "beta1"= se["beta1"],"delta"=se["delta"])
  parsdf = cbind(benchmark.pars, rugarch.pars, benchmark.pars-rugarch.pars)
  sedf = cbind(benchmark.se, rugarch.se, benchmark.se-rugarch.se)

  LRE.vars = -log(abs(rugarch.pars-benchmark.pars)/abs(benchmark.pars), base = 10)
  LRE.se = -log(abs(rugarch.se-benchmark.se)/abs(benchmark.se), base = 10)
  test = cbind(LRE.vars, LRE.se)

  options(width=120)
  zz <- file("test14a-1.txt", open="wt")
  sink(zz)
  cat("\nFIGARCH GARCH model benchmark:\n")
  cat("\nparameters:\n")
  tmp = t(cbind(rugarch=rugarch.pars, benchmark=benchmark.pars))
  print(round(tmp, 4))
  cat("\nstandard errors:\n")
  tmp = t(cbind(rugarch=rugarch.se, benchmark=benchmark.se))
  print(round(tmp, 4))
  cat("\nLog Relative Error Test:\n")
  print(round(t(test), 4))
  sink(type="message")
  sink()
  close(zz)

}


rugarch.test13b = function(cluster=NULL)
{
  data(sp500ret)
  x = as.xts(sp500ret)
  spec = ugarchspec(mean.model=list(armaOrder=c(1,1), include.mean=TRUE),
                    variance.model = list(model = "fiGARCH", garchOrder = c(1,1)),
                    distribution="norm")
  fit = ugarchfit(spec, x, solver.control=list(trace=1),fit.control=list(trunclag=2000),
                  numderiv.control=list(grad.zero.tol = 1e-9), solver="solnp")
  forc = ugarchforecast(fit, n.ahead=1500)
  # plot(sigma(forc), type="l")
}

rugarch.test13c = function(cluster=NULL)
{
  data(sp500ret)
  x = as.xts(sp500ret)
  spec = ugarchspec(mean.model=list(armaOrder=c(1,1), include.mean=TRUE),
                    variance.model = list(model = "fiGARCH", garchOrder = c(1,1)),
                    distribution="norm")
  fit = ugarchfit(spec, x, solver.control=list(trace=1),fit.control=list(trunclag=2000), solver="solnp")
  sim1= ugarchsim(fit, n.sim=5000, m.sim=10, rseed=100)
  specx=spec
  setfixed(specx)<-as.list(coef(fit))
  sim2= ugarchpath(specx, n.sim=5000, m.sim=10, presigma = tail(sigma(fit),1), preresiduals = tail(residuals(fit),1),rseed = 100, trunclag = 2000)

  fx = fitted(sim)
  cf=do.call(cbind, lapply(1:100, function(i){
    fitx = try(ugarchfit(spec, as.numeric(fx[,i]), fit.control=list(trunclag=2000)))
    if(inherits(fitx,'try-error')){
      return(matrix(NA, ncol=1, nrow=7))
    }
    if(convergence(fitx)==1) return(matrix(NA, ncol=1, nrow=7))
    print(i)
    matrix(coef(fitx),ncol=1)
  }))
  rownames(cf)=names(coef(fit))
  hist(cf["delta",],breaks="fd")
  abline(v=coef(fit)["delta"], col=2)

  hist(cf["alpha1",],breaks="fd")
  abline(v=coef(fit)["alpha1"], col=2)

  hist(cf["beta1",],breaks="fd")
  abline(v=coef(fit)["beta1"], col=2)

  hist(cf["omega",],breaks="fd")
  abline(v=coef(fit)["omega"], col=2)

  hist(cf["mu",],breaks="fd")
  abline(v=coef(fit)["mu"], col=2)

  # plot(sigma(forc), type="l")
}
