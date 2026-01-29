%% Task1_compare_all3.m
% Comparison of Linear (Eq.1), Lagrange (Eq.2) and Cubic spline (Eq.6)

clear; clc; close all;

% Load and sort data
S = load('data_set_1.mat');
x = S.x(:); 
y = S.y(:);
[x,ix] = sort(x); 
y = y(ix);

% Query points
xq = linspace(min(x), max(x), 600);

% Interpolations
ylin = linEq1(x, y, xq);      % Eq.(1)
ylag = lagEq2(x, y, xq);      % Eq.(2)
yspl = splEq6(x, y, xq);      % Eq.(6)

% Plot 
figure;
plot(x, y, 'o', 'MarkerSize', 5); hold on;
plot(xq, ylin, '--', 'LineWidth', 2);
plot(xq, ylag, '-.', 'LineWidth', 2);
plot(xq, yspl, '-',  'LineWidth', 2);
grid on;

title('Linear (Eq.1) vs Lagrange (Eq.2) vs Cubic spline (Eq.6)');
xlabel('x'); ylabel('y');
legend('data','linear','lagrange','spline','Location','best');

% Plot 
figure;
plot(x, y, 'o', 'MarkerSize', 5); hold on;
plot(xq, ylin, '--', 'LineWidth', 2);
plot(xq, ylag, '-.', 'LineWidth', 2);
plot(xq, yspl, '-',  'LineWidth', 2);
grid on;
ylim([-2,12]);

title('Linear (Eq.1) vs Lagrange (Eq.2) vs Cubic spline (Eq.6) Refit');
xlabel('x'); ylabel('y');
legend('data','linear','lagrange','spline','Location','best');

%% ---------------- local functions ----------------

function yq = linEq1(x, y, xq)
% Linear interpolation (Eq.1)
yq = NaN(size(xq));
for m = 1:numel(xq)
    xm = xq(m);
    if xm < x(1) || xm > x(end), continue, end
    i = find(x <= xm, 1, 'last');
    if i == length(x), i = i - 1; end
    yq(m) = y(i) + (y(i+1)-y(i))*(xm-x(i))/(x(i+1)-x(i));
end
end

function yq = lagEq2(x, y, xq)
% Lagrange polynomial (Eq.2)
n = length(x);
yq = zeros(size(xq));
for m = 1:numel(xq)
    xm = xq(m); p = 0;
    for i = 1:n
        L = 1;
        for k = 1:n
            if k ~= i
                L = L * (xm - x(k)) / (x(i) - x(k));
            end
        end
        p = p + y(i) * L;
    end
    yq(m) = p;
end
end

function yq = splEq6(x, y, xq)
% Cubic spline using Eq.(6): ai(x-xi)^3 + bi(x-xi)^2 + ci(x-xi) + di
pp = spline(x, y);
b = pp.breaks; 
c = pp.coefs;
yq = zeros(size(xq));

for m = 1:numel(xq)
    xm = xq(m);
    i = find(b <= xm, 1, 'last');
    if isempty(i), i = 1; end
    if i >= numel(b), i = numel(b) - 1; end
    dx = xm - b(i);
    yq(m) = c(i,1)*dx^3 + c(i,2)*dx^2 + c(i,3)*dx + c(i,4);
end
end
