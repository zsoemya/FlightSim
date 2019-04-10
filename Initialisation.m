%Initialisation
%Authors: Zain Soe Mya
%Loads Intial conditions for running the sim. Asks for use input to select
%centre of gravity location and speed condition. Then loads X0, U0 and
%FlightData for specified condtions

function Int = Initialisation()

u = 0;

while u == 0
    CG = input('CG 1 or CG 2?');
    
    if CG == 1
        u = 1;
        
    elseif CG == 2
        u = 2; 
   
    else
        disp('Input must be 1 or 2');
    end 
end

while u <= 2 
    
    Speed = input('Speed 100Kn or 180Kn?');
    
    if Speed == 180
        u = u + 180;
        
    elseif Speed == 100
        u = u + 100;
    
    else 
        disp('Input must be 100 or 180');
        
    end
end

if u == 101
    IntCond = load('ICs_PC9_nominalCG1_100Kn_1000ft.mat');
    FlightData = aero3560_LoadFlightDataPC9_nominalCG1();
    Int.FlightData = FlightData;
    Int.X0 = IntCond.X0;
    Int.U0 = IntCond.U0; 

    
    elseif u == 181 
    IntCond = load('ICs_PC9_nominalCG1_180Kn_1000ft.mat');
    FlightData = aero3560_LoadFlightDataPC9_nominalCG1();
    Int.FlightData = FlightData;
    Int.X0 = IntCond.X0;
    Int.U0 = IntCond.U0; 

    
    elseif u == 102
    IntCond = load('ICs_PC9_CG2_100Kn_1000ft.mat');
    FlightData = aero3560_LoadFlightDataPC9_CG2();
    Int.FlightData = FlightData;
    Int.X0 = IntCond.X0;
    Int.U0 = IntCond.U0; 

    
    else if u == 182 
    IntCond = load('ICs_PC9_CG2_180Kn_1000ft.mat');
    FlightData = aero3560_LoadFlightDataPC9_CG2();
    Int.FlightData = FlightData;
    Int.X0 = IntCond.X0;
    Int.U0 = IntCond.U0; 

    
    else
    disp('Error')
    
        end
        
end


       
        
    
end

    
    
    
    
