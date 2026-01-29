%Input_u for task 3

function u = input_u_task_3(t, p)
    u = zeros(2,1);
    % Constant input
    if ~isfield(p, 'freq')
        u(1) = 1;
    else
        % Sinusoidal input u = sin(freq * t) + 1
        u(1) = sin(p.freq * t) + p.p2;
    end

    u(2) = 1;
end