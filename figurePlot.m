
%%%%%%% PLOT prediction performance of different method %%%%%%%
figure
subplot(2,2,1)
plot(Ypred,KSXpredypred,'.k','markersize',9)
hold on
%oil
x=0.5:0.1:4.2;
y=0.5:0.1:4.2;
plot(x,y,'k');
xlabel('Y')
ylabel('Ypred')
text(0.6,4.5,['RMSEP= ' num2str(KSXpredRMSEP)]);
axis([0,5,0,5])
text(0.1,5.4,'(a)')

subplot(2,2,2)
plot(Ypred,IFXpredypred,'.k','markersize',10)
hold on
%oil
x=0.5:0.1:4.2;
y=0.5:0.1:4.2;
plot(x,y,'k');
xlabel('Y')
ylabel('Ypred')
text(0.6,4.5,['RMSEP= ' num2str(IFXpredRMSEP)]);
axis([0,5,0,5])
text(0.1,5.4,'(b)')

subplot(2,2,3)
plot(Ypred,SPXpredypred,'.k','markersize',10)
hold on
%oil
x=0.5:0.1:4.2;
y=0.5:0.1:4.2;
plot(x,y,'k');
text(0.6,4.5,['RMSEP= ' num2str(SPXpredRMSEP)]);
xlabel('Y')
ylabel('Ypred')

axis([0,5,0,5])
text(0.1,5.4,'(c)')

subplot(2,2,4)
plot(Ypred,RSXpredypred,'.k','markersize',10)
hold on
%oil
x=0.5:0.1:4.2;
y=0.5:0.1:4.2;
plot(x,y,'k');
xlabel('Y')
ylabel('Ypred')
text(0.6,4.5,['RMSEP= ' num2str(RSXpredRMSEP)]);
axis([0,5,0,5])
text(0.1,5.4,'(d)')

%%%%%%%%%plot distribution of calibration and validation set %%%%%%%%
[T,~]=apca(X,1,5);
figure
subplot(2,2,1)
plot(T(ind1(KS_m,:),1),T(ind1(KS_m,:),2),'*')
%index=ind1(KS_m);
%text(T(ind1(KS_m),1),T(ind1(KS_m),2),num2str(index));
hold on
plot(T(ind1(KS_n),1),T(ind1(KS_n),2),'r.','markersize',10)
%index=ind1(KS_n);
%text(T(ind1(KS_n),1),T(ind1(KS_n),2),num2str(index));
xlabel('PC1','FontSize',10)
ylabel('PC2','FontSize',10)
axis([-3,2,-0.7,0.7])
text(-2.9,0.80,'(a)')

subplot(2,2,2)
plot(T(ind1(IF_m,:),1),T(ind1(IF_m,:),2),'*')
%index=ind1(IF_m);
%text(T(ind1(IF_m),1),T(ind1(IF_m),2),num2str(index));
hold on
plot(T(ind1(IF_n),1),T(ind1(IF_n),2),'r.','markersize',10)
% index=ind1(IF_n);
% text(T(ind1(IF_n),1),T(ind1(IF_n),2),num2str(index));
hold on 
plot(T(ind1(52,:),1),T(ind1(52,:),2),'mp')
xlabel('PC1','FontSize',10)
ylabel('PC2','FontSize',10)
axis([-3,2,-0.7,0.7])
text(-2.9,0.80,'(b)')

subplot(2,2,3)
plot(T(ind1(SP_m,:),1),T(ind1(SP_m,:),2),'*')
%index=ind1(SP_m);
%text(T(ind1(SP_m),1),T(ind1(SP_m),2),num2str(index));
hold on
plot(T(ind1(SP_n),1),T(ind1(SP_n),2),'r.','markersize',10)
%index=ind1(SP_n);
%text(T(ind1(SP_n),1),T(ind1(SP_n),2),num2str(index));
xlabel('PC1','FontSize',10)
ylabel('PC2','FontSize',10)
axis([-3,2,-0.7,0.7])
text(-2.9,0.80,'(c)')

subplot(2,2,4)
plot(T(ind1(RS_m,:),1),T(ind1(RS_m,:),2),'*')
%index=ind1(RS_m);
%text(T(ind1(RS_m),1),T(ind1(RS_m),2),num2str(index));
hold on
plot(T(ind1(RS_n),1),T(ind1(RS_n),2),'r.','markersize',10)
%index=ind1(RS_n);
%text(T(ind1(RS_n),1),T(ind1(RS_n),2),num2str(index));
xlabel('PC1','FontSize',10)
ylabel('PC2','FontSize',10)
axis([-3,2,-0.7,0.7])
text(-2.9,0.80,'(d)')

%%%%%%%%% plot detected outlier by different method %%%%%
[S,ind]=sort(outF,'descend');
m1=ind(S>=0.5,:);
m2=ind(S<0.5,:);
CV=plscvfold(X1,Y1,15,10,'center',0);
A=CV.optPC; 
F=mcs(X1,Y1,A);

figure
subplot(2,1,1)
k=1:52;
plot(S,'k.','markersize',10)
hold on 
axis([0,52,0.35,0.9])
h=line([0 52],[0.50 0.50],'color','k','linestyle','--');
text(2,0.80,'52')
xlabel('sample')
ylabel('IOS score')

subplot(2,1,2)
plotmcs(F)