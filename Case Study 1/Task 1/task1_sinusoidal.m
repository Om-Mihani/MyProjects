clear; clc;

p = parameters_task1();
y0 = 3;
t0 = 0; tf = 10;
N = 200;                 % to show waves clearly

frequencies = [0.1 1 5 20];

figure; hold on;

for f = frequencies
    p.freq = f;
    [tE, yE] = euler_ode_solv(@model1, t0, tf, y0, N, p);
    plot(tE, yE, 'DisplayName', sprintf('freq = %.1f', f));
end

xlabel('Time');
ylabel('R1');
title('Task 1.2: Effect of sinusoidal input frequency');
legend;
