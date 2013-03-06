% script created by Richard Balson 22/02/2013

% description
% ~~~~~~~~~~~
% this script prints figures to .fig and .pdf if required

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

saveas(NMS1Z,[simulation_name,'Vp.fig'],'fig');
 

saveas(NMS2Z, [simulation_name,'Ve.fig'],'fig');


saveas(NMS3Z, [simulation_name,'Vsi.fig']);


 saveas(NMS4Z, [simulation_name,'Vfi.fig']);

%         
        saveas(NMPEZ,[simulation_name,'Exc.fig'],'fig');

%             
%             % Neural mass model inhibition
%             
            saveas(NMP,[simulation_name,'AP.fig'],'fig');          
%             
            saveas(NMPIZ,[simulation_name,'SInh.fig'],'fig');
%             

                saveas(NMPFIZ,[simulation_name,'FInh.fig'],'fig');

%     
        saveas(NMS,[simulation_name,'AS.fig'],'fig');
        
        saveas(NMI,[simulation_name,'Input.fig'],'fig');


