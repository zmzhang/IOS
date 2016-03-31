%#											
%# function [Xcal,Xtest,Ycal,Ytest,ind1,ind2] = randsel(X,n1,Y);					
%#											
%# AIM:		Random subset selection.						
%#											
%# PRINCIPLE:	Samples from a data set are randomly selected to create two subsets. 	
%#		(For example a training and a test set).				
%#											
%# INPUT:	x (m x n) : 	Original matrix of independent variables (Each row is 	
%#			    	a sample).						
%#		n1 : 		Number of samples in subset 1.				
%#		y (m x nresp) :	Original matrix of responses. (If not available 	
%#				enter []).						
%#											
%# OUTPUT:	x1 (m1 x n) : 	Matrix of dependent variables, subset 1. 		
%#		x2 (m2 x n) : 	Matrix of dependent variables, subset 2.		
%#		ind1 (m1 x 1) : Indices of samples in subset 1.				
%#		ind2 (m2 x 1) : Indices of samples in subset 2.				
%#		y1 (m1 x nresp) : Vector of responses, subset 1. 			
%#		y2 (m2 x nresp) : Vector of responses, subset 2. 					
%#											
%# AUTHOR:	Frederic Despagne							
%#		Copyright(c) 1997 for ChemoAC						
%#		Dienst FABI, Vrije Universiteit Brussel					
%#		Laarbeeklaan 103, 1090 Jette						
%#											
%# VERSION: 1.1 (28/02/98)								
%#									
%# TEST:	Krzysztof Szczubialka							
%#											

function [Xcal,Xtest,Ycal,Ytest,ind1,ind2] = randsel(X,n1,Y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(X,1);	% Number of samples

if nargin < 2
	error('The number of samples in the first subset must be specified')
end

t0=clock;
randseed=sum(100*t0(:,1:6));	% A vector that changes every second.
rand('seed',randseed); 		% Sets the seed of the random number generator to "randseed".


%%%%%%%%%%%%%%%%%%%%%%%%%%%% DETERMINATION OF INDICES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indices = randperm(m)';		% Random permutation of sample numbers
ind1 = indices(1:n1);		% Indices, subset 1
ind2 = indices(n1+1:m);		% Indices, subset 2


%%%%%%%%%%%%%%%%%%%%%%% SPLITTING OF INDEPENDENT VARIABLES MATRIX %%%%%%%%%%%%%%%%%%%%%%%%%

Xcal = X(ind1,:);			% Matrix of independent variables, subset 1
Xtest = X(ind2,:);			% Matrix of independent variables, subset 2

	
%%%%%%%%%%%%%%%%%%%%%%%% SPLITTING OF RESPONSE VECTOR (OPTIONAL) %%%%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(Y)
	Ycal = [];		% Returns empty vectors if Y is not available
	Ytest = [];
else
	Ycal = Y(ind1,:);		% Matrix of dependent variables, subset 1
	Ytest = Y(ind2,:);		% Matrix of dependent variables, subset 2
end
