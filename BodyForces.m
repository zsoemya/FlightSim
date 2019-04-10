%Body Forces
%Authors: Zain Soe Mya
%Calcuates all body forces on aircraft for a specified state 

function BForces = BodyForces(X,U,FlightData,X_dot) 

%Calculate V_ab and Extract V, Alpha and beta 
V_ab = AeroAngles(X); 
V = V_ab(1);           
alpha = V_ab(2);
beta = V_ab(3); 

%Calculated FlowProperties and extract Q 
FProp = FlowProperties(X, FlightData); 
Q = FProp(1); 

%Calcualte Anglular rates and extract alpha_dot, beta_dot  
ARates = AngularRates(X, X_dot);
alpha_dot = ARates(1);
beta_dot = ARates(2);

%Calculate Wind forces and extract CL and CD. 
WForces = WindForces(X, U, X_dot, FlightData); 
CL = WForces(1);
CD = WForces(2);

%Extract controls from U matrix 
delta_e = U(2);
delta_a = U(3);
delta_r = U(4);

%Extract roll, pitch and yaw states 
p = X(4);
q = X(5);
r = X(6);

%Normalise Variables 
p_bar = (p*FlightData.Geo.b)/(2*V);
q_bar = (q*FlightData.Geo.c)/(2*V); 
r_bar = (r*FlightData.Geo.b)/(2*V); 
alpha_dot_bar = (alpha_dot*FlightData.Geo.c)/(2*V);
beta_dot_bar = (beta_dot*FlightData.Geo.b)/(2*V);

%Calculated Force Coeffcients 
Lift = CL*Q*FlightData.Geo.S; 
CY = FlightData.Aero.Cyb*beta + FlightData.Aero.Cybd*beta_dot + FlightData.Aero.Cyp*p_bar + FlightData.Aero.Cyr*r_bar + FlightData.Aero.Cyda*delta_a + FlightData.Aero.Cydr*delta_r; 
Drag = CD*Q*FlightData.Geo.S;
F_side = CY*Q*FlightData.Geo.S; 

%Calculate X, Y and Z forces 
F_x = -Drag*cos(alpha) + Lift*sin(alpha);
F_y = F_side; 
F_z = -Drag*sin(alpha) - Lift*cos(alpha); 

%Calculated Moment coeffcients 
Cl = FlightData.Aero.Clb*beta + FlightData.Aero.Clbd*beta_dot_bar + FlightData.Aero.Clp*p_bar + FlightData.Aero.Clr*r_bar + FlightData.Aero.Clda*delta_a + FlightData.Aero.Cldr*delta_r; 
CM = FlightData.Aero.Cmo + FlightData.Aero.Cma*(alpha) + FlightData.Aero.Cmq*(q_bar) + FlightData.Aero.Cmad*(alpha_dot_bar) + FlightData.Aero.Cmde*(delta_e);
CN = FlightData.Aero.Cnb*beta + FlightData.Aero.Cnbd*beta_dot_bar + FlightData.Aero.Cnp*p_bar + FlightData.Aero.Cnr*r_bar + FlightData.Aero.Cnda*delta_a + FlightData.Aero.Cndr*delta_r; 

%Calculated Momements 
M_x = Cl*Q*FlightData.Geo.S*FlightData.Geo.b; 
M_y = CM*Q*FlightData.Geo.S*FlightData.Geo.c; 
M_z = CN*Q*FlightData.Geo.S*FlightData.Geo.b; 

BForces = [F_x; F_y; F_z; M_x; M_y; M_z]; 

end 









