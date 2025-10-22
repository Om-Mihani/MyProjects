clc
close all
clear

%% Model Parameters
D = 1e-7;       % Diffusion coefficient [m²/s]
delta = 1e-4;   % Boundary layer thickness [m]
C_bulk = 1;     % Bulk concentration [mol/m³]
k1 = 1e-5;      % Adsorption rate [m/s]
k2 = 1e-6;      % Oxidation rate [mol/m²/s]
rho = 1e-5;     % Site density [mol/m²]
n = 2;          % Electrons transferred
F = 96485;      % Faraday constant [C/mol]
alpha = 0.5;    % Charge transfer coefficient
R = 8.314;      % Gas constant [J/mol·K]
T = 298;        % Temperature [K]

%% Hysteresis parameters
theta_on = 0.5;  % Threshold coverage for oxidation
theta_off = 0.1; % Threshold coverage for stopping oxidation

%% Simulation Parameters
tf = 10;        % Final time [s]
dt = 0.0001;    % Time step [s]
time = 0:dt:tf; % Time vector
nt = length(time); % Number of time steps

%% Bifurcation analysis parameters
eta_range = 0:0.005:0.4;  % Range of overpotential values
num_eta = length(eta_range);
bifurcation_data = zeros(num_eta, 3);  % [eta, min_theta, max_theta]

%% Main loop for bifurcation analysis
for e_idx = 1:num_eta
    eta = eta_range(e_idx);
    K = exp((alpha*n*F*eta)/(R*T)) - exp(-((1-alpha)*n*F*eta)/(R*T));
    
    % Initialize variables for this eta
    theta = zeros(1, nt);
    Y = 0;
    
    % Simulation loop
    for i = 2:nt-1
        % Determine if theta is increasing or decreasing
        if theta(i-1) < theta(i) % theta is increasing
            if theta(i) < theta_on
                Y = 0; % CO coverage increasing, oxidation OFF
            else
                Y = 1; % CO coverage increasing, oxidation ON
            end
        elseif theta(i-1) > theta(i) % theta is decreasing
            if theta(i) > theta_off
                Y = 1; % CO coverage decreasing, oxidation ON
            else
                Y = 0; % CO coverage decreasing, oxidation OFF
            end
        end
        
        % Surface concentration
        C_surf = C_bulk / (1 + (k1*delta*(1-theta(i)))/D);
        
        % Current density
        j0 = n*F*k2*theta(i);
        j = j0 * K * Y;
        
        % dtheta/dt calculation
        dtheta_dt = (k1*C_surf*(1-theta(i)) - j/(n*F)) / rho;
        
        % Update coverage using forward Euler
        theta(i+1) = theta(i) + dt*dtheta_dt;
        
        % Ensure theta stays within bounds [0, 1]
        theta(i+1) = max(0, min(1, theta(i+1)));
    end
    
    % Store bifurcation data
    steady_state_range = round(0.8*nt):nt;  % Consider last 20% of simulation as steady state
    bifurcation_data(e_idx, :) = [eta, min(theta(steady_state_range)), max(theta(steady_state_range))];
end

%% Plot bifurcation diagram
figure;

% Plot minimum theta values
plot(bifurcation_data(:,1), bifurcation_data(:,2), 'b-', 'LineWidth', 1); % Blue line
hold on;
plot(bifurcation_data(:,1), bifurcation_data(:,2), 'bx', 'MarkerSize', 5);


% Plot maximum theta values
plot(bifurcation_data(:,1), bifurcation_data(:,3), 'r-', 'LineWidth', 1); % Red line
plot(bifurcation_data(:,1), bifurcation_data(:,3), 'rx', 'MarkerSize', 5);

xlabel('Overpotential, \eta (V)');
ylabel('Surface Coverage, \theta');
title('Bifurcation Diagram: Surface Coverage vs. Overpotential');
grid on;

% Add legend
legend('Minimum \theta trend', 'Minimum \theta datapoint' ,'Maximum \theta trend', 'Maximum \theta datapoint', 'Location', 'best');

% Remove the highlighted bifurcation point in the legend
hLegend = findobj(gcf, 'Type', 'Legend');
set(hLegend, 'String', {'Minimum \theta trend', 'Minimum \theta datapoint' ,'Maximum \theta trend', 'Maximum \theta datapoint'});

% Save the figure
saveas(gcf, 'Bifurcation_Diagram.png');
disp('Bifurcation diagram saved as Bifurcation_Diagram.png');
