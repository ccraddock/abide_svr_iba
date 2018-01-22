require(nlme)
require(lmerTest)

library(ggplot2)
library(reshape2)
library(foreach)
library(doMC)

registerDoMC(1)
 
pred.mylme = rep.mylme = list()
pred.pvalue = rep.pvalue = list()
pred.coeff = rep.coeff = list()
foreach (roi=1:200) %dopar% {
    print(sprintf("processing %d",roi))
    pred = read.csv(sprintf('result_dframes/%d_pred_df.csv',roi))
    pred.mylme[[roi]] = lmer(r_std ~ diag_dir + train_age +
        del_age + train_motion + test_motion + (1|test) +(1|train), data=pred)
    pred.pvalue[[roi]] = coef(summary(pred.mylme[[roi]]))[,5] # [['p-value']]
    pred.coeff[[roi]] = fixed.effects(pred.mylme[[roi]])
 
    rep = read.csv(sprintf('result_dframes/%d_rep_df.csv',roi))
    rep.mylme[[roi]]  =  lmer(r_std ~ diag_dir + train_age +
        del_age + id1_motion + id2_motion +(1|id1) +(1|id2), data=rep)
    rep.pvalue[[roi]] = coef(summary(rep.mylme[[roi]]))[,5]
    rep.coeff[[roi]] = fixed.effects(rep.mylme[[roi]])
}
 
save(list=ls(),file='lme_res.Rdata')
