%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function generates and returns the flight data structure which
% defines the aircraft data and aerodynamic derivatives.
%
% Aircraft data and aerodynamic derivatives  - CG2 case
% Flight config = clean_xx - flaps deflected 0 deg, clean configuration
% 
% (c) Peter W. Gibbens & S. Dumble, 1 March, 2011.
% 
% Modified Darren 2016 CG2 Case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ FlightData ] = aero3560_LoadFlightDataPC9_CG2()


    % Inertial Data
    FlightData.Inertial.g = 9.81;           % Gravity Constant
    FlightData.Inertial.m = 2087;           % Aircraft Mass (kg)
    FlightData.Inertial.Ixx = 5066;         % Aircraft Moments of Inertia (kg.m^2)
    FlightData.Inertial.Iyy = 6578;         % Aircraft Moments of Inertia (kg.m^2)
    FlightData.Inertial.Izz = 10975;        % Aircraft Moments of Inertia (kg.m^2)
    FlightData.Inertial.Ixz = 203;          % Aircraft Moments of Inertia (kg.m^2)
    
    % Geometric Data
    FlightData.Geo.S = 16.29;         % Platform Area (m^2)
    FlightData.Geo.c = 1.652;         % Chord Length (m)
    FlightData.Geo.b = 10.12;         % Wing Span (m)
    
    % Propeller Data
    FlightData.Prop.P_max = 950000; % Maximum engine power (Watts)
    FlightData.Prop.eta = 0.8; % Propeller efficiency
    
    % Control Data
    DtoR = pi/180;
    FlightData.ControlLimits.Lower = [0;            % Throttle range (Fraction)
                                      -25*DtoR;     % Elevator range (rad)
                                      -25*DtoR;     % Aileron range (rad)
                                      -25*DtoR];    % Rudder range (rad)
    FlightData.ControlLimits.Upper = [1;            % Throttle range (Fraction)
                                      25*DtoR;      % Elevator range (rad)
                                      25*DtoR;      % Aileron range (rad)
                                      25*DtoR];     % Rudder range (rad)

    % Aerodynamic Data (Reference CG: 22 % mac)
    FlightData.Aero.alpha_o = -3.0/57.3; 
    % Drag Coefficients
    FlightData.Aero.Cdo    =  0.020;
    FlightData.Aero.k      =  0.050;
    % Lift Coefficients
    FlightData.Aero.CLa  =  5.827;
    FlightData.Aero.CLq  =  7.960;
    FlightData.Aero.CLad = -1.987;
    FlightData.Aero.CLde =  0.532;
    FlightData.Aero.CLo  = -FlightData.Aero.CLa*FlightData.Aero.alpha_o;
    % Side Force Coefficients
    FlightData.Aero.Cyb  = -0.507;
    FlightData.Aero.Cybd = -0.0032;
    FlightData.Aero.Cyp  = -0.128;
    FlightData.Aero.Cyr  =  0.336;
    FlightData.Aero.Cyda =  0.000;
    FlightData.Aero.Cydr =  0.249;
    % M Moment Coefficients
    FlightData.Aero.Cmo  =  0.06;
    FlightData.Aero.Cma  = -0.551;
    FlightData.Aero.Cmq  = -14.41;
    FlightData.Aero.Cmad = -2.210;
    FlightData.Aero.Cmde = -1.822;
    % N Moment Coefficients
    FlightData.Aero.Cnb  =  0.082;
    FlightData.Aero.Cnbd =  0.0015;
    FlightData.Aero.Cnp  = -0.0226;
    FlightData.Aero.Cnr  = -0.143;
    FlightData.Aero.Cnda =  0.0048;
    FlightData.Aero.Cndr = -0.115;
    % L Moment Coefficients
    FlightData.Aero.Clb  = -0.0852;
    FlightData.Aero.Clbd = -0.0004;
    FlightData.Aero.Clp  = -0.328;
    FlightData.Aero.Clr  =  0.0776;
    FlightData.Aero.Clda = -0.164; 
    FlightData.Aero.Cldr =  0.0302;

end      
