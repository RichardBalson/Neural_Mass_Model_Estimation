% script created by Richard Balson 21/02/2013

% description
% ~~~~~~~~~~~
% This script estimates synaptic gains of the extended neural mass
% model using the unscented Kalman filter, it also simualtes the states and
% output of the extended neural mass model. In this script states and
% parameters are realisations with a set mean and a defined standard
% deviation

% last edit
% ~~~~~~~~~

% Altered standard deviation for input, altered uncertainty in input, made
% limit on estimate of input

% next edit
% ~~~~~~~~~

% Work on esstimation of the input

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

% Clear workspace
% ~~~~~~~~~~~
clear
close all
clc

addpath(genpath('..\..\UKF'));

system_dependent('setprecision',24); % Set the precision of accuracy in order to reduce the effect of rounding errors.

% Simulation decision
% ~~~~~~~~~~~~~~~~~

Simulation_number = 10;

MeanCheckTStart = 1;



for q = 1:Simulation_number

simulate =1; % Decide whether to simulate model output or use previous results if simulate is equal to 1 then observations for estimatio purposes are resimulated
if (simulate ==1)
    
    number_of_sigma_input = 4; % Used to determine standard deviation of input if  1: 68.27% of realisations within physiolgical range, 2: 95.45, 3: 99.73 4: 99.994
    stochastic = 1; % Used to specifiy the stochastic adjustment on the input 1 is no adjustment. <1 downscalling, >1 upscaling
    Parameter_index = 4; % Choose parameters to be simulated: 1 = Seizure Parameter from Wendling 2002;
    %  2 = Seizure Parameter from Wendling 2005;...
    %  3 = Altered excitability;
    %  4 = Parameters at midpoint of their range;
    %  5 = random parameters;
    %  6= random parameters and random number of
    %  variations in simulation
    Input_mean_variation = 0; % If 0 mean stays constant for simulation,
    %if 1 input mean is drawn from a uniform distribution limited by the physiological limits of the input
    % if 2 input mean is drawn from a Gaussian
    % distribution with a mean as per Wendling
    % 2002 and stnadard deviation that satisfies
    % number_of_sigma_input
    Wendling_Model_Simulation; % Simulate states and output of the extended neural mass model
    save Wendling_out_cp_gauss_F output8 z normalised_gaussian_input sampling_frequency stochastic MVI tcon C frequency_limits number_of_sigma_input Input_mean_variation meanf% Save relevant parameters for future use
    % output8 contains the simulated
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
    load Wendling_out_cp_gauss_F output8 z normalised_gaussian_input sampling_frequency stochastic MVI tcon C frequency_limits number_of_sigma_input Input_mean_variation meanf% Load model parameters from previous simulations
end

% Dynamic variables
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Estimation Control variables
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Estimation Procedure Parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ds = 8; % Number of differential equations describing model, also the number of fast states to be estiamted

Dp = 3; % Number of parameters to be estimated, also refered to as slow states

Dk =1; %If set to 1 the mean of the stochastic input will be estimated % Note that if Input_mean_variation is not zero than Dk should be set to one to allow tracking of the input mean

Dx = Ds+Dp+Dk; % Number of dimensions of augmented state matrix, Note that estimated parameters and inputs are now considered to be 'slow states' in the estimation procedure

Dy =1; % Number of observable outputs from the simulation

Parameter_initialisation = 0; % 0 for parameters to be initialised by Gauss distribution
                              % 1 for parameters to be initialsed as a
                              % percetage error from actual values

EstStart = 0.25; % Specify the duration after simulation start when estimation should start. This allows removal of all transients.

number_of_sigma = 4; % Number of standard deviations from mean. 4 accounts for 99.73 percent of points.

PercError = 10; % Specify percentage error for parameter intialisation

kappa =0; % Varibale used to define the relative contribution of the mean on the propogation of states

Base_state_uncertainty = 1e-3; % Inherent state uncertainty due to model error

Variable_state_uncertainty = 1e-3; % Uncertianty due to stochastic input

Base_parameter_uncertainty = 1e-3; % Inherent parameter uncertainty due to model error

Variable_parameter_uncertainty = 1e-3;  % Uncertianty due parameters varying in time

Base_input_uncertainty = 1e-3; % Inherent parameter uncertainty due to model error

Variable_input_uncertainty =1e-3; % Uncertianty due varying input mean, Set to zero if the input mean is not varying

% Image handling parameters
% ~~~~~~~~~~~~~~~~~~~~~~~

Estimation_Type = 'Gauss'; % Estimation Type is an indication of what estimation is being performed for, here Gauss indicates that all staes are initialised as realisations from a Gaussian distribution

fig_save =0; % Save figures as .fig for future use

Print =0; % If Print = 1 figures will print to pdf

PrintP =1; % If printP =1 print only parameter plots

Image_handling_model_output=[0;0];

plot_uncertainty =1; % Plot covariance of all states

Image_handling_states = [0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0]; % Here a decision is made whether to plot specific states, 
                                                                            % if the value is one the relevant figure is plotted, otherwise it is not.
                                                                            % The columns indicate the state to plot and the rows indicate whether the whole simulation or a zoomed in ploted should be plotted.
                                                                            % Column one corresponds with state 1 and so forth.
Image_handling_inputs = [0 0 0 0;0 0 0 0];  % Here a decision is made whether to plot specific states, 
                                                                            % if the value is one the relevant figure is plotted, otherwise it is not.
                                                                            % The columns indicate the state to plot and the rows indicate whether the whole simulation or a zoomed in ploted should be plotted.
                                                                            % Here column 1-4 are Vp,Ve,Vsi and Vfi respectively.

Image_handling_firing_rates = [0 0 0 0]; % Here a decision is made whether to plot specific states, 
                                                                            % if the value is one the relevant figure is plotted, otherwise it is not.
                                                                            % The columns indicate the firing rate to plot. this is a three image plot where the input potential population firing rate and output potential are plotted.
                                                                            % Here column 1-4 are Vp,Ve,Vsi and Vfi respectively.

Image_handling_multi = [0 0 0 1;0 0 0 0];%  % Here a decision is made whether to plot specific states, 
                                                                            % if the value is one the relevant figure is plotted, otherwise it is not.
                                                                            % The columns indicate the figures to be plotted.
                                                                            % Here column 1-4 are for all the model states, all the model states inputs, all the model parameters and all the model parameters including the input mean.

% Zoom parameters (seconds)
% ~~~~~~~~~~~~~~~~~

tstart =0; % Starting time for zoom

zoom = 10; % Duration of zoom

NoiseIn = 1e-2;% Base 1e-2

% Simulated signal data mV
% ~~~~~~~~~~~~~~~~

limit = length(output8); % Set limit on amount of points used for estimation

% Physiological range of Model gains
% ~~~~~~~~~~~~~~~~~

Max_A =7;
Min_A =3;
Max_B =40;
Min_B =0;
Max_G =40;
Min_G =0;

Max = [Max_A, Max_B, Max_G];
Min = [Min_A, Min_B, Min_G];

% Static Variables
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~

Static_variables_estimation;

p=length(Y);
while ((p==length(Y)) && ((X(Ds+Dk+1,1,p) <Min(1)+1) || (X(Ds+Dk+1,1,p) >Max(1)-1)) && ((X(Ds+Dk+2,1,p) <Min(2)+1) || (X(Ds+Dk+2,1,p) >Max(2)-1))&& ((X(Ds+Dk+3,1,p) <Min(3)+1) || (X(Ds+Dk+3,1,p) >Max(3)-1))) 

Initialise_Parameters_and_covariances;

%%

% UKF algorithm
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

for p =1:length(Y)
    
    Sigma(:,:,p) = Unscented_transform(Dx,Pxx(:,:,p),X(:,:,p),kappa);
    
    for k = 1:Sigma_points
        for j = 1:Dp
            if (Sigma(Ds+Dk+j,k,p) <Min(j)) % Check if parameter breaches physiological range
                Sigma(Ds+Dk+j,k,p) =Min(j);
            elseif (Sigma(Ds+Dk+j,k,p) >Max(j))
                Sigma(Ds+Dk+j,k,p) =Max(j);
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
            if Sigma(Ds+1,k,p) > (frequency_limits(2))
                Sigma(Ds+1,k,p) = frequency_limits(2);
            elseif Sigma(Ds+1,k,p) < (frequency_limits(1))
                Sigma(Ds+1,k,p) = frequency_limits(1);
            end
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

end

% Determine error for state and parameter estimation

Error_calculation;

%%

% Determne how to plot estimation output
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if (Simulation_number ==1)

Generate_figures_F;

Figure_handling_F;
    
end
    MeanCheckSampleStart = MeanCheckTStart*frequency+1;
    Percentge_complete = p/Simulation_number*100;
    MeanStates(q,:) =  mean(squeeze(X(:,1,MeanCheckSampleStart:length(check)))');
    StDStates(1,:) = std(squeeze(X(:,1,MeanCheckSampleStart:length(check)))');
end


