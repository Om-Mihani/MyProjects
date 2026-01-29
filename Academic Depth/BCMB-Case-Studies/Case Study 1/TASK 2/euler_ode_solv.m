function [t, y] = euler_ode_solv(f, t0, tf, y0, N, p)
    t = linspace(t0, tf, N+1);
    h = t(2) - t(1);
    y = zeros(length(y0), N+1);

    y(:,1) = y0;

    for k = 1:N
        y(:,k+1) = y(:,k) + h * f(t(k), y(:,k), p);
    end

    y = y.';
end
