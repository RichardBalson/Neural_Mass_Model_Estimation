% script created by Richard Balson 21/02/2013

% description
% ~~~~~~~~~~~
% this script assignes all static variables, all staes and parameters are
% initialised by realising a gaussin distribution with an assigned number
% of standard deviations.

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script

% ~~~~~~~~~~~~~~~~~~~~~

Parameter_varying=0; % Initialse parameter m, If m = 1 parameter uncertainty increases to account for the fact that the parameters vary in time. m is always set to zero, and is adjusted in the code accordingly

% Image names and handling
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~`
stochasticv=round(2*stochastic); % This variable is used for image naming, if it is 1 stochastic effect is half, 2 stochastic effect as specified in Wendling et al. 2002
if ((min(MVI(:,1))==max(MVI(:,1))) && (min(MVI(:,2))==max(MVI(:,2))) && (min(MVI(:,3))==max(MVI(:,3))))
    
    simulation_initial_name = [Estimation_Type,'_UKF_WM8_f=',int2str(sampling_frequency),...
        '_A_',int2str(MVI(1,1)),'_B_',int2str(MVI(1,2)),'_G_',int2str(MVI(1,3)),'_DC_S_',int2str(stochasticv)]; % Initaite name for simulation, used for saving purposes
else
    Parameter_varying=1;
    simulation_initial_name = [Estimation_Type,'_UKF_WM8_VP_f=',int2str(sampling_frequency),...
        '_A_',int2str(MVI(1,1)),'_B_',int2str(MVI(1,2)),'_G_',int2str(MVI(1,3)),'_DC_S_',int2str(stochasticv)]; % Initaite name for simulation, used for saving purposes
end

% Simulated Signal Data mV
% ~~~~~~~~~~~~~~~~~~
EstStart_Sample = round(EstStart*sampling_frequency)+1;
check = output8(EstStart_Sample:limit); % Assign a new variable as the simulated output, data point form time EstStart are used as the beginning of the observations

% Realise Initial parameter values for the estimation procedure
% ~~~~~~~~~~~~~~~~~~~~

% Determine mean value for all parameters

if (Parameter_initialisation ==0)
    
    mu_A = (Max_A+Min_A)/2;
    mu_B = (Max_B+Min_B)/2;
    mu_G = (Max_G+Min_G)/2;
    
    % Determine one standard deviation for all parameters
    
    sigma_A = (Max_A-Min_A)/(2*number_of_sigma);
    sigma_B = (Max_B-Min_B)/(2*number_of_sigma);
    sigma_G = (Max_G-Min_G)/(2*number_of_sigma);
    
    Initial_excitability = mu_A + randn(1)*sigma_A; % Intial excitability, estimate of parameter A
    Initial_inhibition = mu_B + randn(1)*sigma_B; % Intial slow inhibition, estimate of parameter B
    Initial_Finhibition = mu_G + randn(1)*sigma_G; % Intial fast inhibition, estimate of parameter G
    
else
    Initial_excitability = (1-PercError/100)*MVI(1,1); % Intial excitability, estimate of parameter A
    Initial_inhibition = (1-PercError/100)*MVI(1,2); % Intial slow inhibition, estimate of parameter B
    Initial_Finhibition = (1-PercError/100)*MVI(1,3); % Intial fast inhibition, estimate of parameter G
end

% Solver Parameters
% ~~~~~~~~~~~~~~~~~~

% Hz

frequency = sampling_frequency; % Define the frequency for estimation

% Seconds

dt = 1/frequency; % Specify the time period over which estimates will be made

 variance_adjustment = dt;%sqrt(dt); %  This parameter is used to adjust the variance of states ccording to the sampling frequency

% Number of sigma points
% ~~~~~~~~~~~~~~~~~~~

if kappa > 0
    Sigma_points = 2*Dx+1;  % Specify number of sigma points to generate, if kappa is greater than zero than the mean is propagated
    % through the system and there is therefore one more sigma point generated
else
    Sigma_points = 2*Dx; % When kappa is set to zero sigma points are generated, note there are twice the number of sigma points as there are states
    % the reason for this is that for each mean state
    % value, a sigma point one standard deviation from
    % its mean are propagated through the system. This
    % inclue the sigma points: mean - standard deviation
    % and mean + standard deviation
end

% Estimation parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~

% Uncertianty for each state and parameter
% mV

State_uncertainty = ones(1,8)*Base_state_uncertainty; % Specify base state uncertainty for all states
State_uncertainty(1,[2 6]) = ones(1,2)*(stochastic*Variable_state_uncertainty+Base_state_uncertainty); % Alter uncertainty of parameter affected directly by stochastic input

if Dp >0
    Parameter_uncertainty(1,1) = Base_parameter_uncertainty + Variable_parameter_uncertainty*Parameter_varying; % Variance to allow for model error and stochastic input effect
    Parameter_std_deviation(1,1) = max(Max_A-Initial_excitability,Initial_excitability-Min_A); % Variance to allow for tracking of parameters Parameters appear to work  5e-3
    if Dp >1
        Parameter_uncertainty(1,2) = (Base_parameter_uncertainty + Variable_parameter_uncertainty*Parameter_varying);
        Parameter_std_deviation(1,2) = max(Max_B-Initial_inhibition,Initial_inhibition-Min_B);
        if Dp >2
            Parameter_uncertainty(1,3) = (Base_parameter_uncertainty + Variable_parameter_uncertainty*Parameter_varying); %[m*1e-1+1e-3 m*2.5e-1+1e-3 m*2.5e-1+1e-3]
            Parameter_std_deviation(1,3) = max(Max_G-Initial_Finhibition,Initial_Finhibition-Min_G);
        end
    end
else
    Parameter_uncertainty = [];
    Parameter_std_deviation = [];
end


State_uncertaintyF = repmat(State_uncertainty,Ds,1);

Parameter_uncertaintyF = repmat(Parameter_uncertainty,Dp,1);% Define a parameter uncertainty matrix that can easily be used for future purposes.

Parameter_std_deviationF = repmat(Parameter_std_deviation,Dp,1);% Define a parameter variance matrix that can easily be used for future purposes.

Measurement_noise = NoiseIn; % Noise expected on measurements

Y = check + randn(length(check),1)*Measurement_noise; % Initalise noise on the simulated signal

Number_of_observations = length(Y); % Parameter that defines he number of observations from the simulation

% Initialise all relevant variables
% ~~~~~~~~~~~~~~~~~~~~~~~~~

X = zeros(Dx,1,Number_of_observations); % Intialise state estimate matrix
Pxx = zeros(Dx,Dx,Number_of_observations);% Intialise state covariance estimate matrix
Xout = zeros(Dx,Sigma_points,Number_of_observations); % Intialise output states from the point sin the unscented transform matrix
Yout = zeros(Dy,Sigma_points,Number_of_observations); % Intialsie the model output for each set of sigm points matrix
ExpX = zeros(Dx,Number_of_observations);% Intialise athe expected states from the unscented transform matrix
ExpY = zeros(Dy,Number_of_observations);% Intialise the expected states from the unscented transform matrix
Sigma = zeros(Dx,Sigma_points,Number_of_observations);% Intialise the sigma points matrix
