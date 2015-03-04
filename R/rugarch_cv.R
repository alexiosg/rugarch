#################################################################################
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
#################################################################################

arfimacv = function(data, indexin, indexout, 
		ar.max = 2, ma.max = 2, criterion = c("RMSE","MAE","Berkowitz"), 
		arfima = FALSE, include.mean = NULL, distribution.model = "norm",
		cluster = NULL, external.regressors = NULL, solver = "solnp", 
		solver.control=list(), fit.control=list())
{
	arnames = paste("ar", 1:ar.max, sep = "")
	manames = paste("ma", 1:ma.max, sep = "")
	.str = NULL
	if(ar.max>0){
		for(i in 1:ar.max){
			.str = c(.str, paste(arnames[i],"=c(0,1),",sep=""))
		}
	}
	if(ma.max>0){
		for(i in 1:ma.max){
			.str = c(.str, paste(manames[i],"=c(0,1),",sep=""))
		}
	}
	if(is.null(include.mean)){
		.str = c(.str, "im = c(0,1)")
	} else{
		.str = c(.str, "im = as.integer(include.mean)")
	}
	if(is.null(arfima)){
		.str = c(.str, ",arf = c(0,1)")
	} else{
		.str = c(.str, ",arf = as.integer(arfima)")
	}
	if(!is.null(external.regressors)){
		.str = c(.str, ",exreg = c(0,1)")
	} else{
		.str = c(.str, ",exreg = 0")
	}
	str = c("d = expand.grid(", paste(.str), ')')
	xstr = paste(str, sep="", collapse="")
	eval(parse(text=xstr))
	# eliminate the zero row
	check = apply(d, 1, "sum")
	if(any(check == 0)){
		idx=which(check==0)
		d = d[-idx,]
	}
	sumar = apply(d[,1:ar.max,], 1, "sum")
	summa = apply(d[,(ar.max+1):(ma.max+ar.max),], 1, "sum")
	# some checks on the indexin and indexout:
	if(!is.list(indexin)) stop("\nindexin must be a list of the training indices points")
	if(!is.list(indexout)) stop("\nindexout must be a list of the testing indices points")
	if(length(indexin)!=length(indexout)) stop("\nlength of indexin list must be the same as length of indexout list")
	
	m = length(indexin)
	n = dim(d)[1]
	
	
	clusterEvalQ(cluster, library("rugarch"))
	clusterExport(cluster, c("d", "data", "n", "solver", "external.regressors",  "distribution.model",
					"ar.max", "ma.max", "solver.control", "fit.control"), 
			envir = environment())
	fitlist = parLapply(cluster, as.list(1:m), fun = function(i){
				dout = cbind(d, matrix(NA, ncol=1, nrow=nrow(d)))
				colnames(dout)[ncol(dout)] =  criterion[1]
				if(ar.max>0){
					arr = d[i,1:ar.max]
					if(ma.max>0){
						mar = d[i,(ar.max+1):(ma.max+ar.max)]
					} else{
						mar = 0
					}
				} else{
					arr = 0
					if(ma.max>0){
						mar = d[i,1:ma.max]
					} else{
						mar = 0
					}
				}
				for(j in 1:m){
					spec = .zarfimaspec( arOrder = arr, maOrder = mar, 
							include.mean = d[i,'im'], arfima = d[i,'arf'], 
							external.regressors = xreg, distribution.model = distribution.model)
					fit = try(arfimafit(spec = spec, data = Data, solver = solver, 
									solver.control = solver.control, 
									fit.control = fit.control), silent = TRUE)
					specx<-spec
					setfixed(spec)<-as.list(coef(fit))
					forc = arfimafilter(spec, data = datax, n.old=nrow(datain))
					f = fitted(forc)[outd]
					r = data[outd]
					
				}
				return(fit)
			})
}