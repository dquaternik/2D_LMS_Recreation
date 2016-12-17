function [outputImage, errorImage, coefficientBlock] = TWDLMS(input,desired,S)

% This performs one step of the 2D LMS. 

% Output image, output at each iteration. 3D (m,n,nIterations)
% Error image, error at each iteration. 3D (m,n,nIterations)
% CoefficientBlock, weight matrix at each iteration 3D (m,n,nIterations)

% Desired: the image we want
% input: Image with gaussian noise added over top
% S: Structure with 
%   -step: Convergence factor (mu)
%   -filterOrderNo: square root of total number of weights
%   -initialCoefs: Initial weight matrix 2D.

% Testing without prefixed zeros on the input

nCoefficients = S.filterOrderNo+1;
[nIterationsm,nIterationsn] = size(input);
nIterations = nIterationsm*nIterationsn;

% Pre-allocations
errorImage = zeros(nIterationsm, nIterationsn);
outputImage = zeros(nIterationsm, nIterationsn);
coefficientBlock = zeros(nCoefficients,nCoefficients,nIterations);
itCount = 1;

% Initial state of the weight vector

coefficientBlock(:,:,1) = S.initialCoefficients;

% Prefixed input
prefixedimage = input;

prefixedimage(:,(nIterationsn+1):(nIterationsn+S.filterOrderNo)) = 0;
prefixedimage((nIterationsm+1):(nIterationsm+S.filterOrderNo),:) = 0;


% Body

for i1 = 1:nIterationsm
    for i2 = 1:nIterationsn
        
        regressor = prefixedimage(i1+(nCoefficients-1):-1:i1, i2+(nCoefficients-1):-1:i2);
        
        ex1 = coefficientBlock(:,:,itCount).*regressor;
        
        outputImage(i1,i2) = sum(ex1(:));
        
        errorImage(i1,i2) = desired(i1,i2) - outputImage(i1,i2);
        
        coefficientBlock(:,:,itCount+1) = coefficientBlock(:,:,itCount) + (2*S.step*errorImage(i1,i2)*regressor);
        
        itCount = itCount+1;
    end
end
