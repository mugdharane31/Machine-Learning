function [errTrain,model,errTest] = polyreg(xTrain,yTrain,dimension,xTest,yTest)
%
% Finds a D-1 order polynomial fit to the data
%
%    function [errTrain,model,errTest] = polyreg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% errTrain = average squared loss on training
% model = vector of polynomial parameter coefficients
% errTest = average squared loss on testing
%
% Example Usage:
%
% x = 3*(rand(50,1)-0.5);
% y = x.*x.*x-x+rand(size(x));
% [errTrain,model] = polyreg(x,y,4);
%

xx = zeros(length(xTrain),dimension);
for i=1:dimension
  xx(:,i) = xTrain.^(dimension-i);
end
model = pinv(xx)*yTrain; #hypothesis
errTrain   = (1/(2*length(xTrain)))*sum((yTrain-xx*model).^2); #emperical risk

if (nargin==5)
  xxT = zeros(length(xTest),dimension);
  for i=1:dimension
    xxT(:,i) = xTest.^(dimension-i);
  end
  errTest  = (1/(2*length(xTest)))*sum((yTest-xxT*model).^2);
end

q  = (min(xTrain):(max(xTrain)/300):max(xTrain))';
qq = zeros(length(q),dimension);
for i=1:dimension
  qq(:,i) = q.^(dimension-i);
end

clf
plot(xTrain,yTrain,'X');
hold on
if (nargin==5)
    plot(xTest,yTest,'cO');
end
plot(q,qq*model,'r')
title('Dimension :' , num2str(dimension), 'FontSize', 8)
legend('Training Data', 'Testing Data', 'Model');
