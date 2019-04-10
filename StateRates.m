%StateRates
%Authors: Zain Soe Mya and Rowan Withers 
% This function calculates the rates of all components in the X matrix.
% It outputs a matrix X_dot.

function [X_dot_new] = StateRates(X, U, FlightData, X_dot)
         
    %Calculate thrust force 
    F_tx = PropForces(X, X_dot, U, FlightData); 
    
    % Extract values from X matrix 
    u = X(1);
    v = X(2);
    w = X(3);
    p = X(4);
    q = X(5);
    r = X(6);
    q0 = X(7);
    q1 = X(8);
    q2 = X(9);
    q3 = X(10);
    
    %Extract values from gravity matrix, extract values Gravity = [g_x; g_y; g_z] 
    gravity = Gravity(X, FlightData); 
    g_x = gravity(1); 
    g_y = gravity(2); 
    g_z = gravity(3); 
    
    %Calculate body force and Extract values BForce = [F_x; F_y; F_z; M_z; M_y; M_z]
    BForces = BodyForces(X,U,FlightData,X_dot);
    F_x = BForces(1); 
    F_y = BForces(2); 
    F_z = BForces(3); 
    M_x = BForces(4); 
    M_y = BForces(5); 
    M_z = BForces(6); 
    
    % Calculate udot, vdot, wdot. 
    u_dot = r*v - q*w + g_x + (F_x + F_tx)/FlightData.Inertial.m; 
    v_dot = -r*u + p*w + g_y + ((F_y)/FlightData.Inertial.m);
    w_dot = q*u - p*v + g_z + ((F_z)/FlightData.Inertial.m);
    
    % Calculate quaternion rates
    q0_dot = -(1/2)*(q1*p + q2*q + q3*r);
    q1_dot = (1/2)*(q0*p - q3*q + q2*r);
    q2_dot = (1/2)*(q3*p + q0*q - q1*r);
    q3_dot = -(1/2)*(q2*p - q1*q - q0*r);
    
    % Calculate Roll, Pitch and Yaw Rates coefficients
    C_0 = (FlightData.Inertial.Ixx)*(FlightData.Inertial.Izz) - (FlightData.Inertial.Ixz)^2;
    C_1 = FlightData.Inertial.Izz/C_0;
    C_2 = FlightData.Inertial.Ixz/C_0;
    C_3 = C_2*(FlightData.Inertial.Ixx-FlightData.Inertial.Iyy+FlightData.Inertial.Izz);
    C_4 = C_1*(FlightData.Inertial.Iyy-FlightData.Inertial.Izz) - C_2*FlightData.Inertial.Ixz;
    C_5 = 1/FlightData.Inertial.Iyy;
    C_6 = C_5*FlightData.Inertial.Ixz;
    C_7 = C_5*(FlightData.Inertial.Izz - FlightData.Inertial.Ixx);
    C_8 = FlightData.Inertial.Ixx/C_0;
    C_9 = C_8*(FlightData.Inertial.Ixx - FlightData.Inertial.Iyy) + C_2*FlightData.Inertial.Ixz;
    
    %Applied moments about the body axis
    L = M_x; 
    M = M_y; 
    N = M_z; 
    
    % Calculate Rotational rates of change
    p_dot = C_3*p*q + C_4*q*r + C_1*L + C_2*N; 
    q_dot = C_7*p*r - C_6*(p^2-r^2) + C_5*M; 
    r_dot = C_9*p*q - C_3*q*r + C_2*L + C_8*N; 
    
    % Calculated Cbe Transform matrix and Transform body axis back to earth axis and extract body axis rates
    Cbe = DCM(X);
    earth_dot = Cbe'*[u; v; w];
    earth_dot = earth_dot';
    
    x_e_dot = earth_dot(1); 
    y_e_dot = earth_dot(2); 
    z_e_dot = earth_dot(3); 
    
    % Outputs new X_dot, contains all rates
    X_dot_new = [u_dot; v_dot; w_dot; p_dot; q_dot; r_dot; q0_dot; q1_dot; q2_dot; q3_dot; x_e_dot; y_e_dot; z_e_dot]; 
  
end