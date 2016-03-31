%%%%%%% Compare the prediction performance of different subset selection method%%%%%%% 
mtrain=37;mtest=15;
%%%%%%%  KS Split %%%%%%%%%
[KSXtrain,KSXtest,KSYtrain,KSYtest,KSvSelectedSample,KSvNotSelectedSample]=ks1(X1,Y1,mtrain);
KS_m=KSvSelectedSample;KS_n=KSvNotSelectedSample;

KSCV=plscvfold(KSXtrain,KSYtrain,15,10,'center',0);
A1=KSCV.optPC; 
KSPLS=pls(KSXtrain,KSYtrain,A1,'center');
KSXtest_expand=[KSXtest ones(size(KSXtest,1),1)];
coef=KSPLS.coef_origin;
KSXtestypred=KSXtest_expand*coef(:,end);
%Performance of calibration and validation sample set
KSXtestSST_F=sum((KSYtest-mean(KSYtest)).^2);  
KSXtestSST_R=sum((KSYtest-mean(KSYtrain)).^2);  
KSXtestSSR=sum((KSXtestypred-mean(KSYtest)).^2);  
KSXtestSSE_F=sum((KSYtest-KSXtestypred).^2);  
KSR2=KSPLS.R2; 
KSXtestQ2_ext=1-KSXtestSSE_F/KSXtestSST_R;
KSQ2=KSCV.Q2_max;
KSXtestRMSEF=sqrt(KSPLS.SSE/size(KSXtrain,1));
KSXtestRMSEP=sqrt(KSXtestSSE_F/size(KSXtest,1));

KSXtestypred_test = [KSXtestypred,KSYtest];


KSXpred_expand=[Xpred ones(size(Xpred ,1),1)];
coef=KSPLS.coef_origin;
KSXpredypred=KSXpred_expand*coef(:,end);
%Performance of prediction sample set
KSXpredSST_F=sum((Ypred-mean(Ypred)).^2);  
KSXpredSST_R=sum((Ypred-mean(KSYtrain)).^2);  
KSXpredSSR=sum((KSXpredypred-mean(Ypred)).^2);  
KSXpredSSE_F=sum((Ypred-KSXpredypred).^2);  
KSR2=KSPLS.R2; 
KSXpredQ2_ext=1-KSXpredSSE_F/KSXpredSST_R;
KSQ2=KSCV.Q2_max;
KSXpredRMSEF=sqrt(KSPLS.SSE/size(KSXtrain,1));
KSXpredRMSEP=sqrt(KSXpredSSE_F/size(Xpred,1));

KSXpredypred_Ypred = [KSXpredypred,Ypred];


%%%%%%%  Iforest Split %%%%%%%%%
Input=importdata('outF1.txt');
outF1=Input.data;
outF=(mean(outF1'))';
[IFXtrain,IFXtest,IFYtrain,IFYtest,IFvSelectedSample,IFvNotSelectedSample,IFoutlier] = IOS(X1,Y1,mtrain,outF);
IF_m=IFvSelectedSample;IF_n=IFvNotSelectedSample;

IFCV=plscvfold(IFXtrain,IFYtrain,15,10,'center',0);
A1=IFCV.optPC; 
IFPLS=pls(IFXtrain,IFYtrain,A1,'center');
IFXtest_expand=[IFXtest ones(size(IFXtest,1),1)];
coef=IFPLS.coef_origin;
IFXtestypred=IFXtest_expand*coef(:,end);
%Performance of calibration and validation sample set
IFXtestSST_F=sum((IFYtest-mean(IFYtest)).^2);  
IFXtestSST_R=sum((IFYtest-mean(IFYtrain)).^2);  
IFXtestSSR=sum((IFXtestypred-mean(IFYtest)).^2);  
IFXtestSSE_F=sum((IFYtest-IFXtestypred).^2);  
IFR2=IFPLS.R2; 
IFXtestQ2_ext=1-IFXtestSSE_F/IFXtestSST_R;
IFQ2=IFCV.Q2_max;
IFXtestRMSEF=sqrt(IFPLS.SSE/size(IFXtrain,1));
IFXtestRMSEP=sqrt(IFXtestSSE_F/size(IFXtest,1));

IFXtestypred_test = [IFXtestypred,IFYtest];


IFXpred_expand=[Xpred ones(size(Xpred ,1),1)];
coef=IFPLS.coef_origin;
IFXpredypred=IFXpred_expand*coef(:,end);
%Performance of prediction sample set
IFXpredSST_F=sum((Ypred-mean(Ypred)).^2);  
IFXpredSST_R=sum((Ypred-mean(IFYtrain)).^2);  
IFXpredSSR=sum((IFXpredypred-mean(Ypred)).^2);  
IFXpredSSE_F=sum((Ypred-IFXpredypred).^2);  
IFR2=IFPLS.R2; 
IFXpredQ2_ext=1-IFXpredSSE_F/IFXpredSST_R;
IFQ2=IFCV.Q2_max;
IFXpredRMSEF=sqrt(IFPLS.SSE/size(IFXtrain,1));
IFXpredRMSEP=sqrt(IFXpredSSE_F/size(Xpred,1));

IFXpredypred_Ypred = [IFXpredypred,Ypred];


%%%%%%%  SPXY Split %%%%%%%%%
[SPXtrain,SPXtest,SPYtrain,SPYtest,SPvSelectedSample,SPvNotSelectedSample]=spxy(X1,Y1,mtrain);
SP_m=SPvSelectedSample;SP_n=SPvNotSelectedSample;

SPCV=plscvfold(SPXtrain,SPYtrain,15,10,'center',0);
A1=SPCV.optPC; 
SPPLS=pls(SPXtrain,SPYtrain,A1,'center');
SPXtest_expand=[SPXtest ones(size(SPXtest,1),1)];
coef=SPPLS.coef_origin;
SPXtestypred=SPXtest_expand*coef(:,end);
%Performance of calibration and validation sample set
SPXtestSST_F=sum((SPYtest-mean(SPYtest)).^2);  
SPXtestSST_R=sum((SPYtest-mean(SPYtrain)).^2);  
SPXtestSSR=sum((SPXtestypred-mean(SPYtest)).^2);  
SPXtestSSE_F=sum((SPYtest-SPXtestypred).^2);  
SPR2=SPPLS.R2; 
SPXtestQ2_ext=1-SPXtestSSE_F/SPXtestSST_R;
SPQ2=SPCV.Q2_max;
SPXtestRMSEF=sqrt(SPPLS.SSE/size(SPXtrain,1));
SPXtestRMSEP=sqrt(SPXtestSSE_F/size(SPXtest,1));

SPXtestypred_test = [SPXtestypred,SPYtest];


SPXpred_expand=[Xpred ones(size(Xpred ,1),1)];
coef=SPPLS.coef_origin;
SPXpredypred=SPXpred_expand*coef(:,end);
%Performance of prediction sample set
SPXpredSST_F=sum((Ypred-mean(Ypred)).^2);  
SPXpredSST_R=sum((Ypred-mean(SPYtrain)).^2);  
SPXpredSSR=sum((SPXpredypred-mean(Ypred)).^2);  
SPXpredSSE_F=sum((Ypred-SPXpredypred).^2);  
SPR2=SPPLS.R2; 
SPXpredQ2_ext=1-SPXpredSSE_F/SPXpredSST_R;
SPQ2=SPCV.Q2_max;
SPXpredRMSEF=sqrt(SPPLS.SSE/size(SPXtrain,1));
SPXpredRMSEP=sqrt(SPXpredSSE_F/size(Xpred,1));

SPXpredypred_Ypred = [SPXpredypred,Ypred];


%%%%%%%  RS Split %%%%%%%%%
[RSXtrain,RSXtest,RSYtrain,RSYtest,RSvSelectedSample,RSvNotSelectedSample] = randsel(X1,mtrain,Y1);
RS_m=RSvSelectedSample;RS_n=RSvNotSelectedSample;

RSCV=plscvfold(RSXtrain,RSYtrain,15,10,'center',0);
A1=RSCV.optPC; 
RSPLS=pls(RSXtrain,RSYtrain,A1,'center');
RSXtest_expand=[RSXtest ones(size(RSXtest,1),1)];
coef=RSPLS.coef_origin;
RSXtestypred=RSXtest_expand*coef(:,end);
%Performance of calibration and validation sample set
RSXtestSST_F=sum((RSYtest-mean(RSYtest)).^2);  
RSXtestSST_R=sum((RSYtest-mean(RSYtrain)).^2);  
RSXtestSSR=sum((RSXtestypred-mean(RSYtest)).^2);  
RSXtestSSE_F=sum((RSYtest-RSXtestypred).^2);  
RSR2=RSPLS.R2; 
RSXtestQ2_ext=1-RSXtestSSE_F/RSXtestSST_R;
RSQ2=RSCV.Q2_max;
RSXtestRMSEF=sqrt(RSPLS.SSE/size(RSXtrain,1));
RSXtestRMSEP=sqrt(RSXtestSSE_F/size(RSXtest,1));

RSXtestypred_test = [RSXtestypred,RSYtest];


RSXpred_expand=[Xpred ones(size(Xpred ,1),1)];
coef=RSPLS.coef_origin;
RSXpredypred=RSXpred_expand*coef(:,end);
%Performance of prediction sample set
RSXpredSST_F=sum((Ypred-mean(Ypred)).^2);  
RSXpredSST_R=sum((Ypred-mean(RSYtrain)).^2);  
RSXpredSSR=sum((RSXpredypred-mean(Ypred)).^2);  
RSXpredSSE_F=sum((Ypred-RSXpredypred).^2);  
RSR2=RSPLS.R2; 
RSXpredQ2_ext=1-RSXpredSSE_F/RSXpredSST_R;
RSQ2=RSCV.Q2_max;
RSXpredRMSEF=sqrt(RSPLS.SSE/size(RSXtrain,1));
RSXpredRMSEP=sqrt(RSXpredSSE_F/size(Xpred,1));

RSXpredypred_Ypred = [RSXpredypred,Ypred];



%%%%%%% Result %%%%%%%%%
Result.ind1=ind1;
Result.ind2=ind2;
Result.KS_m=KS_m;
Result.KS_n=KS_n;
Result.KSXtestQ2_ext=KSXtestQ2_ext;
Result.KSXtestRMSEF=KSXtestRMSEF;
Result.KSXtestRMSEP=KSXtestRMSEP;
Result.KSXpredQ2_ext=KSXpredQ2_ext;
Result.KSXpredRMSEF=KSXpredRMSEF;
Result.KSXpredRMSEP=KSXpredRMSEP;
Result.KSXtestypred_test=KSXtestypred_test;
Result.KSXpredypred_Ypred=KSXpredypred_Ypred;

Result.IF_m=IF_m;
Result.IF_n=IF_n;
Result.IFXtestQ2_ext=IFXtestQ2_ext;
Result.IFXtestRMSEF=IFXtestRMSEF;
Result.IFXtestRMSEP=IFXtestRMSEP;
Result.IFXpredQ2_ext=IFXpredQ2_ext;
Result.IFXpredRMSEF=IFXpredRMSEF;
Result.IFXpredRMSEP=IFXpredRMSEP;
Result.IFXtestypred_test=IFXtestypred_test;
Result.IFXpredypred_Ypred=IFXpredypred_Ypred;

Result.SP_m=SP_m;
Result.SP_n=SP_n;
Result.SPXtestQ2_ext=SPXtestQ2_ext;
Result.SPXtestRMSEF=SPXtestRMSEF;
Result.SPXtestRMSEP=SPXtestRMSEP;
Result.SPXpredQ2_ext=SPXpredQ2_ext;
Result.SPXpredRMSEF=SPXpredRMSEF;
Result.SPXpredRMSEP=SPXpredRMSEP;
Result.SPXtestypred_test=SPXtestypred_test;
Result.SPXpredypred_Ypred=SPXpredypred_Ypred;

Result.RS_m=RS_m;
Result.RS_n=RS_n;
Result.RSXtestQ2_ext=RSXtestQ2_ext;
Result.RSXtestRMSEF=RSXtestRMSEF;
Result.RSXtestRMSEP=RSXtestRMSEP;
Result.RSXpredQ2_ext=RSXpredQ2_ext;
Result.RSXpredRMSEF=RSXpredRMSEF;
Result.RSXpredRMSEP=RSXpredRMSEP;
Result.RSXtestypred_test=RSXtestypred_test;
Result.RSXpredypred_Ypred=RSXpredypred_Ypred;

Result.pred=[KSXpredRMSEP',IFXpredRMSEP',SPXpredRMSEP',RSXpredRMSEP'];
Result.test=[KSXtestRMSEP',IFXtestRMSEP',SPXtestRMSEP',RSXtestRMSEP'];

