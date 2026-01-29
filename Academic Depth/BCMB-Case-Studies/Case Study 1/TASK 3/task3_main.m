clear; clc;close all;


%% Task 3.1

%Loading Parameters
p = parameters_task3();

t0 = 0; 
tf = 10;
y0 = [3; 0];       
N = 40;

% MATLAB ode45
[tO, yO] = ode45(@(t,y) model3(t,y,p), [t0 tf], y0);

%Plot

figure;
plot(tO, yO(:,1), 'LineWidth',2, 'DisplayName','R1');
hold on
plot(tO, yO(:,2), 'LineWidth', 2, 'DisplayName', 'R2');
xlabel('Time');
ylabel('R');
legend('R1', 'R2');
title('Task 3: Coupled');
hold off

figure(2);
plot(yO(:,1), yO(:,2), 'LineWidth', 2, 'DisplayName', 'R2 vs R1');
xlabel('Protein 1');
ylabel('Protein 2');
legend;
title('Coupled Dynamics: R space');
grid on;
hold on;

y2 = [1:1:10];

figure(3); hold on; grid on;
title('Coupled Dynamics: R space');
xlabel('Protein 1'); ylabel('Protein 2');

% First trajectory, R2(0) = 0  → blue
y0 = [3; 0];
[tO, yO] = ode45(@(t,y) model3(t,y,p), [t0 tf], y0);
plot(yO(:,1), yO(:,2), 'Color', [0 0 1], 'LineWidth', 2, ...
     'DisplayName', 'R_2(0) = 0');

for i = y2
    y0 = [3; i];
    [tO, yO] = ode45(@(t,y) model3(t,y,p), [t0 tf], y0);

    % Decide color based on R2(0)
    if i <= 2
        col = [0 0 1];          % blue for 1,2
    elseif i <= 8
        col = [1 0 0];          % red for 3–8
    else
        col = [0 1 0];          % green for 9–20
    end

    plot(yO(:,1), yO(:,2), 'Color', col, 'LineWidth', 2, ...
         'DisplayName', sprintf('R_2(0) = %d', i));

    % Label near the start of the trajectory
    label = sprintf('R_2(0) = %.2f', i);
    text(yO(1,1), yO(1,2), label, 'FontSize', 10);
end

%% Task 3.2

