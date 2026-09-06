function conso = tester_mode_facteur(valeur_mode)
    in = Simulink.SimulationInput('gearbox_sim');
    in = in.setVariable('Mode_facteur', valeur_mode);
    in = in.setModelParameter('StopTime', '60');
    simOut = sim(in);
    conso = simOut.logsout{1}.Values.Data(end);
end