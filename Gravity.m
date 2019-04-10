%Gravtity
%Authors: Zain Soe Mya
%Converts gravity forces to the body axis using DCM

function gravity = Gravity(X, FlightData)

%Extract gravity value from FlightData 
g_z = FlightData.Inertial.g; 

%Compute Cbe matrix 
Cbe = DCM(X); 

%Establish gravity matrix 
g = [0;0;g_z]; 

%Calaculate gravity force in body axes 
gravity = Cbe*g;

end