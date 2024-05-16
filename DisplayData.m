function [] = DisplayData(data_collected, model_init, model_end, ... 
    Energy_over_nTrials, Energy_over_all_trials, model_over_trial, ... 
    model_over_all, nTrials, startup)
    % Displays the data as matlab figures


    switch(data_collected)
        case 1
            figure;
            plot(Energy_over_nTrials)
            figure;
            histogram(Energy_over_nTrials)
        case 2
            figure;
            plot(Energy_over_all_trials)
            figure;
            histogram(Energy_over_all_trials)
        case 3
            figure;
            for k = 1:200
                DisplaySpin(model_over_trial{k*(nTrials)/(200)})
                pause(.000001);
                %exportgraphics(gcf, 'Potts_20by200_lowT.gif', Append=true);
            end
        case 4
            figure;
            for k = 1:200
                DisplaySpin(model_over_all{k*(nTrials + startup)/(200)})
                pause(.000001);
                %exportgraphics(gcf, 'Potts_20by200_lowT.gif', Append=true);
            end
        case 5
            figure;
            for k = 1:200
                DisplaySpin(model_over_trial{k*(nTrials)/(200)})
                pause(.000001);
                %exportgraphics(gcf, 'Potts_20by200_lowT.gif', Append=true);
            end
            figure;
            plot(Energy_over_nTrials)
            figure;
            histogram(Energy_over_nTrials)
        case 6
            figure;
            for k = 1:200
                DisplaySpin(model_over_all{k*(nTrials + startup)/(200)})
                pause(.000001);
                %exportgraphics(gcf, 'Potts_20by200_lowT.gif', Append=true);
            end
            figure;
            plot(Energy_over_all_trials)
            figure;
            histogram(Energy_over_all_trials)
    end
    
    figure;
    DisplaySpin(model_init)
    % print -deps 1000by400_init_300mill.eps
    figure;
    DisplaySpin(model_end)
    % print -depsc 1000by400_end_300mil.eps
    
end