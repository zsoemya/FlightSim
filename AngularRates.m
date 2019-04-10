%Angular Rates 
%Authors: Rowan Withers 
%Calculates the rates of angles alpah and beta from the current X state and
%the current state rates 
function Angular_Rates = AngularRates(X, X_dot)

    %Extract u from X matrix 
    u = X(1);
    v_dot = X_dot(2);
    w_dot = X_dot(3);
    
    %Calculate V_ab and extract velocity
    V_alpha_beta = AeroAngles(X);
    V = V_alpha_beta(1);
    
    % Calculate the angular rates using equation from lecture slides
    alpha_dot = w_dot/V;
    beta_dot = v_dot/u;
    
    % Store values in a new output matrix
    Angular_Rates = [alpha_dot; beta_dot];
end
