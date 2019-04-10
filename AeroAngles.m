%Aero Angles 
%Authors: Zain Soe Mya and Rowan Withers 
%Calculates the Aero angles alpaha and beta from the current state of X 
function V_alpha_beta = AeroAngles(X)

% Initialise velocity components
u = X(1);
v = X(2);
w = X(3);

% Calculate the magnitude of velocity, angle of attack and angle of
% sideslip
V = sqrt(u^2 + v^2 + w^2);
alpha = atan(w/u);
beta = atan(v/sqrt(u^2+w^2));

% Output the calculated values as a vector
V_alpha_beta = [V; alpha; beta];

end