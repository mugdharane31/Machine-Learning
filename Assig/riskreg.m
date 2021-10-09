function [errTrain, model, errTest] = riskreg(xTrain, yTrain, lambda, xTest, yTest)
    
    xtx = (xTrain' * xTrain);
    model = (xTrain' * xTrain + lambda * eye(size(xtx))) \ (xTrain' * yTrain);
    errTrain = (1/(2*length(xTrain)))*(sum((yTrain - xTrain*model).^2));
    if(nargin == 5)
           errTest = (1/(2*length(xTest)))*(sum((yTest - xTest*model).^2));
    end
end