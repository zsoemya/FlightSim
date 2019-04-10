%PropForces
%Authors: Zain Soe Mya
%Calculate Propeller Forces for specifice state from X, X_dot and U 

function thrust = PropForces(X, X_dot,U, FlightData) 

%AeroAngles to find V_ab and Extract velocity component 
V_ab = AeroAngles(X); 
V = V_ab(1);

%Find flow properties and extract rho_h 
Flowprop = FlowProperties(X,FlightData);
rho_h = Flowprop(2);

%Extract tail deflection and air density at sea-level
rho_0 = 1.2256; 
delta_t = U(1); 

%Calculate density ratio. 
sigma = rho_h/rho_0;

%Calculate P_max
P_max = FlightData.Prop.P_max*(1.1324*sigma-0.1324);

%Calculate Thrust 
thrust = (FlightData.Prop.eta*P_max*delta_t)/V; 

end

