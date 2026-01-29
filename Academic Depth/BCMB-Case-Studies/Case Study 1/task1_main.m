clear; clc;

p = parameters_task1();

t0 = 0; 
tf = 10;
y0 = 3;       % R1(0)
N = 40;

% Euler method 
[tE, yE] = euler_ode_solv(@model1, t0, tf, y0, N, p);

% MATLAB ode45
f = @(t,y) model1(t,y,p);
[tO, yO] = ode45(f, [t0 tf], y0);

% Plot
figure;
plot(tE, yE, 'o-', 'DisplayName','Euler'); hold on;
plot(tO, yO, 'LineWidth',2, 'DisplayName','ode45');
xlabel('Time');
ylabel('R1');
legend;
title('Task 1: Euler vs ode45');

