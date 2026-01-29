%% Task1_2_lagrange.m
% Task 1.2: Polynomial interpolation using Lagrange formula (Eq.2)

clear; clc; close all;

%% Step 1: Check algorithm with lecture example points
x_ex = [0; 1; 3];
y_ex = [1; 3; 2];
xq_ex = linspace(0, 3, 200);

yq_ex = lagrangeEq2(x_ex, y_ex, xq_ex);

% Lecture polynomial result for this example:
y_true = (-5*xq_ex.^2 + 17*xq_ex + 6)/6;

fprintf('Step 1 (example) max error = %.3e\n', max(abs(yq_ex - y_true)));

figure;
plot(x_ex, y_ex, 'o'); hold on;
plot(xq_ex, yq_ex, '-');
plot(xq_ex, y_true, '--');
title('Task 1.2 Step 1: Lagrange check (Eq.2)');
xlabel('x'); ylabel('y'); grid on;
legend('points','my lagrange','lecture polynomial');

%% Step 2: Apply to data_set_1 for -2 <= x <= 0
S = load('data_set_1.mat');
x = S.x(:); 
y = S.y(:);

% Sort
[x, idx] = sort(x);
y = y(idx);

% Subset in range -2 <= x <= 0
mask = (x >= -2) & (x <= 0);
xs = x(mask);
ys = y(mask);

xq = linspace(-2, 0, 400);
yq = lagrangeEq2(xs, ys, xq);

% Check "exactness" at the nodes
y_nodes = lagrangeEq2(xs, ys, xs);
fprintf('Step 2 (data, -2..0) max node error = %.3e\n', max(abs(y_nodes - ys)));

figure;
plot(xs, ys, 'o'); hold on;
plot(xq, yq, '-');
title('Task 1.2 Step 2: Lagrange on subset (-2 \le x \le 0)');
xlabel('x'); ylabel('y'); grid on;
legend('subset points','lagrange polynomial');

%% -------- local function (Eq.2) --------
function yq = lagrangeEq2(x, y, xq)
% Eq.(2): p(x) = sum_i y_i * L_i(x)
% L_i(x) = prod_{k != i} (x - x_k)/(x_i - x_k)

n = length(x);
yq = zeros(size(xq));

for m = 1:numel(xq)
    xm = xq(m);
    p = 0;

    for i = 1:n
        Li = 1;

        for k = 1:n
            if k ~= i   % skip k=i
                Li = Li * (xm - x(k)) / (x(i) - x(k));
            end
        end

        p = p + y(i) * Li;
    end

    yq(m) = p;
end
end
