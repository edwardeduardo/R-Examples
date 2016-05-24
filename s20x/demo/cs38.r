data (arousal.df)
arousal.df
interactionPlots(arousal~picture+gender,data=arousal.df)
interactionPlots(arousal~gender+picture,data=arousal.df)
arousal.fit<-lm(arousal~gender+picture+gender*picture,data=arousal.df)
eovcheck(arousal.fit)
summary2way(arousal.fit,page="table")
normcheck(arousal.fit)
summary2way(arousal.fit,page="interaction")
gender.picture<-crossFactors(arousal.df$gender,arousal.df$picture)
gender.picture<-factor(gender.picture)
arousal.1way.fit<-lm(arousal.df$arousal~gender.picture)
summary1way(arousal.1way.fit)
multipleComp(arousal.1way.fit)
