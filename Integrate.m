%Integrate
%Authors: Zain Soe Mya
%Uses Runge-Kutta 4th Order intergation to compute the next state for any
%chosen time step dt 

function X = Integrate(X,U,FlightData,X_dot,dt)

X_1 = X; 

%Calculate 1st Step 
X_dot1 = X_dot; 
Step_1 = X_dot1*dt; 

%Calculate 2nd Step
X_2 = (X+(Step_1/2));
X_dot2 = StateRates(X_2, U, FlightData, X_dot); 
Step_2 = X_dot2*dt; 

%Calcaulate 3rd Step 
X_3 = X_1+Step_2/2; 
X_dot3 = StateRates(X_3, U, FlightData, X_dot); 
Step_3 = X_dot3*dt;

%Calcaulate 4th Step 
X_4 = X_1 + Step_3; 
X_dot4 = StateRates(X_4, U, FlightData, X_dot); 
Step_4 = X_dot4*dt; 

%Runge-Kuta Total increment 
X = X_1 + (Step_1 + 2*Step_2 + 2*Step_3 + Step_4)/6; 

%Normalise Quaternions and producing new X 
q = X(7:10); 
X = [X(1:6);q;X(11:13)]; 



end