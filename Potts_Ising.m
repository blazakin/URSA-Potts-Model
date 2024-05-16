function [] = Potts_Ising(nTrials, startup, m, n, kT, seed, interaction, ...
    data_collected, batch, file, save_or_display)
    % Initializes a Potts model with four substances, run 
    % Metropolis algorithm, and save or display resulting data.

    
    % Initial configuration
    if file == ""
        [spin, spin_info] = InitSpin(m, n, seed);
        data = {m, n, spin, spin_info, interaction};
    else
       [spin, spin_info] = DataToSpin(m, n, file, seed);
        data = {m, n, spin, spin_info, interaction}; 
    end

    % Model running
    model_init = spin;
    [spin, Energy_over_nTrials, Energy_over_all_trials, model_over_trial, model_over_all] = ...
        Metropolis(nTrials, startup, kT, data, data_collected, seed);
    model_end = spin;
    
    % Saving Model Data
    if save_or_display == 1
        SaveData(data_collected, model_init, model_end, ... 
            Energy_over_nTrials, Energy_over_all_trials, model_over_trial, ... 
            model_over_all, nTrials, startup, batch, pwd);
    else

        DisplayData(data_collected, model_init, model_end, ... 
            Energy_over_nTrials, Energy_over_all_trials, model_over_trial, ... 
            model_over_all, nTrials, startup);
    end

    % Energy = Energy/sum(sum(ones(m,n)))

end