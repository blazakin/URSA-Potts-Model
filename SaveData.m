function [] = SaveData(data_collected, model_init, model_end, ... 
    Energy_over_nTrials, Energy_over_all_trials, model_over_trial, ... 
    model_over_all, nTrials, startup, batch, defaultDir)
    % Saves data to files

    batch_folder = fullfile(defaultDir, batch);
    mkdir(batch_folder);
    dir = fullfile(batch_folder, "/images/");
    vdir = fullfile(batch_folder, "/video/");
    mkdir(dir);

    switch(data_collected)
        case 1
            f1 = figure('visible','off');
            plot(Energy_over_nTrials)
            export_fig((dir + batch + "_Plot_E_nTrials.png"),"-png", f1)
            f2 = figure('visible','off');
            histogram(Energy_over_nTrials)
            export_fig((dir + batch + "_Hist_E_nTrials.png"),"-png", f2)
        case 2
            f3 = figure('visible','off');
            plot(Energy_over_all_trials)
            export_fig((dir + batch + "_Plot_E_aTrials.png"),"-png", f3)
            f4 = figure('visible','off');
            histogram(Energy_over_all_trials)
            export_fig((dir + batch + "_Hist_E_aTrials.png"),"-png", f4)
        case 3
            mkdir(vdir);
            f5 = figure('visible','off');
            for k = 1:200
                DisplaySpin(model_over_trial{k*(nTrials)/(200)})
                export_fig((vdir + batch + "_" + k + "_Model_nTrials.png"),"-png", f5, '-q101', '-a1')
            end
            SaveVideo(vdir, batch, "_Model_nTrials", 200);
        case 4
            mkdir(vdir);
            f6 = figure('visible','off');
            for k = 1:200
                DisplaySpin(model_over_all{k*(nTrials + startup)/(200)})
                export_fig((vdir + batch + "_" + k + "_Model_aTrials.png"),"-png", f6, '-q101', '-a1')
            end
            SaveVideo(vdir, batch, "_Model_aTrials", 200);
        case 5
            mkdir(vdir);
            f7 = figure('visible','off');
            for k = 1:200
                DisplaySpin(model_over_trial{k*(nTrials)/(200)})
                export_fig((vdir + batch + "_" + k + "_Model_nTrials.png"),"-png", f7, '-q101', '-a1')
            end
            SaveVideo(vdir, batch, "_Model_nTrials", 200);
            f8 = figure('visible','off');
            plot(Energy_over_nTrials)
            export_fig((dir + batch + "_Plot_E_nTrials"),"-png", f8, '-q101', '-a1')
            f9 = figure('visible','off');
            histogram(Energy_over_nTrials)
            export_fig((dir + batch + "_Hist_E_nTrials"),"-png", f9, '-q101', '-a1')
        case 6
            mkdir(vdir);
            f10 = figure('visible','off');
            for k = 1:200
                DisplaySpin(model_over_all{k*(nTrials + startup)/(200)})
                pause(.000001);
                export_fig((vdir + batch + "_" + k + "_Model_nTrials.png"),"-png", f10, '-q101', '-a1')
            end
            SaveVideo(vdir, batch, "_Model_aTrials", 200);
            f11 = figure('visible','off');
            plot(Energy_over_all_trials)
            export_fig((dir + batch + "_Plot_E_aTrials"),"-png", f11)
            f12 = figure('visible','off');
            histogram(Energy_over_all_trials)
            export_fig((dir + batch + "_Hist_E_aTrials"),"-png", f12)
    end


    f13 = figure('visible','off');
    DisplaySpin(model_init)
    export_fig((dir + batch + "_Model_Init"),"-png", f13)
    f14 = figure('visible','off');
    DisplaySpin(model_end)
    export_fig((dir + batch + "_Model_End"),"-png", f14)
    
    
end