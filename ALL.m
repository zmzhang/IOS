%%%%%%%% Randomly select samples as prediction set %%%%%
load('fat_tfs.mat')
xo=X(17,:);
yo=y(17,:);
X(17,:)=[];
y(17,:)=[];
[Xcal,Xpred,Ycal,Ypred,ind1,ind2] = randsel(X,51,y);
X1=[Xcal;xo];Y1=[Ycal;yo];
ind1=[ind1;67];
X=[X;xo];Y=[y;yo];
save fat1
%%%%%%% %%%%%%% %%%%%%%  %%%%%%%% 
%%% GO TO R AND GET IOS SCORE %%%
%%%%%%% %%%%%%% %%%%%%% %%%%%%%%%

