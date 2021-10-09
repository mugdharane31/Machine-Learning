function risk_mean = calculateRisk(x, y, theta)
    funct = returnFunction(x, theta);
    risk = (y-1).*log(1 - funct) - y.*log(funct);
    risk(isnan(risk )) = 0;
    risk_mean = mean(risk);
end