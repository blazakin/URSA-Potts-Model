% File to run the model


nTrials = 2000; % Number of trials to observe
startup = 3 * 10^5; % Initial trials ignored
file = fullfile(pwd, "data", "data_to_run_on.png");
% Put data file in data subfolder
% Uncomment below for simple pore geometry
% file = "";

% Set 1 to save data, set 0 to display data
save_or_display = 1;

m = 50; % rows of model
n = 50; % columns of model
kT = 1; % Temperature applied to model
seed = 1;

% Interaction strength
rr = 0;
ww = 1;
ii = 0;
aa = 1;
rw = 0;
ri = -1;
wi = -1;
ra = -1;
wa = 0;
ia = -1;
interaction = [ww, ii, rr, aa, wi, ri, rw, ra, wa, ia];

data_collected = 2;
% Data collected cases:
% Case 1: Energy_over_nTrials
% Case 2: Energy_over_all_trials
% Case 3: model_over_trial
% Case 4: model_over_all
% Case 5: Energy_over_nTrials, model_over_trial
% Case 6: Energy_over_all_trials, model_over_all

Potts_Ising(nTrials, startup, m, n, kT, seed, interaction, ...
    data_collected, "Output_folder_name", file, save_or_display);

% Uncomment for repeated trials with different RNG seeds

% nTrials = 2000; startup = 3 * 10^6; m = 204; n = 204; kT = 1; seed = 1;
% rr = 0; ww = 0; ii = 0; aa = .5; 
% rw = 0; ri = -1; wi = -1; ra = -1; wa = 0; ia = -1;
% interaction = [ww, ii, rr, aa, wi, ri, rw, ra, wa, ia];
% 
% data_collected = 2;
% file = fullfile(pwd, "data", "data_to_run_on.png");
% save_or_display = 1;
% 
% for index = 1:1
%     Potts_Ising(nTrials, startup, m, n, kT, seed+index, interaction, ...
%         data_collected, ("Vglass_" + index), file, save_or_display);
% end