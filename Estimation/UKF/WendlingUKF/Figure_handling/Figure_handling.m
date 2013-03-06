% script created by Richard Balson 09/01/2013

% description
% ~~~~~~~~~~~
% this script prints figures to .fig and .pdf if required

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

 if fig_save ==1
        
     saveas(NMO, [simulation_name,'Output.fig'],'fig');
    
    % Neural mass model state 1
    
    saveas(NMS1,[simulation_name,'State1.fig'],'fig');
    
    % Neural mass model state 2
    
    saveas(NMS2, [simulation_name,'State2.fig'],'fig'); % Print image with resolution 600 to pdf test.
    
    % Neural mass model state 3
    
    saveas(NMS3, [simulation_name,'State3.fig']);
    
    % Neural mass model state 4
    
    saveas(NMS4, [simulation_name,'State4.fig']);
    
    % Neural mass model state 5
    
    saveas(NMS5, [simulation_name,'State5.fig']);
    
    % Neural mass model state 6
    
    saveas(NMS6, [simulation_name,'State6.fig']);
    
    % Neural mass model state 7
    
    saveas(NMS7, [simulation_name,'State7.fig']); % Print image with resolution 600 to pdf test.
    
    % Neural mass model state 8
    
    saveas(NMS8, [simulation_name,'State8.fig']);
    
    % Neural mass model input
    
    if Dk ==1
        saveas(NMI,[simulation_name,'Input.fig'],'fig');
    end
    
    % % Neural mass model excitability
    
    if Dp >0
        
        saveas(NMPE,[simulation_name,'Exc.fig'],'fig');
        if Dp >1
            
            % Neural mass model inhibition
            
            saveas(NMP,[simulation_name,'AP.fig'],'fig');          
            
            saveas(NMPI,[simulation_name,'SInh.fig'],'fig');
            
            if Dp ==3
                saveas(NMPFI,[simulation_name,'FInh.fig'],'fig');
            end
        end
    end
    
        saveas(NMS,[simulation_name,'AS.fig'],'fig');
    end
        
        
% Print figures to a pdf
if Print ==1
    % Neural mass model output
    
    
    if PrintP==0
    
    print(NMO, '-dpdf', '-r2400', [simulation_name,'Output.pdf']);
    
    % Neural mass model state 1
    
    print(NMS1, '-dpdf', '-r2400', [simulation_name,'State1.pdf']);
    
    % Neural mass model state 2
    
    print(NMS2, '-dpdf', '-r2400', [simulation_name,'State2.pdf']); % Print image with resolution 600 to pdf test.
    
    % Neural mass model state 3
    
    print(NMS3, '-dpdf', '-r2400', [simulation_name,'State3.pdf']);
    
    % Neural mass model state 4
    
    print(NMS4, '-dpdf', '-r2400', [simulation_name,'State4.pdf']);
    
    % Neural mass model state 5
    
    print(NMS5, '-dpdf', '-r2400', [simulation_name,'State5.pdf']);
    
    % Neural mass model state 6
    
    print(NMS6, '-dpdf', '-r2400', [simulation_name,'State6.pdf']);
    
    % Neural mass model state 7
    
    print(NMS7, '-dpdf', '-r2400', [simulation_name,'State7.pdf']); % Print image with resolution 600 to pdf test.
    
    % Neural mass model state 8
    
    print(NMS8, '-dpdf', '-r2400', [simulation_name,'State8.pdf']);
    
    % Print zoomed in images
    
    if (zoom >0)
        
        % Neural mass model output
        
        
        print(NMOZ, '-dpdf', '-r2400', [simulation_namez,'Output.pdf']);
        
        % Neural mass model state 1
        
        print(NMS1Z, '-dpdf', '-r2400', [simulation_namez,'State1.pdf']);
        
        % Neural mass model state 2
        
        print(NMS2Z, '-dpdf', '-r2400', [simulation_namez,'State2.pdf']);
        
        % Neural mass model state 3
        
        print(NMS3Z, '-dpdf', '-r2400', [simulation_namez,'State3.pdf']); % Print image with resolution 600 to pdf test.
        
        % Neural mass model state 4
        
        print(NMS4Z, '-dpdf', '-r2400', [simulation_namez,'State4.pdf']);
        
        % Neural mass model state 5
        
        print(NMS5Z, '-dpdf', '-r2400', [simulation_namez,'State5.pdf']);
        
        % Neural mass model state 6
        
        print(NMS6Z, '-dpdf', '-r2400', [simulation_namez,'State6.pdf']);
        
        % Neural mass model state 7
        
        print(NMS7Z, '-dpdf', '-r2400', [simulation_namez,'State7.pdf']);
        
        % Neural mass model state 8
        
        print(NMS8Z, '-dpdf', '-r2400', [simulation_namez,'State8.pdf']); % Print image with resolution 600 to pdf test.
    end 
    end
    
    % Neural mass model input
    
    if Dk ==1
        
        print(NMI, '-dpdf', '-r2400', [simulation_name,'Input.pdf']);
        print(NMIZ, '-dpdf', '-r2400', [simulation_namez,'Input.pdf']);
    end
    
    % % Neural mass model excitability
    
    if Dp >0
        
        print(NMPE, '-dpdf', '-r2400', [simulation_name,'Exc.pdf']);
        print(NMPEZ, '-dpdf', '-r2400', [simulation_namez,'Exc.pdf']);
        if Dp >1
            
            % Neural mass model inhibition
            
            print(NMP, '-dpdf', '-r2400', [simulation_namez,'AP.pdf']);           
            
            print(NMPI, '-dpdf', '-r2400', [simulation_name,'SInh.pdf']);
            print(NMPIZ, '-dpdf', '-r2400', [simulation_namez,'SInh.pdf']);
            
            if Dp ==3
                print(NMPFI, '-dpdf', '-r2400', [simulation_name,'FInh.pdf']);
                print(NMPFIZ, '-dpdf', '-r2400', [simulation_namez,'FInh.pdf']);
            end
        end
    end
    

    

end
    close all;

