%C_y
%Authors: Zain Soe Mya
%Preform single axis transformation about a y-axis

function Cy = C_y(ang)

Cy = [cos(ang), 0 ,-sin(ang);
    0 ,1 ,0;
    sin(ang), 0 ,cos(ang)];

end
