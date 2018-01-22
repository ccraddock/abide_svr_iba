require(multcomp)
require(lmerTest)
 
load('lme_res.Rdata')

pred.diff = rep.diff = list()
for (roi in 1:200){
    pred.diff[[roi]] = difflsmeans(outstats[[roi]][[2]], test.effs='diag_dir')[[1]]
    rep.diff[[roi]] = difflsmeans(outstats[[roi]][[5]], test.effs='diag_dir')[[1]]
}

pred.c1.coef =  list()
pred.c1.pval =  list()
 
pred.c2.coef =  list()
pred.c2.pval =  list()

c1 = c(0,1,-1,-1,0,0,0,0) # (1->1 + 1->2) - (2->1 + 2->2)
c2 = c(0,-1,1,-1,0,0,0,0) # (1->1 + 2->1) - (1->2 + 2->2)
 
mycontrast = rbind(c1,c2)

for (roi in 1:200){
  res=summary(glht(outstats[[roi]][[2]], linfct=mycontrast))

  if( roi == 1)
  {
    pred.c1.coef=res$test$coef[[1]]
    pred.c1.pval=res$test$pvalues[[1]]

    pred.c2.coef=res$test$coef[[2]]
    pred.c2.pval=res$test$pvalues[[2]]
  }
  else
  {
    pred.c1.coef=c(pred.c1.coef,res$test$coef[[1]])
    pred.c1.pval=c(pred.c1.pval,res$test$pvalues[[1]])

    pred.c2.coef=c(pred.c2.coef,res$test$coef[[2]])
    pred.c2.pval=c(pred.c2.pval,res$test$pvalues[[2]])
  }
}

pred.c1.qval=p.adjust(pred.c1.pval,method="fdr")
pred.c1.zval=qnorm(1-pred.c1.qval/2)*sign(pred.c1.coef)
pred.c2.qval=p.adjust(pred.c2.pval,method="fdr")
pred.c2.zval=qnorm(1-pred.c2.qval/2)*sign(pred.c2.coef)

for (roi in 1:200){
  if( roi == 1)
  {
    pred.c3.coef=pred.diff[[roi]][1,4]
    pred.c3.pval=pred.diff[[roi]][1,7]

    pred.c4.coef=pred.diff[[roi]][2,4]
    pred.c4.pval=pred.diff[[roi]][2,7]

    pred.c5.coef=pred.diff[[roi]][5,4]
    pred.c5.pval=pred.diff[[roi]][5,7]

    pred.c6.coef=pred.diff[[roi]][6,4]
    pred.c6.pval=pred.diff[[roi]][6,7]
  }
  else
  {
    pred.c3.coef=c(pred.c3.coef,pred.diff[[roi]][1,4])
    pred.c3.pval=c(pred.c3.pval,pred.diff[[roi]][1,7])

    pred.c4.coef=c(pred.c4.coef,pred.diff[[roi]][2,4])
    pred.c4.pval=c(pred.c4.pval,pred.diff[[roi]][2,7])

    pred.c5.coef=c(pred.c5.coef,pred.diff[[roi]][5,4])
    pred.c5.pval=c(pred.c5.pval,pred.diff[[roi]][5,7])

    pred.c6.coef=c(pred.c6.coef,pred.diff[[roi]][6,4])
    pred.c6.pval=c(pred.c6.pval,pred.diff[[roi]][6,7])
  }
}

pred.c3.qval=p.adjust(pred.c3.pval,method="fdr")
pred.c3.zval=qnorm(1-pred.c3.qval/2)*sign(pred.c3.coef)
pred.c4.qval=p.adjust(pred.c4.pval,method="fdr")
pred.c4.zval=qnorm(1-pred.c4.qval/2)*sign(pred.c4.coef)
pred.c5.qval=p.adjust(pred.c5.pval,method="fdr")
pred.c5.zval=qnorm(1-pred.c5.qval/2)*sign(pred.c5.coef)
pred.c6.qval=p.adjust(pred.c6.pval,method="fdr")
pred.c6.zval=qnorm(1-pred.c6.qval/2)*sign(pred.c6.coef)

stats_df=data.frame(roi=seq(1,200),c1=pred.c1.zval,c2=pred.c2.zval,
    c3=pred.c3.zval,c4=pred.c4.zval,c5=pred.c5.zval,c6=pred.c6.zval)

write.csv(stats_df,file="pred_stats.csv")
