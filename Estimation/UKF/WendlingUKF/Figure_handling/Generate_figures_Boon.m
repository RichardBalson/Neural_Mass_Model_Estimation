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

% % Plot of state 1
% % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

    
%     NMS1Z =figure('name','Neural Mass State 1 Zoomed In',...
%         'units','centimeters',...
%         'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%         'papersize',[fig_width fig_height],...
%         'filename',fig_dirandname,...
%         'PaperPositionMode','auto');
%     plot(tz,z(initialRz:endRz,1),SimCol)
%     hold on
%     plot(tz,X(1,initialz:endz),EstCol)
%     set(gca,'fontsize',tick_fontsize)
%     box off
% %     xlabel('Time (s)','fontsize',label_fontsize)
%     ylabel('V_{p} (mV)','fontsize',label_fontsize)
%     %     title('Pyramidal Population Output','fontsize', label_fontsize)
%     k= legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
%     legend(k,'boxoff');
%     minc(1) = min(X(1,initialz:endz)); minc(2) = min(z(initialRz:endRz,1));
%     maxc(1) = max(X(1,initialz:endz)); maxc(2) = max(z(initialRz:endRz,1));
%     axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
%     set(k,'fontsize',legend_fontsize);
    
        NMS1Z =figure('name','Neural Mass State 1 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height+1],...
        'papersize',[fig_width fig_height+1],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,Y(initialz:endz),SimCol)
    hold on
    plot(tz,ExpY(initialz:endz),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
%     xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{p} (mV)','fontsize',label_fontsize)
    %     title('Pyramidal Population Output','fontsize', label_fontsize)
    k= legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
    legend(k,'boxoff');
    minc(1) = min(ExpY(initialz:endz)); minc(2) = min(Y(initialRz:endRz));
    maxc(1) = max(ExpY(initialz:endz)); maxc(2) = max(Y(initialRz:endRz));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    set(k,'fontsize',legend_fontsize);

    
%     NMS2Z= figure('name','Neural Mass State 2 Zoomed in',...
%         'units','centimeters',...
%         'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%         'papersize',[fig_width fig_height],...
%         'filename',fig_dirandname,...
%         'PaperPositionMode','auto');
%     plot(tz,z(initialRz:endRz,2),SimCol)
%     hold on
%     plot(tz,X(2,initialz:endz),EstCol)
%     set(gca,'fontsize',tick_fontsize)
%     box off
% %     xlabel('Time (s)','fontsize',label_fontsize)
%     ylabel('V_{e} (mV)','fontsize',label_fontsize)
%     %     title('Excitatory Populations Output','fontsize', label_fontsize)
%     minc(1) = min(X(2,initialz:endz)); minc(2) = min(z(initialRz:endRz,2));
%     maxc(1) = max(X(2,initialz:endz)); maxc(2) = max(z(initialRz:endRz,2));
% %     k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri)
% %     ;
% %     legend(k,'boxoff');
%     axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
% %     set(k,'fontsize',legend_fontsize);

    
    NMS2Z= figure('name','Neural Mass State 2 Zoomed in',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(1)*z(initialRz:endRz,1),SimCol)
    hold on
    plot(tz,C(1)*X(1,initialz:endz),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
%     xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{e} (mV)','fontsize',label_fontsize)
    %     title('Excitatory Populations Output','fontsize', label_fontsize)
    minc(1) = min(C(1)*X(1,initialz:endz)); minc(2) = min(C(1)*z(initialRz:endRz,1));
    maxc(1) = max(C(1)*X(1,initialz:endz)); maxc(2) = max(C(1)*z(initialRz:endRz,1));
%     k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri)
%     ;
%     legend(k,'boxoff');
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
%     set(k,'fontsize',legend_fontsize);

%     
%     NMS3Z = figure('name','Neural Mass State 3 Zoomed In',...
%         'units','centimeters',...
%         'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%         'papersize',[fig_width fig_height],...
%         'filename',fig_dirandname,...
%         'PaperPositionMode','auto');
%     plot(tz,z(initialRz:endRz,3),'k')
%     hold on
%     plot(tz,X(3,initialz:endz),'r')
%     set(gca,'fontsize',tick_fontsize)
%     box off
% %     xlabel('Time (s)','fontsize',label_fontsize)
%     ylabel('V_{si} (mV)','fontsize',label_fontsize)
%     %     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
%     minc(1) = min(X(3,initialz:endz)); minc(2) = min(z(initialRz:endRz,3));
%     maxc(1) = max(X(3,initialz:endz)); maxc(2) = max(z(initialRz:endRz,3));
%     axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
% %     k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri)
%     ;
%     legend(k,'boxoff');
%     set(k,'fontsize',legend_fontsize);

    NMS3Z = figure('name','Neural Mass State 3 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(3)*z(initialRz:endRz,1),SimCol)
    hold on
    plot(tz,C(3)*X(1,initialz:endz),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
%     xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{si} (mV)','fontsize',label_fontsize)
    %     title('Slow Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(3)*X(1,initialz:endz)); minc(2) = min(C(3)*z(initialRz:endRz,1));
    maxc(1) = max(C(3)*X(1,initialz:endz)); maxc(2) = max(C(3)*z(initialRz:endRz,1));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    

%     
%     NMS4Z = figure('name','Neural Mass State 4 Zoomed In',...
%         'units','centimeters',...
%         'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%         'papersize',[fig_width fig_height],...
%         'filename',fig_dirandname,...
%         'PaperPositionMode','auto');
%     plot(tz,z(initialRz:endRz,4),SimCol)
%     hold on
%     plot(tz,X(4,initialz:endz),EstCol)
%     set(gca,'fontsize',tick_fontsize)
%     box off
%     xlabel('Time (s)','fontsize',label_fontsize)
%     ylabel('V_{fi} (mV)','fontsize',label_fontsize)
%     %     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
%     minc(1) = min(X(4,initialz:endz)); minc(2) = min(z(initialRz:endRz,4));
%     maxc(1) = max(X(4,initialz:endz)); maxc(2) = max(z(initialRz:endRz,4));
%     axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
%     k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri)
%     ;
%     legend(k,'boxoff');
%     set(k,'fontsize',legend_fontsize);

    NMS4Z = figure('name','Neural Mass State 4 Zoomed In',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    plot(tz,C(5)*z(initialRz:endRz,1)-C(6)*z(initialRz:endRz,3),SimCol)
    hold on
    plot(tz,C(5)*X(1,initialz:endz)-C(6)*X(3,initialz:endz),EstCol)
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('V_{fi} (mV)','fontsize',label_fontsize)
    %     title('Fast Inhibitory Population Output','fontsize', label_fontsize)
    minc(1) = min(C(5)*X(1,initialz:endz)-C(6)*X(3,initialz:endz)); minc(2) = min(C(5)*z(initialRz:endRz,1)-C(6)*z(initialRz:endRz,3));
    maxc(1) = max(C(5)*X(1,initialz:endz)-C(6)*X(3,initialz:endz)); maxc(2) = max(C(5)*z(initialRz:endRz,1)-C(6)*z(initialRz:endRz,3));
    axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);


%%

% Plot all aggregate membrane potentials on a single plot
    legLocM = [0.3 0.45 0.5 1];;
    multiplier = Ds/4;
    namesS = {'V_{p} (mV)','V_{e} (mV)','V_{si} (mV)','V_{fi} (mV)'};
            NMS =figure('name','Neural Mass All Estimated States',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos multiplier*fig_width multiplier*fig_height],...
            'papersize',[multiplier*fig_width multiplier*fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
    for k =1:Ds/2    
        subplot(multiplier,multiplier,k),plot(tz,z(initialRz:endRz,k),SimCol);
        hold on
        plot(tz,X(k,initialz:endz),EstCol)
        set(gca,'fontsize',tick_fontsize)
        box off

        ylabel(namesS(k),'fontsize',label_fontsize)
%             title('Rate of Change of Vfi','fontsize', label_fontsize)

        
        minc(1) = min(X(k,initialz:endz)); minc(2) = min(z(initialRz:endRz,k));
        maxc(1) = max(X(k,initialz:endz)); maxc(2) = max(z(initialRz:endRz,k));
        axis([0 max(tz) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
    xlabel('Time (s)','fontsize',label_fontsize)
    k=legend('Actual','Estimated','Location',legLocM,'Orientation',legOri);
    set(k,'fontsize',legend_fontsize);
    legend(k,'boxoff');

%       Plot of parameters


        NMPEZ =figure('name','Neural Mass Excitatory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height+1],...
            'papersize',[fig_width fig_height+1],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialRz:endRz,1),SimCol)
        hold on
        plot(tz,X(Ds+Dk+1,initialz:endz),EstCol)
        set(gca,'fontsize',tick_fontsize)
        box off
%         xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('A (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
        k=legend('Actual','Estimated','Location',legLoc,'Orientation',legOri);
        legend(k,'boxoff');
        set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+1,initialz:endz)); minc(2) = min(MVI(initialRz:endRz,1));
        maxc(1) = max(X(Ds+Dk+1,initialz:endz)); maxc(2) = max(MVI(initialRz:endRz,1));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);

%         
        NMPIZ =figure('name','Neural Mass Slow Inhibitory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialRz:endRz,2),SimCol)
        hold on
        plot(tz,X(Ds+Dk+2,initialz:endz),EstCol)
        set(gca,'fontsize',tick_fontsize)
        box off
%         xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('B (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
%         k=legend('Actual','Estimated','Location',legLoc,'Orientation',leg
%         Ori);
%         legend(k,'boxoff');
%         set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+2,initialz:endz)); minc(2) = min(MVI(initialRz:endRz,2));
        maxc(1) = max(X(Ds+Dk+2,initialz:endz)); maxc(2) = max(MVI(initialRz:endRz,2));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
  
         NMPFIZ =figure('name','Neural Mass Fast Inhibitory Gain Zoomed In',...
            'units','centimeters',...
            'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
            'papersize',[fig_width fig_height],...
            'filename',fig_dirandname,...
            'PaperPositionMode','auto');
        plot(tz,MVI(initialRz:endRz,3),SimCol)
        hold on
        plot(tz,X(Ds+Dk+3,initialz:endz),EstCol)
        set(gca,'fontsize',tick_fontsize)
        box off
        xlabel('Time (s)','fontsize',label_fontsize)
        ylabel('G (mV)','fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)
%         k=legend('Actual','Estimated','Location',legLoc,'Orientation',leg
%         Ori);
%         legend(k,'boxoff');
%         set(k,'fontsize',legend_fontsize);
        minc(1) = min(X(Ds+Dk+3,initialz:endz)); minc(2) = min(MVI(initialRz:endRz,3));
        maxc(1) = max(X(Ds+Dk+3,initialz:endz)); maxc(2) = max(MVI(initialRz:endRz,3));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
%          end
%         end
%     end
% end
% 
%%
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
        
        legLocM = [0.3 0.45 0.5 1];
        
    for k =1:Dp  

        subplot(rowP,colP,k),plot(tz,MVI(initialRz:endRz,k),SimCol);
        hold on
        plot(tz,X(Ds+Dk+k,initialz:endz),EstCol)
        set(gca,'fontsize',tick_fontsize)
        box off

        ylabel(names(k),'fontsize',label_fontsize)
        %     title('Rate of Change of Vfi','fontsize', label_fontsize)


        minc(1) = min(X(Ds+Dk+k,initialz:endz)); minc(2) = min(MVI(initialRz:endRz,k));
        maxc(1) = max(X(Ds+Dk+k,initialz:endz)); maxc(2) = max(MVI(initialRz:endRz,k));
        axis([tstart zoomend (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);
    end
end
        m=legend('Actual','Estimated','Location',legLocM,'Orientation',legOri);
        legend(m,'boxoff');
        set(m,'fontsize',legend_fontsize);
        xlabel('Time (s)','fontsize',label_fontsize);
        
        
%     NMI = figure('name','Estimation of Input to Model',...
%         'units','centimeters',...
%         'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%         'papersize',[fig_width fig_height],...
%         'filename',fig_dirandname,...
%         'PaperPositionMode','auto');
%     if Dk ==1
%     plot(t,X(Ds+1,1:length(check)),EstCol)
%     hold on
%     end
%     plot(t,normalised_gaussian_input((initialRz):(length(check)+initialRz-1)),SimCol);
%     set(gca,'fontsize',tick_fontsize)
%     box off
%     xlabel('Time (s)','fontsize',label_fontsize)
%     ylabel('Input (Hz)','fontsize',label_fontsize)
%     minc(1) = min(X(Ds+1,1:length(check))); minc(2) = min(normalised_gaussian_input);
%     maxc(1) = max(X(Ds+1,1:length(check))); maxc(2) = max(normalised_gaussian_input);
%     axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);

    NMI = figure('name','Estimation of Input to Model',...
        'units','centimeters',...
        'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
        'papersize',[fig_width fig_height],...
        'filename',fig_dirandname,...
        'PaperPositionMode','auto');
    if Dk ==1
    plot(t,X(Ds+1,1:length(check)),EstCol)
    hold on
    end
    plot(t,Input_mean*ones(length(t),1),SimCol);
    set(gca,'fontsize',tick_fontsize)
    box off
    xlabel('Time (s)','fontsize',label_fontsize)
    ylabel('Input (Hz)','fontsize',label_fontsize)
    minc(1) = min(X(Ds+1,1:length(check))); minc(2) = min(normalised_gaussian_input);
    maxc(1) = max(X(Ds+1,1:length(check))); maxc(2) = max(normalised_gaussian_input);
    axis([0 max(t) (min(minc)-abs(min(minc))*scale) (max(maxc)+abs(max(maxc))*scale)]);

    %     title('Model Input','fontsize', label_fontsize)
      
        
%         NMO = figure('name','Neural Mass Output',...
%     'units','centimeters',...
%     'position',[fig_left_pos fig_bottom_pos fig_width fig_height],...
%     'papersize',[fig_width fig_height],...
%     'filename',fig_dirandname,...
%     'PaperPositionMode','auto');
% plot(t,Y,SimCol)
% hold on
% plot(t,ExpY,EstCol)
% hold on
% plot(t,check(1:limit),'g');
% set(gca,'fontsize',tick_fontsize)
% xlabel('Time (s)','fontsize',label_fontsize)
% ylabel('Amplitude (mV)','fontsize',label_fontsize)
% % title('Pyramidal Population Input','fontsize', label_fontsize)
% k = legend('Noisy Obs.','Estimated Obs.','Obs.','Location',legLoc);
% legend(k,'boxoff');
% set(k,'fontsize',legend_fontsize);
% minc(1) = min(Y); minc(2) = min(ExpY);
% maxc(1) = max(Y); maxc(2) = max(ExpY);
% axis([0 max(t) (min(minc)-abs(min(minc))*scalemin) (max(maxc)+abs(max(maxc))*scale)]);
% box off
    

    
