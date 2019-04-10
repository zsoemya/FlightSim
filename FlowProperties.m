%FlowProperties
%Author: Zain Soe Mya
%Uses velocity from the current state to determine the dynamic pressure at
%altitude and air density at altitude. All constant values take from
%aero4students website 

function FProperties = FlowProperties(X, FlightData) 

%Calculate V_ab and Extract V 
V_ab = AeroAngles(X);
V = V_ab(1);

%Establish altitude from z_e
h = abs(X(13));

T_o = 288.2; %Surface Tempreture in Kelvin 
alpha = 0.0065; %Rate of change of tempreture K/m
P_o = 101300; %pressure at sea level (Pa)
g = FlightData.Inertial.g;
r = 287.1; %Universal gas constant

%Linear change in tempreture 
T_h = T_o - alpha*h; 

%Pressure at altitude 
P_h = P_o * (T_h/T_o)^((g)/(r*alpha)); 

%Calculate air density at altitude 
rho_h = P_h / (r*T_h); 

%Dynamic pressure at altitude 
Q = 0.5*rho_h*V^2; 

FProperties = [Q; rho_h]; 

end 


