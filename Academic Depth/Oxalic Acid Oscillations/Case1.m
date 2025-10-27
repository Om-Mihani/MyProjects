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
eta = 0.3;      % Overpotential [V]
R = 8.314;      % Gas constant [J/mol·K]
T = 298;        % Temperature [K]

%% Hysteresis parameters
theta_on = 0.5;  % Threshold coverage for oxidation
theta_off = 0.1; % Threshold coverage for stopping oxidation

%% Simulation Parameters
tf = 10;      % Final time [s]
dt = 0.0001;     % Reduced Time step [s]
time = 0:dt:tf;  % Time vector
nt = length(time); % Number of time steps

%% Initialize variables
theta = zeros(1, nt);   % Surface coverage

%% Derived Parameters
K = exp((alpha*n*F*eta)/(R*T)) - exp(-((1-alpha)*n*F*eta)/(R*T)); % Constant term in BV Equation

%% Simulation loop
Y = 0; % Initialize Hysteresis Function
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

%% Plotting
plot(time, theta);
xlabel('Time (s)');
ylabel('Surface Coverage, \theta');
title('Surface Coverage vs. Time');
grid on;
