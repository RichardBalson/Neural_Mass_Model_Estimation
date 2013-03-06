% script created by Richard Balson 20/01/2013

% description
% ~~~~~~~~~~~
% this script generates figures for UKF estimation results for the Document
% for the Boon group

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

% Generic Figure handling parameters

label_fontsize = 10;            % point
tick_fontsize = 8;              % point
fig_left_pos = 5;               % cms
fig_bottom_pos = 5;             % cms
font_type = 'Arial';
fig_dirname = Estimation_type;              % default directory for figure files

% Plot of output
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

maxlimit = round(frequency/10):length(check);

scale = 0.5;

% % Plot of state 1
% % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Error_multiplier = 1/dt;

index = {1:length(check) initialz:endz EstStart_Sample:limit initialRz:endRz}; % index{1} for full simulation and estimation, index{2} for zoomed in figures

if (Image_handling_model_output(1,1) ==1)
    
    fig_name = 'Neural Mass Output';
    EEG_Figure;
    NMO = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,Y(index{1}),NoisyObSCol)
    hold on
    plot(t,ExpY,EstCol)
    hold on
    plot(t,check(index{1}),SimCol);
    set(gca,'fontsize',tick_fontsize)
     box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    % title('Pyramidal Population Input','fontsize', label_fontsize)
    k = legend('Noisy Obs.','Estimated Obs.','Obs.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(Y(index{3})); minc(2) = min(ExpY);
    maxc(1) = max(Y(index{3})); maxc(2) = max(ExpY);
    axis([0 max(t) (min(minc)-abs(min(minc))*scalemin) (max(maxc)+abs(max(maxc))*scale)]);
   
    
end

if (Image_handling_model_output(2,1) ==1)
    
    fig_name = 'Neural Mass Output Zoomed In';
    EEG_Figure;
    NMOZ = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,Y(index{2}),SimCol)
    hold on
    plot(tz,ExpY(index{2}),EstCol)
    hold on
    plot(tz,check(index{2}),NoiseObsCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Pyramidal Population Input','fontsize', label_fontsize)
    k=legend('Noisy Obs.','Est. Obs.','Obs.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(Y(index{2})); minc(2) = min(ExpY(index{2}));
    maxc(1) = max(Y(index{2})); maxc(2) = max(ExpY(index{2}));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    % Print image with resolution 600 to pdf test.
    
end

if (Image_handling_states(1,1) ==1)
    % Plot of state 1
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    fig_name = 'Neural Mass State1 (V_{po})';
    EEG_Figure;
    NMS(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},1),SimCol)
    hold on
    plot(t,X(1,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
           
            erfn = X(1,index{1})-squeeze(sqrt(Pxx(1,1,index{1})*Error_multiplier))';
            erfp = X(1,index{1})+squeeze(sqrt(Pxx(1,1,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(1,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    % title('Pyramidal Population Output','fontsize', label_fontsize)
    k=legend('Sim. V_{po}','Est. V_{po}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},1));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},1));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(2,1) ==1)
    fig_name = 'Neural Mass State1 (V_{po}) Zoomed In';
    EEG_Figure;
    NMSZ(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},1),SimCol)
    hold on
    plot(tz,X(1,index{2}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(1,index{2})-squeeze(sqrt(Pxx(1,1,index{2})*Error_multiplier))';
            erfp = X(1,index{2})+squeeze(sqrt(Pxx(1,1,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(1,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Pyramidal Population Output','fontsize', label_fontsize)
    k= legend('Sim. V_{po}','Est. V_{po}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    minc(1) = min(erfn); minc(2) = min(z(index{4},1));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},1));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(1,2) ==1)
    
    % Plot of state 2
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State2 (V_{eo})';
    EEG_Figure;
    NMS(2) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},2),SimCol)
    hold on
    plot(t,X(2,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(2,index{1})-squeeze(sqrt(Pxx(2,2,index{1})*Error_multiplier))';
            erfp = X(2,index{1})+squeeze(sqrt(Pxx(2,2,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(2,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    % title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},2));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},2));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. V_{eo}','Est. V_{eo}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(2,2) ==1)
    fig_name = 'Neural Mass State2 (V_{eo}) Zoomed In';
    EEG_Figure;
    NMSZ(2)= figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},2),SimCol)
    hold on
    plot(tz,X(2,index{2}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(2,index{2})-squeeze(sqrt(Pxx(2,2,index{2})*Error_multiplier))';
            erfp = X(2,index{2})+squeeze(sqrt(Pxx(2,2,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(2,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(erfn); minc(2) = min(z(index{4},2));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},2));
    k=legend('Sim. V_{eo}','Est. V_{eo}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(1,3) ==1)
    
    % Plot of state 3
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State3 (V_{sio})';
    EEG_Figure;
    NMS(3) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},3),SimCol)
    hold on
    plot(t,X(3,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(3,index{1})-squeeze(sqrt(Pxx(3,3,index{1})*Error_multiplier))';
            erfp = X(3,index{1})+squeeze(sqrt(Pxx(3,3,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(3,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    % title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},3));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},3));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. V_{sio}','Est. V_{sio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    % Print image with resolution 600 to pdf test.
    set(k,'fontsize',legend_fontsize);
end

if (Image_handling_states(2,3) ==1)
    fig_name = 'Neural Mass State3 (V_{eo}) Zoomed In';
    EEG_Figure;
    NMSZ(3) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},3),SimCol)
    hold on
    plot(tz,X(3,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(3,index{2})-squeeze(sqrt(Pxx(3,3,index{2})*Error_multiplier))';
            erfp = X(3,index{2})+squeeze(sqrt(Pxx(3,3,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(3,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(erfn); minc(2) = min(z(index{4},3));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},3));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. V_{sio}','Est. V_{sio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(1,4) ==1)
    
    % Plot of state 4
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State4 (V_{fio})';
    EEG_Figure;
    NMS(4) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},4),SimCol)
    hold on
    plot(t,X(4,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(4,index{1})-squeeze(sqrt(Pxx(4,4,index{1})*Error_multiplier))';
            erfp = X(4,index{1})+squeeze(sqrt(Pxx(4,4,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(4,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    % title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},4));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},4));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. V_{fio}','Est. V_{fio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

if (Image_handling_states(2,4) ==1)
    fig_name = 'Neural Mass State4 (V_{fio}) ZoomedIn';
    EEG_Figure;
    NMSZ(4) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},4),SimCol)
    hold on
    plot(tz,X(4,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(4,index{2})-squeeze(sqrt(Pxx(4,4,index{2})*Error_multiplier))';
            erfp = X(4,index{2})+squeeze(sqrt(Pxx(4,4,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(4,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(erfn); minc(2) = min(z(index{4},4));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},4));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. V_{fio}','Est. V_{fio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(1,5) ==1)
    % Plot of state 5
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State5 (Z_{po})';
    EEG_Figure;
    NMS(5) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},5),SimCol)
    hold on
    plot(t,X(5,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(5,index{1})-squeeze(sqrt(Pxx(5,5,index{1})*Error_multiplier))';
            erfp = X(5,index{1})+squeeze(sqrt(Pxx(5,5,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(5,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    % title('Rate of Change of Vp','fontsize', label_fontsize)% Pyramidal cells
    % rate of change
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},5));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},5));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Z_{po}','Est. Z_{po}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

if (Image_handling_states(2,5) ==1)
    fig_name = 'Neural Mass State5 (Z_{po}) Zoomed In';
    EEG_Figure;
    NMSZ(5) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{2},5),SimCol)
    hold on
    plot(tz,X(5,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(5,index{2})-squeeze(sqrt(Pxx(5,5,index{2})*Error_multiplier))';
            erfp = X(5,index{2})+squeeze(sqrt(Pxx(5,5,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(5,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vp','fontsize', label_fontsize)
    minc(1) = min(erfn); minc(2) = min(z(index{2},5));
    maxc(1) = max(erfp); maxc(2) = max(z(index{2},5));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Z_{po}','Est. Z_{po}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
end

% Plot of state 6
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if (Image_handling_states(1,6) ==1)
    fig_name = 'Neural Mass State6 (Z_{eo})';
    EEG_Figure;
    NMS(6) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},6),SimCol)
    hold on
    plot(t,X(6,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(6,index{1})-squeeze(sqrt(Pxx(6,6,index{1})*Error_multiplier))';
            erfp = X(6,index{1})+squeeze(sqrt(Pxx(6,6,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(6,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    % title('Rate of Change of Ve','fontsize', label_fontsize)
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},6));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},6));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Simulated Z_{eo}','Estimated Z_{eo}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

if (Image_handling_states(2,6) ==1)
    fig_name = 'Neural Mass State6 (Z_{eo} Zoomed In)';
    EEG_Figure;
    NMSZ(6) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},6),SimCol)
    hold on
    plot(tz,X(6,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(6,index{2})-squeeze(sqrt(Pxx(6,6,index{2})*Error_multiplier))';
            erfp = X(6,index{2})+squeeze(sqrt(Pxx(6,6,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(6,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Ve','fontsize', label_fontsize)
    minc(1) = min(erfn); minc(2) = min(z(index{4},6));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},6));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Simulated Z_{e}','Estimated Z_{e}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

if (Image_handling_states(1,7) ==1)
    
    % Plot of state 7
    % ~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State7 (Z_{sio})';
    EEG_Figure;
    NMS(7) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},7),SimCol)
    hold on
      plot(t,X(7,index{1}),EstCol)
      hold on
    if (plot_uncertainty ==1)
            erfn = X(7,index{1})-squeeze(sqrt(Pxx(7,7,index{1})*Error_multiplier))';
            erfp = X(7,index{1})+squeeze(sqrt(Pxx(7,7,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(7,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    % title('Rate of Change of Vsi','fontsize', label_fontsize)
    k=legend('Simulated Z_{sio}','Estimated Z_{sio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},7));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},7));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end

if (Image_handling_states(2,7) ==1)
    fig_name = 'Neural Mass State7 (Z_{sio}) Zoomed In';
    EEG_Figure;
    NMSZ(7) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},7),SimCol)
    hold on
    plot(tz,X(7,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(7,index{2})-squeeze(sqrt(Pxx(7,7,index{2})*Error_multiplier))';
            erfp = X(7,index{2})+squeeze(sqrt(Pxx(7,7,index{2})*Error_multiplier))';
        plot(tz,erfn,ErrCol);
        hold on
        plot(tz,erfp,ErrCol);
                              else
            erfn =X(7,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vsi','fontsize', label_fontsize)
    k=legend('Simulated Z_{sio}','Estimated Z_{sio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(erfn); minc(2) = min(z(index{4},7));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},7));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    
end


if (Image_handling_states(1,8) ==1)
    % Plot of state 8
    % ~~~~~~~~~~~~~~~~
    fig_name = 'Neural Mass State8 (Z_{fio})';
    EEG_Figure;
    NMS(8) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,z(index{3},8),SimCol)
    hold on
    plot(t,X(8,index{1}),EstCol)
    hold on
    if (plot_uncertainty ==1)
            erfn = X(8,index{1})-squeeze(sqrt(Pxx(8,8,index{1})*Error_multiplier))';
            erfp = X(8,index{1})+squeeze(sqrt(Pxx(8,8,index{1})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(8,index{1});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    % title('Rate of Change of Vfi','fontsize', label_fontsize)
    k=legend('Simulated Z_{fio}','Estimated Z_{fio}','Std. Dev.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},8));
    maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},8));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end

if (Image_handling_states(2,8) ==1)
    fig_name = 'Neural Mass State8 (Z_{fio})';
    EEG_Figure;
    NMSZ(8) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(index{4},8),SimCol)
    hold on
    plot(tz,X(8,index{2}),EstCol)
        hold on
    if (plot_uncertainty ==1)
            erfn = X(8,index{2})-squeeze(sqrt(Pxx(8,8,index{2})*Error_multiplier))';
            erfp = X(8,index{2})+squeeze(sqrt(Pxx(8,8,index{2})*Error_multiplier))';
        plot(t,erfn,ErrCol);
        hold on
        plot(t,erfp,ErrCol);
                              else
            erfn =X(8,index{2});
            erfp = erfn;
    end
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vfi','fontsize', label_fontsize)
    k=legend('Simulated Zfi','Estimated Zfi','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(erfn); minc(2) = min(z(index{4},8));
    maxc(1) = max(erfp); maxc(2) = max(z(index{4},8));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    
end

% Plot input states
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~

if Dk ==1
    if (Image_handling_states(1,9) ==1)
        fig_name = 'Neural Mass State9 (Input)';
        EEG_Figure;
        NMS(9) = figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        if Dk ==1
            plot(t,X(Ds+1,index{1}),EstCol)
            hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+1,index{1})-squeeze(sqrt(Pxx(Ds+1,Ds+1,index{1})*Error_multiplier))';
                    erfp = X(Ds+1,index{1})+squeeze(sqrt(Pxx(Ds+1,Ds+1,index{1})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
                hold on
                                      else
            erfn =X(Ds+1,index{1});
            erfp = erfn;
            end
        end
        plot(t,meanf*ones(length(t),1),SimCol);
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('Input (Hz)','fontsize',label_fontsize)
        minc(1) = min(erfn(maxlimit)); minc(2) = meanf;
        maxc(1) = max(erfp(maxlimit)); maxc(2) = meanf;
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
            k=legend('Simulated Input','Estimated Input','Std. Dev.','Location',legLoc,'Orientation',legOri);
            legend(k,'boxoff');
            set(k,'fontsize',legend_fontsize);
    end
    
    
    if (Image_handling_states(2,9) ==1)
        fig_name = 'Neural Mass State9 (Input) Zoomed In';
        EEG_Figure;
        NMSZ(9) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,meanf*ones(length(tz),1),SimCol)
        hold on
        plot(tz,X(Ds+1,index{2}),EstCol)
                    hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+1,index{2})-squeeze(sqrt(Pxx(Ds+1,Ds+1,index{2})*Error_multiplier))';
                    erfp = X(Ds+1,index{2})+squeeze(sqrt(Pxx(Ds+1,Ds+1,index{2})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
                        else
            erfn =X(Ds+1,index{2});
            erfp = erfn;
            end
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('Firing rate (Hz)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Simulated Input','Estimated Input','Location',legLoc,'Orientation',legOri);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(erfn); minc(2) = meanf;
        maxc(1) = max(erfp); maxc(2) = meanf;
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        
    end
    
end

% Determine whether to plot parameter estimates
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~

if Dp >0
    if (Image_handling_states(1,10) ==1)
        fig_name = 'Neural Mass State10 (A)';
        EEG_Figure;
        NMS(10) = figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(t,MVI(index{3},1),SimCol)
        hold on
        plot(t,X(Ds+Dk+1,index{1}),EstCol)
        hold on
        if (plot_uncertainty ==1)
                erfn = X(Ds+Dk+1,index{1})-squeeze(sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,index{1})*Error_multiplier))';
                erfp = X(Ds+Dk+1,index{1})+squeeze(sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,index{1})*Error_multiplier))';
            plot(t,erfn,ErrCol);
            hold on
            plot(t,erfp,ErrCol);
        else
            erfn =X(Ds+Dk+1,index{1});
            erfp = erfn;
        end
        minc(1) = min(erfn(maxlimit)); minc(2) = min(MVI(index{3},1));
        maxc(1) = max(erfp(maxlimit)); maxc(2) = max(MVI(index{3},1));
        axis([0 max(t) min(minc) max(maxc)]);
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('Excitability (mV)','fontsize',label_fontsize)
        %     title('Estimated Excitability','fontsize', label_fontsize)
        k= legend('Sim.','Est.','Std. Dev.','Location',legLoc,'Orientation',legOri);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
    end
    
    
    if (Image_handling_states(2,10) ==1)
        fig_name = 'Neural Mass State10 (A) Zoomed In';
        EEG_Figure;
        NMSZ(10) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(index{4},1),SimCol)
        hold on
        plot(tz,X(Ds+Dk+1,index{2}),EstCol)
                hold on
        if (plot_uncertainty ==1)
                erfn = X(Ds+Dk+1,index{2})-squeeze(sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,index{2})*Error_multiplier))';
                erfp = X(Ds+Dk+1,index{2})+squeeze(sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,index{2})*Error_multiplier))';
            plot(t,erfn,ErrCol);
            hold on
            plot(t,erfp,ErrCol);
        else
            erfn =X(Ds+Dk+1,index{2});
            erfp = erfn;
        end
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('A (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Sim.','Est.','Std. Dev.','Location',legLoc,'Orientation',legOri);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(erfn); minc(2) = min(MVI(index{4},1));
        maxc(1) = max(erfp); maxc(2) = max(MVI(index{4},1));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        
    end
    
    
    if Dp > 1
        if (Image_handling_states(1,11) ==1)
            fig_name = 'Neural Mass State11 (B)';
            EEG_Figure;
            NMS(11) = figure('name','Estimation of Slow Inhibition',...
                'units','centimeters',...
                'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
                'papersize',[fig_width fig_height],...
                'filename',fig_dirandname,...
                'PaperPositionMode','auto');
            plot(t,MVI(index{3},2),SimCol)
            hold on
            plot(t,X(Ds+Dk+2,index{1}),EstCol)
            hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+Dk+2,index{1})-squeeze(sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,index{1})*Error_multiplier))';
                    erfp = X(Ds+Dk+2,index{1})+squeeze(sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,index{1})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =X(Ds+Dk+2,index{1});
            erfp = erfn;
            end
            minc(1) = min(erfn(maxlimit)); minc(2) = min(MVI(index{3},2));
            maxc(1) = max(erfp(maxlimit)); maxc(2) = max(MVI(index{3},2));
            axis([0 max(t) min(minc) max(maxc)]);
            set(gca,'fontsize',tick_fontsize)
            box off
            xlabel('Time (s)','fontsize',label_fontsize)
            ylabel('B (mV)','fontsize',label_fontsize)
                        k=legend('Sim.','Est.','Location',legLoc,'Orientation',legOri);
            %         title('Estimated Slow Inhibition','fontsize',
            %         label_fontsize)
            legend(k,'boxoff');
            set(k,'fontsize',legend_fontsize);
        end
        
        
        if (Image_handling_states(2,11) ==1)
            fig_name = 'Neural Mass State11 (B) Zoomed In';
            EEG_Figure;
            NMSZ(11) =figure('name',fig_name,...
                'units','centimeters',...
                'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
                'papersize',[fig_width fig_height],...
                'filename',fig_dirandname,...
                'PaperPositionMode','auto');
            plot(tz,MVI(index{4},2),SimCol)
            hold on
            plot(tz,X(Ds+Dk+2,index{2}),EstCol)
            hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+Dk+2,index{2})-squeeze(sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,index{2})*Error_multiplier))';
                    erfp = X(Ds+Dk+2,index{2})+squeeze(sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,index{2})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =X(Ds+Dk+2,index{2});
            erfp = erfn;
            end
            set(gca,'fontsize',tick_fontsize)
            box off
            xlabel('Time (s)','fontsize',label_fontsize)
            ylabel('B (mV)','fontsize',label_fontsize)
            %     title('Rate of Change of Vfi','fontsize', label_fontsize)
            k=legend('Sim.','Est.','Location',legLoc,'Orientation',legOri);
            legend(k,'boxoff');
            set(k,'fontsize',legend_fontsize);
            minc(1) = min(erfn); minc(2) = min(MVI(index{4},2));
            maxc(1) = max(erfp); maxc(2) = max(MVI(index{4},2));
            axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
            
        end
        
        if Dp ==3
            if (Image_handling_states(1,12) ==1)
                fig_name = 'Neural Mass State12 (G)';
                EEG_Figure;
                NMS(12) = figure('name',fig_name,...
                    'units','centimeters',...
                    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
                    'papersize',[fig_width fig_height],...
                    'filename',fig_dirandname,...
                    'PaperPositionMode','auto');
                plot(t,MVI(index{3},3),SimCol)
                hold on
                plot(t,X(Ds+Dk+3,index{1}),EstCol)
                hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+Dk+3,index{1})-squeeze(sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,index{1})*Error_multiplier))';
                    erfp = X(Ds+Dk+3,index{1})+squeeze(sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,index{1})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =X(Ds+Dk+3,index{1});
            erfp = erfn;
            end
                minc(1) = min(erfn); minc(2) = min(MVI(index{3},3));
                maxc(1) = max(erfp); maxc(2) = max(MVI(index{3},3));
                axis([0 max(t) min(minc) max(maxc)]);
                set(gca,'fontsize',tick_fontsize)
                box off
                xlabel('Time (s)','fontsize',label_fontsize)
                ylabel('G (mV)','fontsize',label_fontsize)
                %             title('Estimated Fast Inhibition','fontsize', label_fontsize)
                k=legend('Simulated','Estimated','Std. Dev.','Location',legLoc,'Orientation',legOri);
                legend(k,'boxoff');
                set(k,'fontsize',legend_fontsize);
            end
            
            
            if (Image_handling_states(2,12) ==1)
                fig_name = 'Neural Mass State12 (G) Zoomed In';
                EEG_Figure;
                NMSZ(12) =figure('name',fig_name,...
                    'units','centimeters',...
                    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
                    'papersize',[fig_width fig_height],...
                    'filename',fig_dirandname,...
                    'PaperPositionMode','auto');
                plot(tz,MVI(index{4},3),SimCol)
                hold on
                plot(tz,X(Ds+Dk+3,index{2}),EstCol)
                                hold on
            if (plot_uncertainty ==1)
                    erfn = X(Ds+Dk+3,index{2})-squeeze(sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,index{2})*Error_multiplier))';
                    erfp = X(Ds+Dk+3,index{2})+squeeze(sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,index{2})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =X(Ds+Dk+3,index{2});
            erfp = erfn;
            end
                set(gca,'fontsize',tick_fontsize)
                box off
                xlabel('Time (s)','fontsize',label_fontsize)
                ylabel('G (mV)','fontsize',label_fontsize)
                %     title('Rate of Change of Vfi','fontsize', label_fontsize)
                k=legend('Sim.','Est.','Location',legLoc,'Orientation',legOri);
                legend(k,'boxoff');
                set(k,'fontsize',legend_fontsize);
                minc(1) = min(erfn); minc(2) = min(MVI(index{4},3));
                maxc(1) = max(erfp); maxc(2) = max(MVI(index{4},3));
                axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
            end
        end
    end
end

%%

% Plot inputs to each neural population
%  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if (Image_handling_inputs(1,1) ==1)
    fig_name = 'Neural Mass State1 Input (V_{p})';
    EEG_Figure;
    NMSI(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,Y(index{1}),SimCol)
    hold on
    plot(t,ExpY(index{1}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{p} (mV)','fontsize',label_fontsize)
%     title('Pyramidal Population Output','fontsize', label_fontsize)
    k= legend('Sim.','Est.','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    minc(1) = min(ExpY(index{1})); minc(2) = min(Y(index{1}));
    maxc(1) = max(ExpY(index{1})); maxc(2) = max(Y(index{1}));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
end

if (Image_handling_inputs(2,1) ==1)
    fig_name = 'Neural Mass State1 (V_{p}) Zoomed In';
    EEG_Figure;
    NMSIZ(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,Y(index{2}),SimCol)
    hold on
    plot(tz,ExpY(index{2}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{p} (mV)','fontsize',label_fontsize)
%     title('Pyramidal Population Output','fontsize', label_fontsize)
    k= legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    minc(1) = min(ExpY(index{2})); minc(2) = min(Y(index{2}));
    maxc(1) = max(ExpY(index{2})); maxc(2) = max(Y(index{2}));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
end

if (Image_handling_inputs(1,2) ==1)
    fig_name = 'Neural Mass State2 (V_{e})';
    EEG_Figure;
    NMSIZ(2)= figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,C(1)*z(index{3},1),SimCol)
    hold on
    plot(t,C(1)*X(1,index{1}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{e} (mV)','fontsize',label_fontsize)
%     title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(C(1)*X(1,index{1})); minc(2) = min(C(1)*z(index{3},1));
    maxc(1) = max(C(1)*X(1,index{1})); maxc(2) = max(C(1)*z(index{3},1));
    k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
end

if (Image_handling_inputs(2,2) ==1)
    fig_name = 'Neural Mass State2 Input (V_{e}) Zoomed In';
    EEG_Figure;
    NMSIZ(2)= figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(1)*z(index{4},1),SimCol)
    hold on
    plot(tz,C(1)*X(1,index{2}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{e} (mV)','fontsize',label_fontsize)
%     title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(C(1)*X(1,index{2})); minc(2) = min(C(1)*z(index{4},1));
    maxc(1) = max(C(1)*X(1,index{2})); maxc(2) = max(C(1)*z(index{4},1));
    k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
end

if (Image_handling_inputs(1,3) ==1)
    fig_name = 'Neural Mass State3 Input (V_{si})';
    EEG_Figure;
    NMSIZ(3) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,C(3)*z(index{3},1),SimCol)
    hold on
    plot(t,C(3)*X(1,index{1}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{si} (mV)','fontsize',label_fontsize)
%     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(3)*X(1,index{1})); minc(2) = min(C(3)*z(index{3},1));
    maxc(1) = max(C(3)*X(1,index{1})); maxc(2) = max(C(3)*z(index{3},1));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end

if (Image_handling_inputs(2,3) ==1)
    fig_name = 'Neural Mass State3 Input (V_{si}) Zoomed In';
    EEG_Figure;
    NMSIZ(3) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(3)*z(index{4},1),SimCol)
    hold on
    plot(tz,C(3)*X(1,index{2}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{si} (mV)','fontsize',label_fontsize)
%     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(3)*X(1,index{2})); minc(2) = min(C(3)*z(index{4},1));
    maxc(1) = max(C(3)*X(1,index{2})); maxc(2) = max(C(3)*z(index{4},1));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end

if (Image_handling_inputs(1,4) ==1)
    fig_name = 'Neural Mass State4 Input (V_{fi})';
    EEG_Figure;
    NMSIZ(4) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,C(5)*z(index{3},1)-C(6)*z(index{3},3),SimCol)
    hold on
    plot(t,C(5)*X(1,index{1})-C(6)*X(3,index{1}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{fi} (mV)','fontsize',label_fontsize)
%     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(5)*X(1,index{1})-C(6)*X(3,index{1})); minc(2) = min(C(5)*z(index{3},1)-C(6)*z(index{3},3));
    maxc(1) = max(C(5)*X(1,index{1})-C(6)*X(3,index{1})); maxc(2) = max(C(5)*z(index{3},1)-C(6)*z(index{3},3));
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end

if (Image_handling_inputs(2,4) ==1)
    fig_name = 'Neural Mass State4 Input (V_{fi}) Zoomed In';
    EEG_Figure;
    NMSIZ(4) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(5)*z(index{4},1)-C(6)*z(index{4},3),SimCol)
    hold on
    plot(tz,C(5)*X(1,index{2})-C(6)*X(3,index{2}),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{fi} (mV)','fontsize',label_fontsize)
%     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(5)*X(1,index{2})-C(6)*X(3,index{2})); minc(2) = min(C(5)*z(iindex{4},1)-C(6)*z(index{4},3));
    maxc(1) = max(C(5)*X(1,index{2})-C(6)*X(3,index{2})); maxc(2) = max(C(5)*z(index{4},1)-C(6)*z(index{4},3));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
end


%%

% Plot all aggregate membrane potentials on a single plot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~

if (Image_handling_multi(1,1) ==1) % Plot all model states
    RowP = Ds/2; % Set number of rows for multi plot
    ColP =2; % Set number of columns for multi plot
    fig_name = 'Neural Mass States';
    EEG_Figure_Multi;
    namesS = {'V_{po} (mV)','V_{eo} (mV)','V_{sio} (mV)','V_{fio} (mV)' 'Z_{po} (mV)','Z_{eo} (mV)','Z_{sio} (mV)','Z_{fio} (mV)'};
        NMM(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k = 1:Ds
        subplot(RowP,ColP,k),plot(t,z(index{3},k),SimCol);
        hold on
        plot(t,X(k,index{1}),EstCol)
        hold on
        if (plot_uncertainty ==1)
               erfn = X(k,index{1})-squeeze(sqrt(Pxx(k,k,index{1})*Error_multiplier))';
                    erfp = X(k,index{1})+squeeze(sqrt(Pxx(k,k,index{1})*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =X(k,index{1});
            erfp = erfn;
            end
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(namesS(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        minc(1) = min(erfn(maxlimit)); minc(2) = min(z(index{3},k));
        maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(index{3},k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
            m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
end

if (Image_handling_multi(2,1) ==1) % Plot all model states
    RowP = Ds/2; % Set number of rows for multi plot
    ColP =2; % Set number of columns for multi plot
    fig_name = 'Neural Mass States Zoomed In';
    EEG_Figure_Multi;
    namesS = {'V_{po} (mV)','V_{eo} (mV)','V_{sio} (mV)','V_{fio} (mV)' 'Z_{po} (mV)','Z_{eo} (mV)','Z_{sio} (mV)','Z_{fio} (mV)'};
        NMM(1) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k = 1:Ds
        subplot(RowP,ColP,k),plot(tz,z(index{4},k),SimCol);
        hold on
        plot(tz,X(k,index{2}),EstCol)
        hold on
        if (plot_uncertainty ==1)
               erfn = X(k,index{2})-squeeze(sqrt(Pxx(k,k,index{2})*Error_multiplier))';
                    erfp = X(k,index{2})+squeeze(sqrt(Pxx(k,k,index{2})*Error_multiplier))';
                plot(tz,erfn,ErrCol);
                hold on
                plot(tz,erfp,ErrCol);
            else
            erfn =X(k,index{2});
            erfp = erfn;
            end
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(namesS(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        minc(1) = min(erfn); minc(2) = min(z(index{3},k));
        maxc(1) = max(erfp); maxc(2) = max(z(index{3},k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
            m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
end          

if (Image_handling_multi(1,2) ==1) % Plot all state inputs
    % Plot all aggregate membrane potentials on a single plot
    RowP = 2;
    ColP = 2;
    namesS = {'V_{p} (mV)','V_{e} (mV)','V_{si} (mV)','V_{fi} (mV)'};
    StateIn = [Y(index{1}) C(1)*z(index{3},1) C(3)*z(index{3},1) C(5)*z(index{3},1)-C(6)*z(index{3},3)];
    StateInE = [ExpY(index{1}) C(1)*X(1,index{1}) C(3)*X(1,index{1}) C(5)*X(1,index{1})-C(6)*X(3,index{1})];
    fig_name = 'Neural Mass State Inputs';
    EEG_Figure_Multi;
    NMM(2) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:length(StateIn)
        subplot(RowP,ColP,k),plot(t,StateIn(k),SimCol);
        hold on
        plot(t,StateInE(k),EstCol);
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(namesS(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
        minc(1) = min(StateInE(k)); minc(2) = min(StateIn(k));
        maxc(1) = max(StateInE(k)); maxc(2) = max(StateIn(k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
            m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
end

if (Image_handling_multi(2,2) ==1) % Plot all state inputs
    % Plot all aggregate membrane potentials on a single plot
    RowP = 2;
    ColP = 2;
    namesS = {'V_{p} (mV)','V_{e} (mV)','V_{si} (mV)','V_{fi} (mV)'};
    StateIn = [Y(index{2}) C(1)*z(index{4},1) C(3)*z(index{4},1) C(5)*z(index{4},1)-C(6)*z(index{4},3)];
    StateInE = [ExpY(index{2}) C(1)*X(1,index{2}) C(3)*X(1,index{2}) C(5)*X(1,index{2})-C(6)*X(3,index{2})];
    fig_name = 'Neural Mass State Inputs Zoomed In';
    EEG_Figure_Multi;
    NMMZ(2) =figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:length(StateIn)
        subplot(RowP,ColP,k),plot(t,StateIn(k),SimCol);
        hold on
        plot(t,StateInE(k),EstCol);
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(namesS(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        set(m,'fontsize',legend_fontsize);
        minc(1) = min(StateInE(k)); minc(2) = min(StateIn(k));
        maxc(1) = max(StateInE(k)); maxc(2) = max(StateIn(k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
         m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
end

%%

if (Image_handling_multi(1,3) ==1) % Plot model parameters estimated
    if Dp >0
        RowP =1;
        if Dp>2
            RowP =2;
        end
        if Dp==1
            ColP =1;
        else ColP=2;
        end
        names = {'A (mV)','B (mV)','G (mV)'};
        fig_name = 'Neural Mass Parameters';
        EEG_Figure_Multi;
        NMM(3) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        
        legLocM = [0.3 0.45 0.5 1];
        
        for k =1:Dp
            
            subplot(RowP,ColP,k),plot(tz,MVI(index{3},k),SimCol);
            hold on
            plot(tz,X(Ds+Dk+k,index{1}),EstCol)
            hold on

            set(gca,'fontsize',tick_fontsize)
            box off          
            ylabel(names(k),'fontsize',label_fontsize)
            minc(1) = min(erfn(maxlimit)); minc(2) = min(MVI(index{3},k));
            maxc(1) = max(erfp(maxlimit)); maxc(2) = max(MVI(index{3},k));
            axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        end
    end
    m=legend('Sim.','Est.','Location',legLocM,'Orientation',legOri);
    legend(m,'boxoff');
    set(m,'fontsize',legend_fontsize);
    xlabel('Time (s)','fontsize',label_fontsize);
    
end

if (Image_handling_multi(2,3) ==1) % Plot model parameters estimated
    if Dp >0
        RowP =1;
        if Dp>2
            RowP =2;
        end
        if Dp==1
            ColP =1;
        else ColP=2;
        end
        names = {'A (mV)','B (mV)','G (mV)'};
        fig_name = 'Neural Mass Parameters Zoomed In';
        EEG_Figure_Multi;
        NMMZ(3) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        
        legLocM = [0.3 0.45 0.5 1];
        
        for k =1:Dp
            
            subplot(RowP,ColP,k),plot(tz,MVI(index{4},k),SimCol);
            hold on
            plot(tz,X(Ds+Dk+k,index{2}),EstCol)
            hold on
            if (plot_uncertainty ==1)
               erfn = X(Ds+Dk+k,index{2})-squeeze(sqrt(Pxx(Ds+Dk+k,Ds+Dk+k,index{2})*Error_multiplier))';
                erfp = X(Ds+Dk+k,index{2})+squeeze(sqrt(Pxx(Ds+Dk+k,Ds+Dk+k,index{2})*Error_multiplier))';
                plot(tz,erfn,ErrCol);
                hold on
                plot(tz,erfp,ErrCol);
            else
            erfn =X(Ds+Dk+k,index{2});
            erfp = erfn;
            end
            set(gca,'fontsize',tick_fontsize)
            box off          
            ylabel(names(k),'fontsize',label_fontsize)
            minc(1) = min(erfn); minc(2) = min(MVI(index{4},k));
            maxc(1) = max(erfp); maxc(2) = max(MVI(index{4},k));
            axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        end
    end
    m=legend('Actual','Estimated','Location',legLocM,'Orientation',legOri);
    legend(m,'boxoff');
    set(m,'fontsize',legend_fontsize);
    xlabel('Time (s)','fontsize',label_fontsize);
    
end

if (Image_handling_multi(1,4) ==1) % Plot model parameters estimated
    if (Dp+Dk >0)
        RowP =1;
        if (Dp+Dk>2)
            RowP =2;
        end
        if (Dp+Dk==1)
            ColP =1;
        else ColP=2;
        end
        Parameters = {MVI(index{3},1) MVI(index{3},2) MVI(index{3},3) meanf*ones(length(t),1)};
        ParametersE = {X(Ds+Dk+1,index{1}) X(Ds+Dk+2,index{1}) X(Ds+Dk+3,index{1}) X(Ds+1,index{1})};
        CoV = {Pxx(Ds+Dk+1,Ds+Dk+1,index{1}) Pxx(Ds+Dk+2,Ds+Dk+2,index{1}) Pxx(Ds+Dk+3,Ds+Dk+3,index{1}) Pxx(Ds+1,Ds+1,index{1})};
        names = {'A (mV)','B (mV)','G (mV)' 'Input Mean (Hz)'};
        fig_name = 'Neural Mass Parameters and Input Zoomed In';
        EEG_Figure_Multi;
        NMM(4) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        
        legLocM = [0.3 0.45 0.5 1];
        
        for k =1:(Dp+Dk)
            
            subplot(RowP,ColP,k),plot(t,Parameters{k},SimCol);
            hold on
            plot(t,ParametersE{k},EstCol)
            hold on
            if (plot_uncertainty ==1)
               erfn = ParametersE{k}-squeeze(sqrt(CoV{k}*Error_multiplier))';
                erfp = ParametersE{k}+squeeze(sqrt(CoV{k}*Error_multiplier))';
                plot(t,erfn,ErrCol);
                hold on
                plot(t,erfp,ErrCol);
            else
            erfn =ParametersE{k};
            erfp = erfn;
            end
            set(gca,'fontsize',tick_fontsize)
            box off          
            ylabel(names(k),'fontsize',label_fontsize)
            minc(1) = min(erfn(maxlimit)); minc(2) = min(Parameters{k});
            maxc(1) = max(erfp(maxlimit)); maxc(2) = max(Parameters{k});
            axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        end
    end
    m=legend('Actual','Estimated','Location',legLocM,'Orientation',legOri);
    legend(m,'boxoff');
    set(m,'fontsize',legend_fontsize);
    xlabel('Time (s)','fontsize',label_fontsize);
    
end

if (Image_handling_multi(2,4) ==1) % Plot model parameters estimated
    if (Dp+Dk >0)
        RowP =1;
        if (Dp+Dk>2)
            RowP =2;
        end
        if (Dp+Dk==1)
            ColP =1;
        else ColP=2;
        end
        Parameters = {MVI(index{4},1) MVI(index{4},2) MVI(index{4},3) meanf*ones(length(t),1)};
        ParametersE = {X(Ds+Dk+1,index{2}) X(Ds+Dk+2,index{2}) X(Ds+Dk+3,index{2}) X(Ds+1,index{2})};
        CoV = {Pxx(Ds+Dk+1,Ds+Dk+1,index{2}) Pxx(Ds+Dk+2,Ds+Dk+2,index{2}) Pxx(Ds+Dk+3,Ds+Dk+3,index{2}) Pxx(Ds+1,Ds+1,index{2})};
        names = {'A (mV)','B (mV)','G (mV)' 'Input Mean (Hz)'};
        fig_name = 'Neural Mass Parameters and Input Zoomed In';
        EEG_Figure_Multi;
        NMMZ(4) =figure('name',fig_name,...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
       
        
        for k =1:(Dp+Dk)
            
            subplot(RowP,ColP,k),plot(tz,Parameters{k},SimCol);
            hold on
            plot(tz,ParametersE{k},EstCol)
            hold on
            if (plot_uncertainty ==1)
               erfn = ParametersE{k}-squeeze(sqrt(CoV{k}*Error_multiplier))';
                erfp = ParametersE{k}+squeeze(sqrt(CoV{k}*Error_multiplier))';
                plot(tz,erfn,ErrCol);
                hold on
                plot(tz,erfp,ErrCol);
            else
            erfn =ParametersE{k};
            erfp = erfn;
            end
            set(gca,'fontsize',tick_fontsize)
            box off          
            ylabel(names(k),'fontsize',label_fontsize)
            minc(1) = min(erfn); minc(2) = min(Parameters{k});
            maxc(1) = max(erfp); maxc(2) = max(Parameters{k});
            axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        end
    end
    m=legend('Actual','Estimated','Location',legLocM,'Orientation',legOri);
    legend(m,'boxoff');
    set(m,'fontsize',legend_fontsize);
    xlabel('Time (s)','fontsize',label_fontsize);
    
end


%%

if (Image_handling_firing_rates(1) ==1)
    % Plot of state 1
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RowP =3;
    fig_name = 'Neural Mass Pyramidal Neuron Input, Output and Firing Rate';
    EEG_Figure_Multi;
    MassP = {Y(index{1}); Sigmoid(Y(index{1})); z(index{3},1)};
    MassPE = {ExpY(index{1}); Sigmoid(ExpY(index{1})); X(1,index{1})};
    ylab = {'Pyramidal Input (mV)' 'Pyramidal Firing Rate (Hz)' 'Pyramidal Output (mV)'};
    NMFR(1) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:3
        subplot(RowP,1,k),plot(t,MassP{k},SimCol);
        hold on
        plot(t,MassPE{k},EstCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    ylabel(ylab(k),'fontsize',label_fontsize)
        minc(1) = min(MassPE{k}); minc(2) = min(MassP{k});
    maxc(1) = max(MassPE{k}); maxc(2) = max(MassP{k});
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    k=legend('Sim.','Est.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

if (Image_handling_firing_rates(2) ==1)
    
    % Plot of state 2
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     RowP =3;
    fig_name = 'Neural Mass Excitatory Neuron Input, Output and Firing Rate';
    EEG_Figure_Multi;
    MassP = {C(1)*z(index{3},1); Sigmoid(C(1)*z(index{3},1)); z(index{3},2)};
    MassPE = {C(1)*X(1,index{3}); Sigmoid(C(1)*X(1,index{3})); X(2,index{3})};
    ylab = {'Excitatory Input (mV)' 'Excitatory Firing Rate (Hz)' 'Excitatory Output (mV)'};
    NMFR(2) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:3
        subplot(RowP,1,k),plot(t,MassP{k},SimCol);
        hold on
        plot(t,MassPE{k},EstCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    ylabel(ylab(k),'fontsize',label_fontsize)
        minc(1) = min(MassPE{k}); minc(2) = min(MassP{k});
    maxc(1) = max(MassPE{k}); maxc(2) = max(MassP{k});
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    k=legend('Sim.','Est.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

if (Image_handling_firing_rates(3) ==1)
    
    % Plot of state 3
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     RowP =3;
    fig_name = 'Neural Mass Excitatory Neuron Input, Output and Firing Rate';
    EEG_Figure_Multi;
    MassP = {C(3)*z(index{3},1); Sigmoid(C(3)*z(index{3},1)); z(index{3},3)};
    MassPE = {C(3)*X(1,index{3}); Sigmoid(C(3)*X(1,index{3})); X(3,index{3})};
    ylab = {'Slow Inh. Input (mV)' 'Slow Inh. Firing Rate (Hz)' 'Slow Inh. Output (mV)'};
    NMFR(3) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:3
        subplot(RowP,1,k),plot(t,MassP{k},SimCol);
        hold on
        plot(t,MassPE{k},EstCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    ylabel(ylab(k),'fontsize',label_fontsize)
        minc(1) = min(MassPE{k}); minc(2) = min(MassP{k});
    maxc(1) = max(MassPE{k}); maxc(2) = max(MassP{k});
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    k=legend('Sim.','Est.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end


if (Image_handling_firing_rates(4) ==1)
    
    % Plot of state 4
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     RowP =3;
    fig_name = 'Neural Mass Fast Inh. Neuron Input, Output and Firing Rate';
    EEG_Figure_Multi;
    MassP = {C(5)*z(index{3},1)-C(6)*z(index{3},3); Sigmoid(C(5)*z(index{3},1)-C(6)*z(index{3},3)); z(index{3},4)};
    MassPE = {C(5)*X(1,index{3})-C(6)*X(3,index{3}); Sigmoid(C(5)*X(1,index{3})-C(6)*X(3,index{3})); X(4,index{3})};
    ylab = {'Fast Inh. Input (mV)' 'Fast Inh. Firing Rate (Hz)' 'Fast Inh. Output (mV)'};
    NMFR(4) = figure('name',fig_name,...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    for k =1:3
        subplot(RowP,1,k),plot(t,MassP{k},SimCol);
        hold on
        plot(t,MassPE{k},EstCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    ylabel(ylab(k),'fontsize',label_fontsize)
        minc(1) = min(MassPE{k}); minc(2) = min(MassPE{k});
    maxc(1) = max(MassPE{k}); maxc(2) = max(MassP{k});
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    k=legend('Sim.','Est.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    % Print image with resolution 600 to pdf test.
end

