%E2Q
%Authors: Zain Soe Mya
%Euler angle to quaternion conversion

function [Qnions] = E2Q(EuAng)
%EuAngd is a matrix of column vectors of Euler angles in degrees, with no
%limit to size

Varsize = size(EuAng); %finds size of EuAngd
nVar = Varsize(1,2);

for k = 1:nVar %Calculates for each set of Euler angles
    
phi = EuAng(1,k);  
theta = EuAng(2,k);
psi = EuAng(3,k); 

cphi = cos(phi*0.5); %each set of trig functions for each Euler angle
sphi = sin(phi*0.5);
ctheta = cos(theta*0.5);
stheta = sin(theta*0.5); 
cpsi = cos(psi*0.5);
spsi = sin(psi*0.5);

q0 = cpsi*ctheta*cphi+spsi*stheta*sphi; %Finds quaternions 
q1 = cpsi*ctheta*sphi-spsi*stheta*cphi;
q2 = cpsi*stheta*cphi+spsi*ctheta*sphi;
q3 = -cpsi*stheta*sphi+spsi*ctheta*cphi;

Qnions(1,k) = q0; %Produces answer in column vectors of a matrix 
Qnions(2,k) =q1;
Qnions(3,k) = q2;
Qnions(4,k) = q3; 

end


end






