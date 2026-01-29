function dydt = model2(t, y, p)

    R1 = y(1);
    R2 = y(2);

    u1 = input_u(t, p);   % same input idea as Task 1
    u2 = 1;               % constant input for R2 (Task 2)

    % R1 equation (same structure as Task 1)
    synthesis_R1  = p.ks1 * u1 / (1 + (R2 / p.K2)^p.n);
    degradation_R1 = p.k1 * R1;

    % R2 equation (NEW in Task 2)
    synthesis_R2  = p.ks2 * u2;
    degradation_R2 = p.k2 * R2;

    dydt = [
        synthesis_R1 - degradation_R1;
        synthesis_R2 - degradation_R2
    ];
end
