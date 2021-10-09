function problem1_crossvalid(filename)
    data = load(filename); %this loads the file data
    X_data = data.x;
    Y_data = data.y;
    %divide the dataset test and train
    [length,~] = size(X_data);% get the size of the dataset to be used for crossfold
    idenx = crossvalind('KFold', length, 2);
    trainMat = (idenx == 1);
    x_train = X_data(trainMat);
    y_train = Y_data(trainMat);
    
    testMat = (idenx == 2);
    x_test = X_data(testMat);
    y_test = Y_data(testMat);
    
    cv_err_test = [];
    cv_err_train = [];
    for d=1:40
        [errTrain, model, errTest] = polyreg(x_train, y_train, d, x_test, y_test);
        cv_err_test(d) = errTest;
        cv_err_train(d) = errTrain;
    end
    
    clf ;
    hold on ;
    plot(cv_err_train,'b');
    plot(cv_err_test,'r');
    % get the minimum of the error_test value and mark as cross on graph
    [~, i ] = min(cv_err_test);
    plot(i , cv_err_test(i) , 'bx') ;
    %graph specifications
    title('Cross Validation');
    xlabel('Error');
    ylabel('Degree of Polynomial');
    legend('Train Error', 'Test Error');
end