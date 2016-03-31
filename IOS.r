setwd("E:\\postgraduate\\iForest\\R_IForest\\Data\\IOS")
library(R.matlab)
library(IsolationForest)
data <- readMat('E:\\postgraduate\\iForest\\R_IForest\\Data\\IOS\\fat1.mat')
X1=data$X1
X <- as.data.frame(X1)
outF=matrix(nrow=52,ncol=5)
for (i in 1:5){
	tr<-IsolationTrees(X,ntree=1000,rFactor=1)
	as<-AnomalyScore(X,tr)
	outF[,i]=as$outF
	df <- data.frame(outF)
	write.table(df, file='outF1.txt')
}