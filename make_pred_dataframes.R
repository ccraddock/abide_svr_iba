
library(ggplot2)
library(reshape2)
library(foreach)
library(doMC)
registerDoMC(16)

pheno_df=read.csv("abide_pheno.csv")
pheno_df=subset(pheno_df,(SITE_ID=="NYU") & (SUB_IN_SMP==1))

foreach( roi=110:200 ) %dopar%
{
    roi_df=read.csv(sprintf("results/%d_stats.csv",roi))
    roi_df=subset(roi_df,(train %in% pheno_df$FILE_ID) & (test %in% pheno_df$FILE_ID))

    roi_df$r_std=atanh(roi_df$pearsons.correlation)
    roi_df$diag_dir=factor(apply(roi_df[,c("train","test")],1, function(x,pdf) { paste(pdf[pdf$FILE_ID==x[1],"DX_GROUP"], pdf[pdf$FILE_ID==x[2],"DX_GROUP"] ,sep='->') }, pdf = pheno_df))
    roi_df$train_age=apply(roi_df[,c("train","test")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"AGE_AT_SCAN"] }, pdf = pheno_df)
    roi_df$del_age=apply(roi_df[,c("train","test")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"AGE_AT_SCAN"] - pdf[pdf$FILE_ID==x[2],"AGE_AT_SCAN"] }, pdf = pheno_df)
    roi_df$train_motion=apply(roi_df[,c("train","test")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"func_mean_fd"] }, pdf = pheno_df)
    roi_df$test_motion=apply(roi_df[,c("train","test")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[2],"func_mean_fd"] }, pdf = pheno_df)
    write.csv(roi_df,file=sprintf("results/%d_pred_df.csv",roi))
}
