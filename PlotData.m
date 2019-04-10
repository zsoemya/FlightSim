%PlotData
%Authors: Ali Asharm and Zain Soe Mya
%Plots Data from simulation for visualisation 

function PlotData(X,U,time)

% Initialise the velocity components from the X Matrix
u = X(1,:);
v = X(2,:);
w = X(3,:);

% Initialise the roll, pitch and yaw from the X Matrix
roll_rads = X(4,:);
pitch_rads = X(5,:);
yaw_rads = X(6,:);
% Convert the roll, pitch and yaw to degrees/sec
roll = roll_rads.*(180/pi);
pitch = pitch_rads.*(180/pi);
yaw = yaw_rads.*(180/pi);

% Initialise the quaternions in the X Matrix
quats = X((7:10),:);
% Convert the quaternions into euler angles
eulers_rads = Q2E(quats);
% Convert the euler angles to degrees 
eulers_deg = eulers_rads.*(180/pi);
% Obtain phi, theta and psi 
phi = eulers_deg(1,:);
theta = eulers_deg(2,:);
psi = eulers_deg(3,:);

% Initialise the earth axis positions from the X Matrix
x_e = X(11,:);
y_e = X(12,:);
z_e = X(13,:);

%Convert z_e to feet and positive 
z_e = -z_e.*3.28; 

%Initialise Controls 
delta_t = rad2deg(U(1,:));
delta_e = rad2deg(U(2,:));
delta_a = rad2deg(U(3,:));
delta_r = rad2deg(U(4,:)); 

% Start the plots
% Plot the velocity components over time
figure(1)
subplot(1,3,1)
plot(time,u)
xlabel('Time [seconds]')
ylabel('Velocity [m/s]')
title('u Component')
grid on
hold on

subplot(1,3,2)
plot(time,v)
xlabel('Time [seconds]')
ylabel('Velocity [m/s]')
title('v Component')
grid on
hold on

subplot(1,3,3)
plot(time,w)
xlabel('Time [seconds]')
ylabel('Velocity [m/s]')
title('w Components')
grid on
hold on

% Plot the pitch, roll and yaw rates
figure(2)
subplot(1,3,1)
plot(time,pitch)
xlabel('Time (seconds)')
ylabel('Angle(Degrees)')
title('Pitch')
grid on
hold on

subplot(1,3,2)
plot(time,roll)
xlabel('Time (seconds)')
ylabel('Angle(Degrees)')
title('Roll')
grid on
hold on

subplot(1,3,3)
plot(time,yaw)
xlabel('Time (seconds)')
ylabel('Angle(Degrees)')
title('Yaw')
grid on
hold on



% Plot the euler angles
figure(3)
plot(time,phi,time,theta,time,psi)
xlabel('Time (seconds)')
ylabel('Angle (degrees)')
title('Euler Angles')
legend('\phi','\theta','\psi')
grid on
hold on

% Plot the position of the aircraft
subplot(1,3,1)
plot(time, x_e)
xlabel('Time (seconds)')
ylabel('X Position (m)')
title('X Position of the aircraft')
grid on
hold on

% Plot the position of the aircraft
subplot(1,3,2)
plot(time, y_e)
xlabel('Time (seconds)')
ylabel('Y Position (m)')
title('Y Position of the aircraft')
grid on
hold on

subplot(1,3,3)
plot3(x_e, y_e, z_e)
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Altitude (m)')
title('Aircraft Position')
grid on
hold on


figure(4)
plot(time, z_e)
xlabel('Time (seconds)')
ylabel('Altitude (ft)')
title('Altitude of the aircraft')
grid on
hold on

figure(5)
subplot(3,1,1)
plot(time, delta_e)
xlabel('Time (seconds)')
ylabel('Elevator Deflection (deg)')
title('Elevator Deflection')
grid on
hold on

subplot(3,1,2)
plot(time, delta_a)
xlabel('Time (seconds)')
ylabel('Alieron Deflection (deg)')
title('Alieron Deflection')
grid on
hold on

subplot(3,1,3)
plot(time, delta_r)
xlabel('Time (seconds)')
ylabel('Rudder Deflection (deg)')
title('Rudder Deflection')
grid on
hold on



