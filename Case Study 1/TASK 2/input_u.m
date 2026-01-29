function u = input_u(t, p)
    if ~isfield(p, 'freq')
        % Constant input
        u = 1;
    else
        % Sinusoidal input with frequency
        u = 1 + sin(p.freq*t);
    end
end
