function problem4(filename, stepsize, epsilon)
    %@author - mugdha_rane
    %filename - the data file
    %stepsize - descending by 2 (η)
    %epsilon -tried using other values as well 
    
    load(filename);
    theta = rand(size(X, 2 ),1);
    max_iterator = 200000;
    current_iter = 0;

    % initialize the value to plot stats
    risks = [];
    errors = [];
    previous_theta = theta + 2 * epsilon ;
    while norm( theta - previous_theta ) >= epsilon
        if current_iter > max_iterator
            break;
        end

        % Current stats
        risk = calculateRisk(X, Y, theta);
        func = returnFunction(X, theta)
        func(func >= 0.5) = 1; % logistic regression
        func(func < 0.5) = 0;
        error = sum(func ~=Y)/ length(Y) ;
        risks = cat(1, risks, risk); % concat all the risks
        errors = cat(1, errors, error); % concat all the errors
    
        % Update theta to descend further
        previous_theta = theta;
        gradient = calculateGradient(X, Y, theta);
        theta = theta - stepsize*gradient; % θ(t+1) = θt − η∇θ
        current_iter = current_iter + 1;
    end
    
    %plotting the graph and its aesthetics
    figure, plot(1: current_iter, errors, 'r', 1: current_iter, risks, 'g');
    title('Error, Risk vs Iterations');
    xlabel('Iterations');
    ylabel('Error, Risk');
    legend('Error', 'Risk');
    disp ('theta');disp(theta)
    x= 0:0.01:1;
    y=(-theta (3) - theta (1).* x)/ theta (2);
    figure, plot(x, y, 'b');
    hold on;
    plot(X(:, 1), X(:, 2), '.') ;
    title('Linear Decision Boundary');
end