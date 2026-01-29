function dydt = model1(t, y, p)
    R1 = y;     % Only variable in Task 1
    R2 = 1;     % Task 1 requires R2 constant = 1

    u = input_u(t, p);

    synthesis = p.ks1 * u / (1 + (R2 / p.K2)^p.n);
    degradation = p.k1 * R1;

    dydt = synthesis - degradation;
end
