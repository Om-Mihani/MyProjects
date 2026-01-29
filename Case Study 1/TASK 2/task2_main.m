clear; clc;

p = parameters_task2();

t0 = 0;
tf = 10;
y0 = [3; 0];    % R1(0), R2(0)
N  = 40;

% Euler method
[tE, yE] = euler_ode_solv(@model2, t0, tf, y0, N, p);

% MATLAB ode45
f = @(t,y) model2(t,y,p);
[tO, yO] = ode45(f, [t0 tf], y0);

% Plot
figure;
plot(tE, yE(:,1), 'o-', 'DisplayName','R1 Euler'); hold on;
plot(tE, yE(:,2), 's-', 'DisplayName','R2 Euler');
plot(tO, yO(:,1), 'LineWidth',2, 'DisplayName','R1 ode45');
plot(tO, yO(:,2), '--', 'LineWidth',2, 'DisplayName','R2 ode45');

xlabel('Time');
ylabel('Concentration');
legend;
title('Task 2: Coupled system (R1, R2)');
grid on;

