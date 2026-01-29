function u = input_u(t, p)
    % Constant input
    if ~isfield(p, 'freq')
        u = 1;
    else
        % Sinusoidal input u = sin(freq * t) + 1
        u = sin(p.freq * t) + 1;
    end
end
