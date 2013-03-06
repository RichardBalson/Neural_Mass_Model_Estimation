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

simulation_name = strcat(Estimation_type,'\',simulation_initial_name,'_P_',int2str(Dp+Dk),'PE_','Gauss','_N_',int2str(Measurement_noise*1e3),'mV_');

Error_name = strcat(Estimation_type,'\','Error_',simulation_initial_name,'_P_',int2str(Dp+Dk),'PE_','Gauss','_N_',int2str(Measurement_noise*1e3),'mV');

simulation_namez = strcat(simulation_name,'z_', int2str(zoom),'s_');

save(Error_name,'Nerr','Oerr','err');

if (fig_save ==1) % Determine whether figures need to be saved
    
    Image_handling_states_names = {'Vpo' 'Veo' 'Vsio' 'Vfio' 'Zpo' 'Zeo' 'Zsio' 'Zfio' 'Input' 'Excitation' 'Slow_Inhibition' 'Fast_Inhibition'...
        ; 'VpoZ' 'VeoZ' 'VsioZ' 'VfioZ' 'ZpoZ' 'ZeoZ' 'ZsioZ' 'ZfioZ' 'InputZ' 'ExcitationZ' 'Slow_InhibitionZ' 'Fast_InhibitionZ'};
    
    for k = 1:size(Image_handling_names,2) % Determine which states have been plotted and save them as a .fig
        for j = 1:size(Image_handling_names,1)
            
            if (Image_handling_states(j,k) ==1)
                if (j ==1)
                    Image_index = NMS(k);
                else
                    Image_index = NMSZ(k);
                end
                
                saveas(Image_index,[simulation_name,Image_handling_states_names(j,k),'.fig'],'fig');
                
            end
            
        end
    end
    
    Image_handling_input_names = {'Vp' 'Ve' 'Vsi' 'Vfi'...
        ; 'VpZ' 'VeZ' 'VsiZ' 'VfiZ'};
    
    for k = 1:size(Image_handling__input_names,2) % Determine which states inputs have been ploted and save them as .fig
        for j = 1:size(Image_handling_input_names,1)
            
            if (Image_handling_inputs(j,k) ==1)
                if (j ==1)
                    Image_index = NMSI(k);
                else
                    Image_index = NMSIZ(k);
                end
                
                saveas(Image_index,[simulation_name,Image_handling_input_names(j,k),'.fig'],'fig');
                
            end
            
        end
    end
    
    Image_handling_multi_names = {'Model States' 'Model States Inputs' 'Model Parameters' 'Model Input and Parameters';...
        'Model StatesZ' 'Model States InputsZ' 'Model ParametersZ' 'Model Input and ParametersZ' }
    
    for k = 1:size(Image_handling__multi,2) % Determine which states inputs have been ploted and save them as .fig
        for j = 1:size(Image_handling__multi,1)
            
            if (Image_handling_inputs(j,k) ==1)
                if (j ==1)
                    Image_index = NMM(k);
                else
                    Image_index = NMMZ(k);
                end
                
                saveas(Image_index,[simulation_name,Image_handling_input_names(j,k),'.fig'],'fig');
                
            end
            
        end
    end
end

if (Print ==1)
end
