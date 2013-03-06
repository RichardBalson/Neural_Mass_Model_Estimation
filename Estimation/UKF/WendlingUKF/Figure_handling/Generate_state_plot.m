% script created by Richard Balson 14/01/2013

% description
% ~~~~~~~~~~~
% Generate plots of all states that are directly related to an aggregate membrane
% potential

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~


% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~
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
        m=legend('Simulated','Estimated','Location','Best');
        set(m,'fontsize',legend_fontsize);
        minc(1) = min(X(k,1:length(check))); minc(2) = min(z(1:limit,k));
        maxc(1) = max(X(k,1:length(check))); maxc(2) = max(z(1:limit,k));
        axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    
    saveas(NMS,'123.fig','fig');


    
    
