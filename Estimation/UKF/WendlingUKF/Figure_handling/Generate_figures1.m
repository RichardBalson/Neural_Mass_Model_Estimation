% script created by Richard Balson 09/01/2013

% description
% ~~~~~~~~~~~
% this script generates figures for UKF estimation results

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

NMO = figure('name','Neural Mass Output',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,Y,'k')
hold on
plot(t,ExpY,'b')
hold on
plot(t,check(1:limit),'g');
set(gca,'fontsize',tick_fontsize)
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Amplitude (mV)','fontsize',label_fontsize)
% title('Pyramidal Population Input','fontsize', label_fontsize)
k = legend('Noisy Obs.','Estimated Obs.','Obs.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
minc(1) = min(Y); minc(2) = min(ExpY);
maxc(1) = max(Y); maxc(2) = max(ExpY);
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
box off


if zoom>0
    
    NMOZ = figure('name','Neural Mass Output Zoomed in',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,Y(initialz:endz),'k')
    hold on
    plot(tz,ExpY(initialz:endz),'b')
    hold on
    plot(tz,check(initialz:endz),'g');
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Pyramidal Population Input','fontsize', label_fontsize)
    k=legend('Noisy Obs.','Est. Obs.','Obs.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(Y(initialz:endz)); minc(2) = min(ExpY(initialz:endz));
    maxc(1) = max(Y(initialz:endz)); maxc(2) = max(ExpY(initialz:endz));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    % Print image with resolution 600 to pdf test.
    
end


% Plot of state 1
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS1 = figure('name','Neural Mass State 1',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,1),'k')
hold on
plot(t,X(1,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(1,k)-sqrt(Pxx(1,1,k)/variance_adjustment);
    erfp(k) = X(1,k)+sqrt(Pxx(1,1,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Amplitude (mV)','fontsize',label_fontsize)
% title('Pyramidal Population Output','fontsize', label_fontsize)
k=legend('Sim. Vp','Est. Vp','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,1));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,1));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
set(k,'fontsize',legend_fontsize);

if zoom>0
    
    NMS1Z =figure('name','Neural Mass State 1 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,1),'k')
    hold on
    plot(tz,X(1,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Pyramidal Population Output','fontsize', label_fontsize)
    k= legend('Sim. Vp','Est. Vp','Location',legLoc);
    legend(k,'boxoff');
    minc(1) = min(X(1,initialz:endz)); minc(2) = min(z(initialz:endz,1));
    maxc(1) = max(X(1,initialz:endz)); maxc(2) = max(z(initialz:endz,1));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);
    
end

% Plot of state 2
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS2 =figure('name','Neural Mass State 2',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,2),'k')
hold on
plot(t,X(2,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(2,k)-sqrt(Pxx(2,2,k)/variance_adjustment);
    erfp(k) = X(2,k)+sqrt(Pxx(2,2,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Amplitude (mV)','fontsize',label_fontsize)
% title('Excitatory Populations Output','fontsize', label_fontsize)
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,2));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,2));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
k=legend('Sim. Ve','Est. Ve','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);

if zoom>0
    
    NMS2Z= figure('name','Neural Mass State 2 Zoomed in',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,2),'k')
    hold on
    plot(tz,X(2,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(X(2,initialz:endz)); minc(2) = min(z(initialz:endz,2));
    maxc(1) = max(X(2,initialz:endz)); maxc(2) = max(z(initialz:endz,2));
    k=legend('Sim. Ve','Est. Ve','Location',legLoc);
    legend(k,'boxoff');
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);

end

% Plot of state 3
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS3 = figure('name','Neural Mass State 3',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,3),'k')
hold on
plot(t,X(3,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(3,k)-sqrt(Pxx(3,3,k)/variance_adjustment);
    erfp(k) = X(3,k)+sqrt(Pxx(3,3,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Amplitude (mV)','fontsize',label_fontsize)
% title('Slow Inhibitory Population Output','fontsize', label_fontsize)
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,3));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,3));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
k=legend('Sim. Vsi','Est. Vsi','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
% Print image with resolution 600 to pdf test.
set(k,'fontsize',legend_fontsize);

if zoom>0
    
    NMS3Z = figure('name','Neural Mass State 3 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,3),'k')
    hold on
    plot(tz,X(3,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(X(3,initialz:endz)); minc(2) = min(z(initialz:endz,3));
    maxc(1) = max(X(3,initialz:endz)); maxc(2) = max(z(initialz:endz,3));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Vsi','Est. Vsi','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

% Plot of state 4
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS4 = figure('name','Neural Mass State 4',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,4),'k')
hold on
plot(t,X(4,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(4,k)-sqrt(Pxx(4,4,k)/variance_adjustment);
    erfp(k) = X(4,k)+sqrt(Pxx(4,4,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Amplitude (mV)','fontsize',label_fontsize)
% title('Fast Inhibitory Population Output','fontsize', label_fontsize)
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,4));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,4));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
k=legend('Sim. Vfi','Est. Vfi','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
% Print image with resolution 600 to pdf test.

if zoom>0
    
    NMS4Z = figure('name','Neural Mass State 4 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,4),'k')
    hold on
    plot(tz,X(4,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Amplitude (mV)','fontsize',label_fontsize)
    %     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(X(4,initialz:endz)); minc(2) = min(z(initialz:endz,4));
    maxc(1) = max(X(4,initialz:endz)); maxc(2) = max(z(initialz:endz,4));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Vfi','Est. Vfi','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

% Plot of state 5
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS5 = figure('name','Neural Mass State 5',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,5),'k')
hold on
plot(t,X(5,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(5,k)-sqrt(Pxx(5,5,k)/variance_adjustment);
    erfp(k) = X(5,k)+sqrt(Pxx(5,5,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
% title('Rate of Change of Vp','fontsize', label_fontsize)% Pyramidal cells
% rate of change
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,5));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,5));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
k=legend('Sim. Zp','Est. Zp','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
% Print image with resolution 600 to pdf test.

if zoom>0
    
    NMS5Z = figure('name','Neural Mass State 5 Zoomied In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,5),'k')
    hold on
    plot(tz,X(5,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vp','fontsize', label_fontsize)
    minc(1) = min(X(5,initialz:endz)); minc(2) = min(z(initialz:endz,5));
    maxc(1) = max(X(5,initialz:endz)); maxc(2) = max(z(initialz:endz,5));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Zp','Est. Zp','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
end

% Plot of state 6
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NMS6 = figure('name','Neural Mass State 6',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,6),'k')
hold on
plot(t,X(6,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(6,k)-sqrt(Pxx(6,6,k)/variance_adjustment);
    erfp(k) = X(6,k)+sqrt(Pxx(6,6,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
% title('Rate of Change of Ve','fontsize', label_fontsize)
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,6));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,6));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
k=legend('Sim. Ze','Est. Ze','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
% Print image with resolution 600 to pdf test.

if zoom>0
    
    NMS6Z = figure('name','Neural Mass State 6 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,6),'k')
    hold on
    plot(tz,X(6,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Ve','fontsize', label_fontsize)
    minc(1) = min(X(6,initialz:endz)); minc(2) = min(z(initialz:endz,6));
    maxc(1) = max(X(6,initialz:endz)); maxc(2) = max(z(initialz:endz,6));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    k=legend('Sim. Ze','Est. Ze','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
end

% Plot of state 7
% ~~~~~~~~~~~~~~~~

NMS7 = figure('name','Neural Mass State 7',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,7),'k')
hold on
plot(t,X(7,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(7,k)-sqrt(Pxx(7,7,k)/variance_adjustment);
    erfp(k) = X(7,k)+sqrt(Pxx(7,7,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
% title('Rate of Change of Vsi','fontsize', label_fontsize)
k=legend('Sim. Zsi','Est. Zsi','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,7));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,7));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);

if zoom>0
    
    NMS7Z =figure('name','Neural Mass State 7 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,7),'k')
    hold on
    plot(tz,X(7,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vsi','fontsize', label_fontsize)
    k=legend('Sim. Zsi','Est. Zsi','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(X(7,initialz:endz)); minc(2) = min(z(initialz:endz,7));
    maxc(1) = max(X(7,initialz:endz)); maxc(2) = max(z(initialz:endz,7));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    
end

% Plot of state 8
% ~~~~~~~~~~~~~~~~

NMS8 = figure('name','Neural Mass State 8',...
    'units','centimeters',...
    'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
    'papersize',[fig_width fig_height],...
    'filename',fig_dirandname,...
    'PaperPositionMode','auto');
plot(t,z(1:limit,8),'k')
hold on
plot(t,X(8,1:length(check)),'b')
hold on
for k = 1:length(check)
    erfn(k) = X(8,k)-sqrt(Pxx(8,8,k)/variance_adjustment);
    erfp(k) = X(8,k)+sqrt(Pxx(8,8,k)/variance_adjustment);
end
plot(t,erfn,'r-');
hold on
plot(t,erfp,'r-');
set(gca,'fontsize',tick_fontsize)
box off
xlabel('Time (s)','fontsize',label_fontsize)
ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
% title('Rate of Change of Vfi','fontsize', label_fontsize)
k=legend('Sim. Zfi','Est. Zfi','Std. Dev.','Location',legLoc);
legend(k,'boxoff');
set(k,'fontsize',legend_fontsize);
minc(1) = min(erfn(maxlimit)); minc(2) = min(z(:,8));
maxc(1) = max(erfp(maxlimit)); maxc(2) = max(z(:,8));
axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);

if zoom>0
    
    NMS8Z =figure('name','Neural Mass State 8 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,z(initialz:endz,8),'k')
    hold on
    plot(tz,X(8,initialz:endz),'b')
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Rate of Change (mV/s)','fontsize',label_fontsize)
    %     title('Rate of Change of Vfi','fontsize', label_fontsize)
    k=legend('Sim. Zfi','Est. Zfi','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    minc(1) = min(X(8,initialz:endz)); minc(2) = min(z(initialz:endz,8));
    maxc(1) = max(X(8,initialz:endz)); maxc(2) = max(z(initialz:endz,8));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    
end

% Plot all aggregate membrane potentials on a single plot
    multiplier = Ds/4;
    namesS = {'Vp (mV)','Ve (mV)','Vsi (mV)','Vfi (mV)'};
            NMS =figure('name','Neural Mass All Estimated States',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos multiplier*fig_width multiplier*fig_height],...
            'papersize',[multiplier*fig_width multiplier*fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
    for k =1:Ds/2    
        subplot(multiplier,multiplier,k),plot(t,z(1:limit,k),'k');
        hold on
        plot(t,X(k,1:length(check)),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(namesS(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
        minc(1) = min(X(k,1:length(check))); minc(2) = min(z(1:limit,k));
        maxc(1) = max(X(k,1:length(check))); maxc(2) = max(z(1:limit,k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end

% Plot input parameter
% ~~~~~~~~~~~~~~~~~~~~

if Dk ==1
    NMI = figure('name','Estimation of Input to Model',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,X(Ds+1,1:length(check)),'b')
    hold on
    plot(t,normalised_gaussian_input(1:length(check)),'k');
    hold on
    for k = 1:length(check)
        erfn(k) = X(Ds+1,k)-sqrt(Pxx(Ds+1,Ds+1,k)/variance_adjustment);
        erfp(k) = X(Ds+1,k)+sqrt(Pxx(Ds+1,Ds+1,k)/variance_adjustment);
    end
    plot(t,erfn,'r-');
    hold on
    plot(t,erfp,'r-');
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Firing Rate (Hz)','fontsize',label_fontsize)
    minc(1) = min(erfn); minc(2) = min(normalised_gaussian_input);
    maxc(1) = max(erfp); maxc(2) = max(normalised_gaussian_input);
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    %     title('Model Input','fontsize', label_fontsize)
    k=legend('Sim. Input','Est. Input','Std. Dev.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
    if zoom>0
        
        NMIZ =figure('name','Neural Mass Input Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,normalised_gaussian_input(initialz:endz),'k')
        hold on
        plot(tz,X(Ds+1,initialz:endz),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('Firing rate (Hz)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Sim. Input','Est. Input','Location',legLoc);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+1,initialz:endz)); minc(2) = min(normalised_gaussian_input(initialz:endz));
        maxc(1) = max(X(Ds+1,initialz:endz)); maxc(2) = max(normalised_gaussian_input(initialz:endz));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        
    end
    
end

% Determine whether to plot parameter estimates
% ~~~~~~~~~~~~~~~~~~~~~

if Dp >0
    NMPE = figure('name','Estimation of Excitability',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(t,MVI(1:length(check),1),'k')
    hold on
    plot(t,X(Ds+Dk+1,1:length(check)),'b')
    hold on
    for k = 1:length(check)
        erfn(k) = X(Ds+Dk+1,k)-sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,k)/variance_adjustment);
        erfp(k) = X(Ds+Dk+1,k)+sqrt(Pxx(Ds+Dk+1,Ds+Dk+1,k)/variance_adjustment);
    end
    plot(t,erfn,'r-');
    hold on
    plot(t,erfp,'r-');
    minc(1) = min(erfn); minc(2) = min(MVI(:,1));
    maxc(1) = max(erfp); maxc(2) = max(MVI(:,1));
    axis([0 max(t) min(minc) max(maxc)]);
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('A (mV)','fontsize',label_fontsize)
    %     title('Estimated Excitability','fontsize', label_fontsize)
    k= legend('Sim.','Est.','Std. Dev.','Location',legLoc);
    legend(k,'boxoff');
    set(k,'fontsize',legend_fontsize);
    
        if zoom>0
        
        NMPEZ =figure('name','Neural Mass Excitatory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialz:endz,1),'k')
        hold on
        plot(tz,X(Ds+Dk+1,initialz:endz),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('A (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Sim.','Est.','Location',legLoc);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+1,initialz:endz)); minc(2) = min(MVI(initialz:endz,1));
        maxc(1) = max(X(Ds+Dk+1,initialz:endz)); maxc(2) = max(MVI(initialz:endz,1));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        
    end
    
    
    if Dp > 1
        NMPI = figure('name','Estimation of Slow Inhibition',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(t,MVI(1:length(check),2),'k')
        hold on
        plot(t,X(Ds+Dk+2,1:length(check)),'b')
        hold on
        for k = 1:length(check)
            erfn(k) = X(Ds+Dk+2,k)-sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,k)/variance_adjustment);
            erfp(k) = X(Ds+Dk+2,k)+sqrt(Pxx(Ds+Dk+2,Ds+Dk+2,k)/variance_adjustment);
        end
        plot(t,erfn,'r-');
        hold on
        plot(t,erfp,'r-');
        minc(1) = min(erfn); minc(2) = min(MVI(:,2));
        maxc(1) = max(erfp); maxc(2) = max(MVI(:,2));
        axis([0 max(t) min(minc) max(maxc)]);
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('B (mV)','fontsize',label_fontsize)
        %         title('Estimated Slow Inhibition','fontsize', label_fontsize)
        k=legend('Sim.','Est.','Std. Dev.','Location',legLoc);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        
                if zoom>0
        
        NMPIZ =figure('name','Neural Mass Slow Inhibitory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialz:endz,2),'k')
        hold on
        plot(tz,X(Ds+Dk+2,initialz:endz),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('B (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Sim.','Est.','Location',legLoc);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+2,initialz:endz)); minc(2) = min(MVI(initialz:endz,2));
        maxc(1) = max(X(Ds+Dk+2,initialz:endz)); maxc(2) = max(MVI(initialz:endz,2));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
        
    end
        
        if Dp ==3
            NMPFI = figure('name','Estimation of Fast Inhibition',...
                'units','centimeters',...
                'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
                'papersize',[fig_width fig_height],...
                'filename',fig_dirandname,...
                'PaperPositionMode','auto');
            plot(t,MVI(1:length(check),3),'k')
            hold on
            plot(t,X(Ds+Dk+3,1:length(check)),'b')
            hold on
            for k = 1:length(check)
                erfn(k) = X(Ds+Dk+3,k)-sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,k)/variance_adjustment);
                erfp(k) = X(Ds+Dk+3,k)+sqrt(Pxx(Ds+Dk+3,Ds+Dk+3,k)/variance_adjustment);
            end
            plot(t,erfn,'r-');
            hold on
            plot(t,erfp,'r-');
            minc(1) = min(erfn); minc(2) = min(MVI(:,3));
            maxc(1) = max(erfp); maxc(2) = max(MVI(:,3));
            axis([0 max(t) min(minc) max(maxc)]);
            set(gca,'fontsize',tick_fontsize)
            box off
            xlabel('Time (s)','fontsize',label_fontsize)
            ylabel('G (mV)','fontsize',label_fontsize)
            %             title('Estimated Fast Inhibition','fontsize', label_fontsize)
            k=legend('Sim.','Est.','Std. Dev.','Location',legLoc);
            legend(k,'boxoff');
            set(k,'fontsize',legend_fontsize);
            
         if zoom>0   
         NMPFIZ =figure('name','Neural Mass Fast Inhibitory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialz:endz,3),'k')
        hold on
        plot(tz,X(Ds+Dk+3,initialz:endz),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('G (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Sim.','Est.','Location',legLoc);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+3,initialz:endz)); minc(2) = min(MVI(initialz:endz,3));
        maxc(1) = max(X(Ds+Dk+3,initialz:endz)); maxc(2) = max(MVI(initialz:endz,3));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
         end
        end
    end
end

if Dp >1
    rowP =1;
        if Dp>2
            rowP =2;
        end
        if Dp==1
            colP =1;
        else colP=2;
        end
    names = {'A (mV)','B (mV)','G (mV)'};
            NMP =figure('name','Neural Mass All  Estimated Parameters',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos colP*fig_width rowP*fig_height],...
            'papersize',[colP*fig_width rowP*fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        
    for k =1:Dp  

        subplot(rowP,colP,k),plot(tz,MVI(initialz:endz,k),'k');
        hold on
        plot(tz,X(Ds+Dk+k,initialz:endz),'b')
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel(names(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        m=legend('Sim.','Est.','Location',legLoc);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+k,initialz:endz)); minc(2) = min(MVI(initialz:endz,k));
        maxc(1) = max(X(Ds+Dk+k,initialz:endz)); maxc(2) = max(MVI(initialz:endz,k));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
end

    
    
