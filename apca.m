function [score,loading]=apca(raw,centr,max);


%	[T,P]=apca(raw,0,max);
%
%	The Matlab routine perform a pca analysis of the data 
%	
%	Uses singular value decomposition (svd)
% 	raw - data matrix
% 	Data must exist as objects*variables
%  centr=1, centering data (column by column)
% 	centr=0, data is not centered
%	max - max number of components to be presented 
%	
% 	Information regarding the principal components will be given as
%	PC #	Egenverdi	%var	%totvar
%
%	Laila Stordrange 16/10-00
%


[m,n]=size(raw);

%	Centering the matrix
gj=mean(raw);
if centr==1;
	raw=raw - ones(m,1)*gj;
end;

%	Calculation of principal components
if n<m 	% More objects than variables 
   cov=(raw'*raw);	%/m-1;	
   [u,s,v]=svd(cov);
   temp2=(1:n)';
   
else
   cov=(raw*raw');	%/m-1;
   [u,s,v]=svd(cov);
   v=raw'*v; 	% Calculate loadings   
   for i=1:m
      v(:,i)=v(:,i)/norm(v(:,i)); %Normalize the loadings
   end
   temp2=(1:m)';
   
end

temp = (diag(s)*100)./(sum(diag(s)));

ssq = [temp2 diag(s) temp cumsum(temp)];

% Remove uninteresting components from the presentation
info=zeros(max,4);
for i=1:max
   info(i,:)=ssq(i,:);
end

% Presentation of the calculated components
disp('	')
disp('	Percent explained by the PCA model')
disp('	')
disp(' PC#  Eigenvalues  %Variance  %TotVar')
info=num2str(info);
disp(info)

% Ask how many components to be made
lv=max+1;

while lv>max
   input('How many principal components would you like to keep?');
   lv=ans;
end

% Makes the PCA model by means of the information given above
loading=v(:,1:lv);
score=raw*loading;
loading=loading';

% Saving of the interesting components, only 
z=zeros(lv,4);
for i=1:lv
   z(i,:)=ssq(i,:);
end
info=z;

% End

   
   
