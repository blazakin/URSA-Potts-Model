function [spin, Energy_over_nTrials, Energy_over_all_trials, model_over_trial, model_over_all] = ...
    Metropolis(nTrials, startup, kT, data, data_collected, seed)
    % Runs the Metropolis algorithim on a Potts Model with 4 substances.


    rng(seed,"twister")

    m = data{1};
    n = data{2};
    spin = data{3};
    spin_info = data{4};
    irow = spin_info{1};
    icol = spin_info{2};
    wrow = spin_info{3};
    wcol = spin_info{4};
    arow = spin_info{5};
    acol = spin_info{6};
    interaction = data{5};
    Energy=0; % Initial Energy
    Energy_over_nTrials = NaN; % to histogram
    Energy_over_all_trials = NaN;
    model_over_trial = NaN;
    model_over_all = NaN;
    
    total_iter = startup+nTrials;

    switch(data_collected)
        case 1
            Energy_over_nTrials = zeros(1,nTrials); % to histogram
        case 2
            Energy_over_all_trials = zeros(1,total_iter);
        case 3
            model_over_trial = cell(1,nTrials); % to animate
        case 4
            model_over_all = cell(1,startup+nTrials);
        case 5
            Energy_over_nTrials = zeros(1,nTrials); % to histogram
            model_over_trial = cell(1,nTrials); % to animate
        case 6
            Energy_over_all_trials = zeros(1,total_iter);
            model_over_all = cell(1,startup+nTrials);
    end



    for index=1:m
        for j=1:n
            Energy = Energy + energy(index, j, spin(index, j), data);
        end
    end

    disp('     ');
    steps = 10;
    for t = 1:total_iter
        % Display progress
        if ~mod(t,floor((total_iter)*steps/100))
             fprintf('\b\b\b\b\b\b%05.2f%%', t/((total_iter))*100);
        end
    
        % Picking 2 random spins
        r = rand();
        tot_fluid = 2 * (size(wrow, 2) + size(irow, 2) + size(arow, 2));
        if r < ((size(wrow, 2) + size(irow, 2)) / tot_fluid)
            spin_1 = randi(size(wrow, 2));
            spin_2 = randi(size(irow, 2));
            row1 = wrow(spin_1);
            col1 = wcol(spin_1);
            row2 = irow(spin_2);
            col2 = icol(spin_2);
        elseif r < ((size(wrow, 2) + size(arow, 2)) / tot_fluid)
            spin_1 = randi(size(wrow, 2));
            spin_2 = randi(size(arow, 2));
            row1 = wrow(spin_1);
            col1 = wcol(spin_1);
            row2 = arow(spin_2);
            col2 = acol(spin_2);
        else
            spin_1 = randi(size(irow, 2));
            spin_2 = randi(size(arow, 2));
            row1 = irow(spin_1);
            col1 = icol(spin_1);
            row2 = arow(spin_2);
            col2 = acol(spin_2);
        end
        
    
        % Calculating the chenge in energy if the spins are swapped
        
        dE = (energy(row1, col1, spin(row1, col1), data) -... 
            energy(row1, col1, spin(row2, col2), data)) +...
            (energy(row2, col2, spin(row2, col2), data) -... 
            energy(row2, col2, spin(row1, col1), data));
    
        % Boltzmann probability of flipping
        prob = exp(-dE / kT);
    
        % Conditions for spin swap
        if dE <= 0 || rand() <= prob

            % Swapping spins in the index arrays
            if (spin(row1, col1) == 2) % spin 1 is water
                if (spin(row2, col2) == 3) % spin 2 is ice
                    wrow(spin_1) = row2;
                    wcol(spin_1) = col2;
                    irow(spin_2) = row1;
                    icol(spin_2) = col1;
                else % spin 2 is air
                    wrow(spin_1) = row2;
                    wcol(spin_1) = col2;
                    arow(spin_2) = row1;
                    acol(spin_2) = col1;
                end
            else % spin 1 is ice and spin 2 is air
                irow(spin_1) = row2;
                icol(spin_1) = col2;
                arow(spin_2) = row1;
                acol(spin_2) = col1;
            end

            % Swapping spins in the 2d array
            temp = spin(row1, col1);
            spin(row1, col1) = spin(row2, col2);
            spin(row2, col2) = temp;

            data = {m, n, spin, spin_info, interaction};
            if t > startup
                Energy = Energy + dE;
            end
        end
        
        switch data_collected
            case 2
                Energy_over_all_trials(t) = Energy;
            case 4
                model_over_all{t} = spin;
            case 6
                Energy_over_all_trials(t) = Energy;
                model_over_all{t} = spin;
        end
        
            
        if t > startup
            switch data_collected
                case 1
                    Energy_over_nTrials(t-startup) = Energy;
                case 3
                    model_over_trial{t-startup} = spin;
                case 5
                    Energy_over_nTrials(t-startup) = Energy;
                    model_over_trial{t-startup} = spin;
            end
        end
    end
    disp(' ');

end