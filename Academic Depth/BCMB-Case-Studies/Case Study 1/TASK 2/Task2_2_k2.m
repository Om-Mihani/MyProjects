clear; close all; clc;

%% Fixed parameters
ks1 = 20;
ks2 = 10;
k1  = 1;

K2  = 1;
n   = 2;

u1 = 1;
u2 = 1;

% k2 interval [1,10]
k2_values = [1 2 4 6 8 10];

% Time span
tspan = [0 10];

% Initial conditions
R0 = [3; 0];

%% Plot R1
figure; hold on;

for i = 1:length(k2_values)
    k2 = k2_values(i);

    ode = @(t,R) [
        ks1*u1/(1 + (R(2)/K2)^n) - k1*R(1);
        ks2*u2 - k2*R(2)
    ];

    [t,R] = ode45(ode, tspan, R0);

    plot(t, R(:,1), 'LineWidth',1.5, ...
        'DisplayName',['k_2 = ' num2str(k2)]);
end

xlabel('Time');
ylabel('R_1 concentration');
title('Task 2.2: Influence of k_2 on R_1');
legend;
grid on;

%% Plot R2
figure; hold on;

for i = 1:length(k2_values)
    k2 = k2_values(i);

    ode = @(t,R) [
        ks1*u1/(1 + (R(2)/K2)^n) - k1*R(1);
        ks2*u2 - k2*R(2)
    ];

    [t,R] = ode45(ode, tspan, R0);

    plot(t, R(:,2), 'LineWidth',1.5, ...
        'DisplayName',['k_2 = ' num2str(k2)]);
end

xlabel('Time');
ylabel('R_2 concentration');
title('Task 2.2: Influence of k_2 on R_2');
legend;
grid on;
