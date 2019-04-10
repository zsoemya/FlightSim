%NormaliseQuats
%Authors: Zain Soe Mya
%Normalises quaternions 

function Normq = NormaliseQuats(q)

[r, c] = size(q); 

for i = 1:c
    
    Normq(:,i) = q(:,i) /sqrt(sum(q(i,:).^2));
    
end
end