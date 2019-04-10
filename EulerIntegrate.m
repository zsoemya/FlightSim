%EulerIntegrate
%Authors: Zain Soe Mya
%Preforms euler intergration for determining next state

function X = EulerIntegrate(X, X_dot, dt)

X = X + X_dot*dt;


end
