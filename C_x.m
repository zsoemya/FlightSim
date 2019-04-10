%C_x
%Author: Zain Soe Mya
%Performs single axis transform about an x-axis

function Cx = Cx(ang)

Cx = [1,0,0;
    0, cos(ang), sin(ang);
    0, -sin(ang), cos(ang)];

end 