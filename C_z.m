%C_z
%Authors: Zain Soe Mya
%Preforms a single axis transformation about the z-axis

function Cz = C_z(ang)

Cz = [cos(ang), sin(ang), 0; 
    -sin(ang), cos(ang), 0;
    0,0,1];

end 