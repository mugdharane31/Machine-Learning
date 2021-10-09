function problem2(filename)
    load(filename); % this loads the dataset from the file
    
    %divide the dataset test and train
    [length,~] = size(x); % get the size of the dataset to be used for crossfold
    idenx = crossvalind('Kfold ', length, 2);
    x_train = x(idenx == 1, :);
    y_train = y(idenx == 1);
    x_test = x(idenx == 2, :);
    y_test = y(idenx == 2);
   
    cv_err_test = [];
    cv_err_train = [];
    d= 1;
    lambdalist = 0:0.5:1000; 
    % we use a for loop here so as to avoid passing individual values of lambda.
    for lambda = lambdalist
        [errTrain, model, errTest] = riskreg(x_train, y_train, lambda, x_test, y_test);
        cv_err_test(d) = errTest;
        cv_err_train(d) = errTrain;
        d= d + 1;
    end
    close all;
    hold on;
    
    plot(lambdalist, cv_err_test, 'r');
    plot(lambdalist, cv_err_train, 'b');
    
    [~, i ] = min(cv_err_test);
    plot(lambdalist(i), cv_err_test(i) , 'bx');
    
    %graph specifications
    xlabel('Lambda');
    ylabel('Train and Test Error');
    legend('Test Error', 'Train Error');