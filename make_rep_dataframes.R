
library(ggplot2)
library(reshape2)
library(foreach)
library(doMC)
registerDoMC(16)

pheno_df=read.csv("abide_pheno.csv")
pheno_df=subset(pheno_df,(SITE_ID=="NYU") & (SUB_IN_SMP==1))

foreach( roi=1:200 ) %dopar%
{
    roi_df=read.csv(sprintf("results/%d_rep_stats.csv",roi))
    roi_df=subset(roi_df,(train %in% pheno_df$FILE_ID) & (test %in% pheno_df$FILE_ID))

    roi_df$r_std=atanh(roi_df$pearsons.correlation)

    roi_df$id1=factor(apply(roi_df[,c("train","test")],1,function(x) { if (x[1] < x[2] ) x[1] else x[2] } ))
    roi_df$id2=factor(apply(roi_df[,c("train","test")],1,function(x) { if (x[1] < x[2] ) x[2] else x[1] } ))

    #drop train and test, they no longer have meaning
    roi_df=roi_df[,c('id1','id2','roi','pearsons.correlation','r_std')]

    roi_df$diag_dir=factor(apply(roi_df[,c("id1","id2")],1, function(x,pdf) { paste(pdf[pdf$FILE_ID==x[1],"DX_GROUP"], pdf[pdf$FILE_ID==x[2],"DX_GROUP"] ,sep='<->') }, pdf = pheno_df))
    roi_df$train_age=apply(roi_df[,c("id1","id2")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"AGE_AT_SCAN"] }, pdf = pheno_df)
    roi_df$del_age=apply(roi_df[,c("id1","id2")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"AGE_AT_SCAN"] - pdf[pdf$FILE_ID==x[2],"AGE_AT_SCAN"] }, pdf = pheno_df)
    roi_df$id1_motion=apply(roi_df[,c("id1","id2")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[1],"func_mean_fd"] }, pdf = pheno_df)
    roi_df$id2_motion=apply(roi_df[,c("id1","id2")],1, function(x,pdf) { pdf[pdf$FILE_ID==x[2],"func_mean_fd"] }, pdf = pheno_df)

    # now drop the duplicated rows
    roi_df=unique(roi_df)

    write.csv(roi_df,file=sprintf("results/%d_rep_df.csv",roi))
}
