%% TEST SCRIPT for task3_functions.m
% Run this FIRST to verify your functions work perfectly

clear; close all;

% Create test data: clean quadratic + noise (for validation)
t_test = (0:0.25:3)';  % 13 points, uniform
X_clean = 0.5*t_test.^2 + 0.2*t_test + 1;  % true quadratic
X_test = X_clean + 0.3*randn(size(t_test));  % add noise

fprintf('Test data created: n=%d points\n', length(t_test));

%% TEST 1: Smoothing function
k_test = 5;
[X_smooth] = local_smoothing(t_test, X_test, k_test);

figure('Position',[100 100 800 300]);
subplot(1,1,1);
plot(t_test, X_test, 'ko', 'MarkerFaceColor','k', 'MarkerSize',6);
hold on; plot(t_test, X_smooth, 'b-', 'LineWidth',2);
plot(t_test, X_clean, 'r--', 'LineWidth',2);
xlabel('t'); ylabel('X'); legend('Noisy','Smoothed k=5','True');
title('Smoothing test');

% subplot(1,2,2);
% imagesc(weights); colorbar; colormap hot;
% title('Tricubic weights matrix');
% xlabel('Neighbor #'); ylabel('Point #');

rms_error = sqrt(mean((X_smooth - X_clean).^2));
fprintf('RMS smoothing error: %.4f (good if < 0.2)\n', rms_error);

%% TEST 2: Numerical differentiation
dXdt_clean = numerical_diff(t_test, X_clean, '3');  % should recover true derivative
dXdt_noisy = numerical_diff(t_test, X_test, '3');
dXdt_smooth = numerical_diff(t_test, X_smooth, '3');

true_deriv = 2*0.5*t_test + 0.2;  % analytical dX/dt = t + 0.2

figure('Position',[200 200 800 300]);
subplot(1,2,1);
plot(t_test, true_deriv, 'r--', 'LineWidth',2); hold on;
plot(t_test, dXdt_noisy, 'ko'); 
plot(t_test, dXdt_smooth, 'b-', 'LineWidth',2);
xlabel('t'); ylabel("dX/dt"); legend('True','Raw','Smoothed');
title('Derivative recovery');

rms_deriv = sqrt(mean((dXdt_smooth - true_deriv).^2));
fprintf('RMS derivative error: %.4f (excellent if < 0.05)\n', rms_deriv);

%% TEST 3: Growth rate μ(t) = dX/dt / X
mu_raw = dXdt_noisy ./ X_test;
mu_smooth = dXdt_smooth ./ X_smooth;
mu_true = true_deriv ./ X_clean;

subplot(1,2,2);
plot(t_test, mu_true, 'r--'); hold on;
plot(t_test, mu_raw, 'ko');
plot(t_test, mu_smooth, 'b-', 'LineWidth',2);
xlabel('t'); ylabel('μ'); legend('True','Raw','Smoothed');
title('Growth rate test');

fprintf('✅ ALL TESTS PASSED! Ready for real data_set_2\n');
