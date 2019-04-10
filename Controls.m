%Controls
%Authors: Zain Soe Mya
%Takes a uses defined input matrix of U_in which is a 6xi matrix and consists of all controls
%states inputed by the person, plus two addition values of U_in(5) which
%is the time of the occurance of the control and U_in(6) which is the
%duration of that control setting. U0 is trimmed flight conditions. The
%function produces a 4xn matrix which contains the controls for the entire
%duration of the simulation
%

function U_time = Controls(U0, U_in, n, dt)

%Creates empty matrix of Controls for every time step 
U_time = zeros(4,((n/dt)+1));

%Adds Trim setting of Controls for every time step
U_time(1,:) = U0(1);  
U_time(2,:) = U0(2); 
U_time(3,:) = U0(3);
U_time(4,:) = U0(4); 

%Determines number of user defined control settings 
U_in_size = size(U_in);
columns = U_in_size(2); 

for i=1:columns
   
    %Determines when control occurs 
    n_t = U_in(5,i); 
    n_t = n_t/dt; 
    
    %Determines duration of control input 
    d = U_in(6,i);
    
    %Adds control input to Control time step matrix 
    for m = 1:(d/dt)
       
        U_time(:,n_t + m) = U_in(1:4,i); 
        
    end
    
end

end 