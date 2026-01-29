function dydt = model3(t, y, p)
    R1 = y(1);     
    R2 = y(2);     

    u = input_u_task_3(t, p);

    synthesis_1 = p.ks1 * u(1) / (1 + (R2 / p.K2)^p.n);
    degradation_1 = p.k1 * R1;

    synthesis_2 = p.ks2 * u(2) / (1 + (R1 / p.K1)^p.n2);
    degradation_2 = p.k2 * R2;

    dydt = [(synthesis_1 - degradation_1);(synthesis_2 - degradation_2)];
end