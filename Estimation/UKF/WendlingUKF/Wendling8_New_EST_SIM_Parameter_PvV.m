% script created by Richard Balson 25/11/2012

% description
% ~~~~~~~~~~~
% This script estimates synaptic gains of the extended neural mass
% model using the unscented Kalman filter, it also simualtes the states and
% output of the extended neural mass model

% last edit
% ~~~~~~~~~

% Code for determing the effect of varying values of model parameters on
% estimation results

% next edit
% ~~~~~~~~~

% adjust standard deviation on state covariance matrix, may need to reduce
% sigmoid range in order to llow for computation to be correct, standard
% deviation currently using dt multiplier, develop method to calculate
% standard deviation for input and model parameters, use parameters from
% simulation, dont redefine parameters if they are already defined.

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

% Clear workspace
% ~~~~~~~~~~~
clear
close all
clc
%%

addpath(genpath('..\..\UKF'));

system_dependent('setprecision',24); % Set the precision of accuracy in order to reduce the effect of rounding errors.

% Simulation decision
% ~~~~~~~~~~~~~~~~~
% for AV = 3:7
%      clear BV GV
%     for BV = 0:5:40
%          clear AV GV
        for GV = 0:5:40
            clear AV BV

    
    simulate =1; % Decide whether to simulate model output or use previous results if simulate is equal to  then the model is resimulated
    if simulate ==1
        stochastic = 1;
        Wendling8_Sim_v2; % Simulate states and output of the extended neural mass model
        save Wendling_out_cp_s1 output8 z normalised_gaussian_input sampling_frequency stochastic MVI tcon C frequency_limits % Save relevant parameters for future use
        % output8 contains the siulated
        % model output; normalised_gaussian
        % input contains the input to the
        % model; sampling_frequency
        % contains the sampling frequency
        % used for simulation; stochastic
        % decides whether the variance is
        % applied to the input; MVI
        % contains the model gains; tcon
        % the model time constants; C the
        % connectivity constants and
        % frequency_limits the limits for
        % the input frequency
    else
        load Wendling_out_cp_s1 output8 z normalised_gaussian_input sampling_frequency stochastic MVI tcon C frequency_limits% Load model parameters from previous simulations
    end
    
    % Dynamic variables
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    % Image handling
    % ~~~~~~~~~~~~~~~~~~~~~~~
    
    fig_save =1; % Save figures as .fig for future use
    
    Print =0; % If Print = 1 figures will print to pdf
    
    PrintP =1; % If printP =1 print only parameter plots
    
    % Zoom parameters (seconds)
    % ~~~~~~~~~~~~~~~~~
    
    tstart =2; % Starting time for zoom
    
    zoom = 10; % Duration of zoom
    
    % NoiseIn = 1e-2;% Base 1e-2
    
    % Simulated signal data mV
    % ~~~~~~~~~~~~~~~~
    
    limit = length(output8); % Set limit on amount of points used for estimation
    
    % Estimation Procedure Parameters
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Ds = 8; % Number of differential equations describing model
    Dp = 3; % Number of parameters to be estimated
    Dk =1; %Number of stochastic inputs in the system that need to be estimated
    Dx = Ds +Dp+Dk; % Number of Dx of augmented state matrix Note that estimated parameters and inputs are now considered to be 'states' in the estimation procedure
    Dy =1; % Number of observable outputs from the simulation
    
    Percentage = 0.1; % Base 0.1, specify percentage error on initial estimates
    
    kappa =0; % Varibale used to define the relative contribution of the mean on the propogation of states
    
    Base_state_uncertainty = 1e-3; % Inherent state uncertainty due to model error
    
    Variable_state_uncertainty = 5e-1; % Uncertianty due to stochastic input
    
    Base_parameter_uncertainty = 1e-3; % Inherent parameter uncertainty due to model error
    
    Variable_parameter_uncertainty = 2.5e-1;  % Uncertianty due parameter varying in time
    
    Base_input_uncertainty = 1e-3; % Inherent parameter uncertainty due to model error
    
    Variable_input_uncertainty = 5e-1; % Uncertianty due to stochastic input
    
    NoiseIn = 1e-2;
    
    % Physiological range of Model gains
    % ~~~~~~~~~~~~~~~~~
    
    Max_A =7;
    Min_A =3;
    Max_B =40;
    Min_B =0;
    Max_G =40;
    Min_G =0;
    
    % Static Variables
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % ~~~~~~~~~~~
 
 Static_variable_assignment;   
    
    %%
    
    % UKF algorithm
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    for p =1:length(Y)
        
        Sigma(:,:,p) = Unscented_transform(Dx,Pxx(:,:,p),X(:,:,p),kappa);
        
        for k = 1:Number_sigma
            for j = 1:Dp
            if Sigma(Ds+Dk+j,k,p) <0 % Check if parameter breaches physiological range
               Sigma(Ds+Dk+j,k,p) =0;
            end
        end
            if Dp==3
                gain = [Sigma(Ds+Dk+1,k,p) Sigma(Ds+Dk+2,k,p) Sigma(Ds+Dk+3,k,p)];
            elseif Dp ==2
                gain = [Sigma(Ds+Dk+1,k,p) Sigma(Ds+Dk+2,k,p) G];
            elseif Dp==1
                gain = [Sigma(Ds+Dk+1,k,p) B G];
            end
            
            if Dk ==1
                Input_var = Sigma(Ds+1,k,p);
            else
                Input_var = Input_mean;
            end
            
            [Xout(:,k,p) Yout(:,k,p)] = WNM1(Sigma(:,k,p),dt,Input_var, gain, tcon,C);
            
        end
        
        [ExpX(:,p) ExpY(:,p) Pxxn Pxyn Pyyn] = Expectation(Xout(:,:,p), Dx, Yout(:,:,p), 1,kappa);
        
        Pyyn = Pyyn +R;
        %
        Pxxn = Pxxn + Q;
        
        %     Pxxn(7,7) = Input_var1;
        
        [X(:,1,p+1) Pxx(:,:,p+1)] = Kalman(ExpX(:,p), ExpY(:,p), Y(p), Pxxn, Pxyn, Pyyn);
        
        %     Pxx(:,:,p+1) = Pxx(:,:,p+1) + Pxx(:,:,1);n
        
        %     if Dp>0
        %         Pxx(Ds+Dk+1,Ds+Dk+1,p+1) = Parameter_variance.^2;
        %         if Dp >1
        %             Pxx(Ds+Dk+2,Ds+Dk+2,p+1) = Parameter_variance.^2;
        %             if Dp==3
        %                 Pxx(Ds+Dk+3,Ds+Dk+3,p+1) = Parameter_variance.^2;
        %             end
        %         end
        %     end
        
        
        
    end
    
    
    % Determine mean square error for states
    % ~~~~~~~~~~~~~~~~~~
  
    Error_calculation;
    
    %%
    
    % defines bits for plotting
    % ~~~~~~~~~~~~~~~~~~~~~~~~~
    label_fontsize = 10;            % point
    tick_fontsize = 8;              % point
    fig_left_pos = 5;               % cms
    fig_bottom_pos = 5;             % cms
    fig_width = 8.2;                % cms
    fig_height = 5;                 % cms
    fig_dirname = 'c:\';              % default directory for figure files
    fig_name = 'Comparison of estimated and simulated signal.fig';
    fig_dirandname = [fig_dirname fig_name];
    legend_fontsize = 4;
    
    % Plot of output
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    maxlimit = round(frequency/10):length(check);
    
    scale = 0.5;
    
    
   Generate_figures;

simulation_name = strcat(Estimation_type,'\',simulation_initial_name,'_P_',int2str(Dp+Dk),'PE_',int2str(Percentage*100),'_N_',int2str(Measurement_noise*1e3),'mV_');

Error_name = strcat(Estimation_type,'\','Error_',simulation_initial_name,'_P_',int2str(Dp+Dk),'PE_',int2str(Percentage*100),'_N_',int2str(Measurement_noise*1e3),'mV');

simulation_namez = strcat(simulation_name,'z_', int2str(zoom),'s_');

save(Error_name,'Nerr','Oerr','err');

Figure_handling;
end





% print(gcf, '-dpdf', '-r1200', 'UKFestimation.pdf') % Print image with
% resolution 600 to pdf test.