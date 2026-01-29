function dXdt = numerical_diff(t, X, order)
    % Numerical 1st derivative, handles boundaries
    % order: '2' (O(h^2), 3 points) or '3' (O(h^3), 4 points)
    n = length(t);
    h = t(2) - t(1);  % assumes uniform spacing
    dXdt = zeros(n,1);
    
    if strcmp(order, '3')
        % 3rd order: forward/backward + central
        for i = 1:n
            if i == 1                % forward
                dXdt(i) = (-11*X(1) + 18*X(2) - 9*X(3) + 2*X(4)) / (6*h);
            elseif i == n           % backward  
                dXdt(i) = (11*X(n) - 18*X(n-1) + 9*X(n-2) - 2*X(n-3)) / (6*h);
            elseif i == 2           % central 2nd order
                dXdt(i) = (X(3) - X(1)) / (2*h);
            elseif i == n-1         % central 2nd order
                dXdt(i) = (X(n) - X(n-2)) / (2*h);
            else                    % central 3rd order
                dXdt(i) = (-X(i+2) + 8*X(i+1) - 8*X(i-1) + X(i-2)) / (12*h);
            end
        end
    else  % default 2nd order central
        for i = 1:n
            if i == 1
                dXdt(i) = (-3*X(1) + 4*X(2) - X(3)) / (2*h);
            elseif i == n
                dXdt(i) = (3*X(n) - 4*X(n-1) + X(n-2)) / (2*h);
            else
                dXdt(i) = (X(i+1) - X(i-1)) / (2*h);
            end
        end
    end
end
