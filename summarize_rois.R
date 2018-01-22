library(ggplot2)
library(reshape2)

for (roi in 1:200)
{
    pred_df=read.csv(sprintf("result_dframes/%d_pred_df.csv",roi))
    sum=ddply(pred_df,.(diag_dir),summarize,roi=median(roi),
        mean=mean(r_std,na.rm=TRUE),sd=sd(r_std,na.rm=TRUE),
	median=median(r_std,na.rm=TRUE),
	quan_25=quantile(r_std,probs=c(.25),na.rm=TRUE),
	quan_75=quantile(r_std,probs=c(.75),na.rm=TRUE))
    if(roi == 1)
    {
        pred_df_sum=sum
    }
    else
    {
	pred_df_sum=rbind(pred_df_sum,sum)
    }
}

for (roi in 1:200)
{
    rep_df=read.csv(sprintf("result_dframes/%d_rep_df.csv",roi))
    sum=ddply(rep_df,.(diag_dir),summarize,roi=median(roi),
        mean=mean(r_std,na.rm=TRUE),sd=sd(r_std,na.rm=TRUE),
	median=median(r_std,na.rm=TRUE),
	quan_25=quantile(r_std,probs=c(.25),na.rm=TRUE),
	quan_75=quantile(r_std,probs=c(.75),na.rm=TRUE))
    if(roi == 1)
    {
        rep_df_sum=sum
    }
    else
    {
	rep_df_sum=rbind(rep_df_sum,sum)
    }
}

rm(list=c('pred_df','rep_df','sum'))
save(list=c('rep_df_sum','pred_df_sum'),file="res_df_summary.Rdata")
