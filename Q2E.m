%Q2E
%Authors: Zain Soe Mya
%Convert quaternions to euler angles 

function [EAngles] = Q2E(Quarts)
%Quarts is a matix of column vectors, with no limit in size

Varsize = size(Quarts); %finds size of Quarts
nVar = Varsize(1,2);

for k=1:nVar %Calculates for each set of quarternions 

q0 = Quarts(1,k);
q1 = Quarts(2,k);
q2 = Quarts(3,k);
q3 = Quarts(4,k);

phi = atan2(((q2*q3)+(q0*q1)),((q0^2+q3^2-0.5))); %Coverts quaternions to Euler angles in radians
theta= atan2(((q0*q2)-(q1*q3)),((((q0^2+q1^2-0.5)^2)+( ((q1*q2)+(q0*q3))^2 ))^0.5));
psi = atan2(((q1*q2)+(q0*q3)),( q0^2+q1^2-0.5));



EAngles(1,k) = phi; %Converts Euler angles to degrees and displays them as column vectors in a matrix
EAngles(2,k) = theta;
EAngles(3,k) = psi;

end 

end 
