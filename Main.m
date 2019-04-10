%Main
%Authors: Zain Soe Mya
%Runs the simulation for the specificed conditions, calls all primary
%subroutines 

%Intial conditions
n = 180; %Time 
dt = 0.01; %Time step 
T = 0:dt:n; 

IntialCond = Initialisation();  %Intial conditions function 

%Creates skeleton matrix for storing all X states
X = zeros([13,(n/dt)+1]);  

%Extract Values for inital conditions 
X0 = IntialCond.X0;
U = IntialCond.U0;
FlightData = IntialCond.FlightData; 

%Control Inputs 
%No User Input
U_in = zeros(6,1); 

%Elevator Inpulse 
%U_in = [U(1);deg2rad(5);U(3);U(4);10;0.5]; %Elevator inpulse at 10 seconds for 0.5 seconds.

%Alieron Impulse 
%U_in = [U(1);U(2);deg2rad(5);U(4);10;0.5]; %Aileron impulse at 10 seconds for 0.5 seconds 

%Rudder Impulse 
U_in = [U(1);U(2);U(3);deg2rad(5);10;0.5]; %Rudder impulse at 10 seconds for 0.5 seconds 

%TakeOff Manouver
% TrimState2 = Trim(X0(1),3414.634146,FlightData);
% UF = TrimState2.U0; 
% U_in = [1,1,UF(1);-deg2rad(1),deg2rad(1),-deg2rad(5);U(3),0,UF(3);U(4),0,UF(4);5,45,47;40,2,20];



U_time = Controls(U, U_in, n, dt); %Creates Control matrix 

%Convert Euler angles in Intial conditions to Quaternions%
X0 = [X0(1:6);E2Q(X0(7:9));X0(10:12)];

%Define Trim States 
%V_0 = 100;
%Alt = 8200; 

%Convert Trim Values 
%V_0 = V_0*0.51444; 
%Alt = Alt/3.28; 

%Calculate Trim States 
%TrimStates = Trim(V_0, Alt, FlightData); 

%Use Trimed States 
%X0 = TrimStates.X0;
%U = TrimStates.U0; 

%Store X0 in first column of X matrix 
X(:,1) = X(:,1) + X0; 

%X_dot is zero 
X_dot = zeros([13,1]);

%Finds intial X_dot
X_dot = StateRates(X0, U_time(:,1) , FlightData, X_dot);

%Calculates each X state for time step
for i=2:((n/dt)+1)
    
    X_t = Integrate(X(:,(i-1)), U_time(:,(i-1)), FlightData, X_dot, dt); %Uses intergration (4th order Runge Kutta) find n+1 of State (X)
    
    %X_t = EulerIntegrate(X(:,(i-1)) , X_dot, dt); %Uses Euler Intergration
    %
    
    X(:,i) = X(:,i) + X_t; %Adds new state to skeleton matrix 
    
    X_dot = StateRates(X(:,i), U_time(:,i) , FlightData, X_dot); %Calculates new X_dot 
   
end 


PlotData(X,U_time,T);%Plots Data 
