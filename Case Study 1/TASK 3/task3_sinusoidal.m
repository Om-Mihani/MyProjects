clear; clc; close all

p = parameters_task3();
y0 = [3; 0];
t0 = 0; tf = 120;
N = 200;                 % to show waves clearly

frequencies = [0.1];
offset = [0.9];

 

for f = frequencies
    figure;hold on;
    for j = offset
        p.freq = f;
        p.p2 = j;
        [tO, yO] = ode45(@(t,y) model3(t,y,p), [t0 tf], y0);
        plot(tO, yO(:,1), 'DisplayName', 'R1');
        plot(tO, yO(:,2), 'DisplayName', 'R2');
    end
    hold off;
end

xlabel('Time');
ylabel('R1');
title('Task 3.2: Effect of sinusoidal input frequency');
legend;