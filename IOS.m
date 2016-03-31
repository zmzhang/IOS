function [Xtrain,Xtest,Ytrain,Ytest,vSelectedSample,vNotSelectedSample,outlier] = IOS(X,Y,mtrain,outF)
[S,ind]=sort(outF,'descend');
figure
plot(S,'k.','markersize',10)
k=length(S);
axis([0,k,0.35,0.9])
h=line([0 k],[0.50 0.50],'color','k','linestyle','--');
xlabel('sample')
ylabel('IOS score')
input('Choose the outlier IOS score value?');
OT=ans;
if OT~=1
    m1=ind(S>=0.5&S<OT,:);
    m2=ind(S<0.5,:);
    m3=ind(S>=OT,:);
    outlier=m3;
else
    m1=ind(S>=0.5,:);
    m2=ind(S<0.5,:);
    outlier=[];
end
if mtrain<length(m1)
    vSelectedSample = m1(1:mtrain);
    vNotSelectedSample = [m2(mtrain+1:end);m2];
else 
    mtrain2=mtrain-length(m1);
    ss=linspace(1,length(m2),mtrain2);
    mm=1:length(m2);
    ind11=roundn(ss,0);
    mm(ind11)=[];
    ind22=mm;
    vSelectedSample = [m1;m2(ind11)];
    vNotSelectedSample = m2(ind22);
end
Xtrain=X(vSelectedSample,:);Ytrain=Y(vSelectedSample,:);
Xtest=X(vNotSelectedSample,:);Ytest=Y(vNotSelectedSample,:);


