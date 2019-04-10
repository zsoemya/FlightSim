%WindForces
%Authors: Zain Soe Mya
%Calculates CL and CD from current states and staterates 

function WForces = WindForces(X, U, X_dot, FlightData) 
q = X(5); 
delta_e = U(2); 

%Produces Angular Rates = [alpha_dot, beta_dot] and extract alpha_dot. 
AngRates = AngularRates(X, X_dot); 
alpha_dot = AngRates(1);

%Calucluate V, alpha, beta, extract values 
V_alpha_beta = AeroAngles(X);
V = V_alpha_beta(1); 
alpha = V_alpha_beta(2);

%Normalise pitch and alpha 
q_bar = (q*FlightData.Geo.c)/(2*V); 
alpha_dot_bar = (alpha_dot*FlightData.Geo.c)/(2*V); 

%Calculaate CL and CD 
CL = FlightData.Aero.CLo+FlightData.Aero.CLa*alpha + FlightData.Aero.CLq*q_bar + FlightData.Aero.CLde*delta_e + FlightData.Aero.CLad*alpha_dot_bar; 
CD = FlightData.Aero.Cdo + FlightData.Aero.k*CL^2; 

WForces = [CL; CD]; 

end





