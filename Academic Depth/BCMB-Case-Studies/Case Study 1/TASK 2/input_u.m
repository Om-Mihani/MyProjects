function u = input_u(t, p)
    if ~isfield(p, 'freq')
        % Constant input
        u = 1;
    else
        % Sinusoidal input with frequency in Hz
        u = 1 + sin(2*pi*p.freq*t);
    end
end
