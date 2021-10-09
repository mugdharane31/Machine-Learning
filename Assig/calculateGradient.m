function gradient = calculateGradient(x, y, theta)
% this function calculates the gradient and returns the value - this is the
% equation we derived
    yy = repmat(y, 1, size (x,2));
    funct = returnFunction(x, theta); % get the funtion
    ff = repmat(funct, 1, size (x,2));
    diff = x.* repmat(exp(-x*theta), 1, size (x,2));
    gradient = sum((1-yy ).*(x - diff.*ff) - yy.*diff.*ff)/(length(y)); %this is the equation we derived 
    gradient = gradient'; %inverse
end
