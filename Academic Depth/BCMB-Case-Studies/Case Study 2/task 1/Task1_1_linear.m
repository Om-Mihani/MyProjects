%% Task1_1_linear.m
% Task 1.1: Linear piecewise interpolation using Eq.(1)

clear; clc; close all;

% Load data_set_1 (must contain x and y)
S = load('data_set_1.mat');
x = S.x(:); 
y = S.y(:);

% Sort (important)
[x, idx] = sort(x);
y = y(idx);

% Query points
xq = linspace(min(x), max(x), 500);

% Linear interpolation (Eq. 1)
yq = linInterpEq1(x, y, xq);

% Plot
figure;
plot(x, y, 'o'); hold on;
plot(xq, yq, '-');
title('Task 1.1: Linear interpolation (Eq.1)');
xlabel('x'); ylabel('y'); grid on;
legend('data','linear');

%% -------- local function (Eq.1) --------
function yq = linInterpEq1(x, y, xq)
% Eq.(1): y = yi + (yj-yi)*(x-xi)/(xj-xi)

yq = NaN(size(xq));  % no extrapolation

for m = 1:numel(xq)
    xm = xq(m);

    if xm < x(1) || xm > x(end)
        continue
    end

    for i = 1:length(x)-1
        if xm >= x(i) && xm <= x(i+1)
            yq(m) = y(i) + (y(i+1)-y(i))*(xm-x(i)) / (x(i+1)-x(i));
            break
        end
    end
end
end