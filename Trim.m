%Trim
%Author: Zain Soe Mya
%Calculates the elevator and thrust control setting for trimmed flight at a
%specific speed and altitude 

function TrimStates = Trim(V_0 , Altitude, FlightData) 

contol = 10^(-8); %Tolerance 
perb = 10^(-8); %Perbutation 
error = 10; 

%Create a matrix V_int for the purpose of calculating FlowProperties at
%specific altitude 
V_int = zeros(13,1); 
V_int(1) = V_0; 
V_int(13) = -Altitude; 

%Calculate FlowProperties and extract Q
FProp = FlowProperties(V_int, FlightData); 
Q = FProp(1); 

%Calculate CL for Equilbrium Conditions 
CL = (FlightData.Inertial.m*FlightData.Inertial.g)/(Q*FlightData.Geo.S); 
Th
%Estimate alpha from CL 
alpha_0 = (CL - FlightData.Aero.CLo)/(FlightData.Aero.CLa); 

%Estimate delta_t and delta_e 
delta_t = 0.5;
delta_e = 0; 

%Intialise Xk
Xk = [alpha_0, delta_t, delta_e]; 

%Begin looping to find Control settings 
while error>contol
    
    J = zeros(3,3); 
 
    %Calculate X state from Xk
    X = zeros(13,1); 
    U = zeros(4,1);
    X_dot = zeros(13,1); 
    
    X(1) = V_0*cos(Xk(1)); 
    X(3) = V_0*sin(Xk(1));
    U(1) = Xk(2); 
    U(2) = Xk(3);
    X(13) = -Altitude;
    
    %Put alpha into eulers and convert to quaternions
    phi = 0;
    theta = Xk(1);
    psi = 0; 
    Euls = [phi; theta; psi];
    Quats = E2Q(Euls); 
    X(7:10) = Quats;
    
    
    %Calculate Xk_dot using staterates 
    X_dot_trim = StateRates(X, U, FlightData, X_dot); 
    
    %Extract Xk_dot values from StateRates output
    Xk_dot = [X_dot_trim(1); X_dot_trim(3); X_dot_trim(5)]; 
    
    %Being building Jacobian matrix 
    for k = 1:3 
        
        Xk_new = Xk; 
        
        %Add perbuatation to Xk to get new Xk 
        Xk_new(k) = Xk_new(k) + perb;
        
        %Place Values of Xk to find X
        X = zeros(13,1); 
        U = zeros(4,1); 
        
        X(1) = V_0*cos(Xk_new(1)); 
        X(3) = V_0*sin(Xk_new(1));
        U(1) = Xk_new(2); 
        U(2) = Xk_new(3);
        X(13) = -Altitude; 
        
        %Put alpha into eulers and convert to quaternions
        phi = 0;
        theta = Xk_new(1); 
        psi = 0; 
        Euls = [phi; theta; psi];
        Quats = E2Q(Euls); 
        X(7:10) = Quats;
        
        %Calculate Xk_dot using staterates
        X_dot_trim_new = StateRates(X, U, FlightData, X_dot); 
        
        %Extract value for Xk_dot from StateRates Ouput 
        Xk_dot_new = [X_dot_trim_new(1); X_dot_trim_new(3); X_dot_trim_new(5)]; 
        
        %Add values to jacobian 
        J(:,k) = (Xk_dot_new-Xk_dot)/perb; 
                
    end
     
     %use jacobian to get new value for Xk
     Xk_new = Xk - (J^(-1)*Xk_dot); 
     
     %Update error 
     error = (Xk_new - Xk)'*(Xk_new - Xk); 
     
     %Reloop with new Xk value 
     Xk = Xk_new; 
     
end
    
    %Produce X0 and U0 
    TrimStates.X0 = X;
    TrimStates.U0 = U; 
    

end
