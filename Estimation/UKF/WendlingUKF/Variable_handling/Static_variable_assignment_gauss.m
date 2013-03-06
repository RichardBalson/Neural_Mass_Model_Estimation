% script created by Richard Balson 10/01/2013

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

m=0; % If m = 1 parameter uncertainty increases to account for the fact that the parameters vary in time. m is always set to zero, and is adjusted in the code accordingly

% Image names and handling
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~`
stochasticv=round(2*stochastic);
if ((min(MVI(:,1))==max(MVI(:,1))) && (min(MVI(:,2))==max(MVI(:,2))) && (min(MVI(:,3))==max(MVI(:,3))))
    
    simulation_initial_name = ['Gauss_UKF_WM8_f=',int2str(sampling_frequency),...
        '_A_',int2str(MVI(1,1)),'_B_',int2str(MVI(1,2)),'_G_',int2str(MVI(1,3)),'_DC_S_',int2str(stochasticv)]; % Initaite name for simulation, used for saving purposes
else
    m=1;
    simulation_initial_name = ['Gauss_UKF_WM8_VP_f=',int2str(sampling_frequency),...
        '_A_',int2str(MVI(1,1)),'_B_',int2str(MVI(1,2)),'_G_',int2str(MVI(1,3)),'_DC_S_',int2str(stochasticv)]; % Initaite name for simulation, used for saving purposes
end

% Simulated Signal Data mV
% ~~~~~~~~~~~~~~~~~~

check = output8(round(EstStart*sampling_frequency)+1:limit); % Assign a new variable as the simulated output

% Realise Initial parameter values for the estimation procedure
% ~~~~~~~~~~~~~~~~~~~~

% Determine mean value for all parameters

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

% Solver Parameters
% ~~~~~~~~~~~~~~~~~~

% Hz

frequency = sampling_frequency; % Define the frequency for estimation

% Seconds

dt = 1/frequency; % Specify the time period over which estimates will be made

variance_adjustment = sqrt(dt); % This parameter is used to adjust the variance of states ccording to the sampling frequency

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

State_uncertainty = ones(1,8)*Base_state_uncertainty;
State_uncertainty(1,[2 6]) = ones(1,2)*(stochastic*Variable_state_uncertainty+Base_state_uncertainty); % Alter uncertainty of parameter affected by varying input directly

if Dp >0
    Parameter_uncertainty(1,1) = Base_parameter_uncertainty + Variable_parameter_uncertainty*m; % Variance to allow for model error and stochastic input effect
    Parameter_std_deviation(1,1) = max(Max_A-Initial_excitability,Initial_excitability-Min_A); % Variance to allow for tracking of parameters Parameters appear to work  5e-3
    if Dp >1
        Parameter_uncertainty(1,2) = (Base_parameter_uncertainty + Variable_parameter_uncertainty*m);
        Parameter_std_deviation(1,2) = max(Max_B-Initial_inhibition,Initial_inhibition-Min_B);
        if Dp >2
            Parameter_uncertainty(1,3) = (Base_parameter_uncertainty + Variable_parameter_uncertainty*m); %[m*1e-1+1e-3 m*2.5e-1+1e-3 m*2.5e-1+1e-3]
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

Measurement_noise =NoiseIn; % Noise expected on measurements

Y = check + randn(length(check),1)*Measurement_noise; % Initalise noise on the simulated signal

Number_of_observations = length(Y); % Parameter that defines he number of observations from the simulation

% Initialise all relevant variables
% ~~~~~~~~~~~~~~~~~~~~~~~~~

X = ones(Dx,1,Number_of_observations); % Intialise state estimate matrix
Pxx = zeros(Dx,Dx,Number_of_observations);% Intialise state covariance estimate matrix
Xout = zeros(Dx,Sigma_points,Number_of_observations); % Intialise output states from the point sin the unscented transform matrix
Yout = zeros(Dy,Sigma_points,Number_of_observations); % Intialsie the model output for each set of sigm points matrix
ExpX = zeros(Dx,Number_of_observations);% Intialise athe expected states from the unscented transform matrix
ExpY = zeros(Dy,Number_of_observations);% Intialise the expected states from the unscented transform matrix
Sigma = zeros(Dx,Sigma_points,Number_of_observations);% Intialise the sigma points matrix

% Model parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~

%  mV

A=MVI(1,1);
B =MVI(1,2);
G=MVI(1,3);
gain = [A B G];

% Estimate initial state values for populations output voltage
% ~~~~~~~~~~~~~~~~~`

sigmoid_center = 6; %Center of sigmoid

perc =0.1;

mean_state = initial_mean_calculation_WNM(C,sigmoid_center,perc,dt);

% Estimate initial state standard deviation

% ~~~~~~~~~~~~~~~~~~~~~~~~~

% Assume states will function within 2% and 98% of sigmoid firing rate bounds.

lower_percentage=0.02;
upper_percentage=0.98;

max_sig =5; % Sigmoid upper bound
min_sig = 0; % Sigmoid lower bound

sigmoid_gradient = .56; % Sigmoid gradient

t_state = 2;% Set time for state to vary from one threshold to mean

State_std_deviation = initial_std_deviation_calculation_WNM(mean_state,C,max_sig,min_sig,lower_percentage,upper_percentage,...
    sigmoid_gradient,t_state,sigmoid_center,variance_adjustment,Ds,dt);

% Gaussian State realisation

State_sigma = State_std_deviation/number_of_sigma;

Gauss_state = mean_state + State_sigma(1,:).*randn(1,8);

% Model Input
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Min_frequency = frequency_limits(1); % Minimum input frequency from pyramidal neruons external to model
Max_frequency = frequency_limits(2); % Maximum input frequency from pyramidal neruons external to model
Input_mean = (Max_frequency+Min_frequency)/2; % Mean input frequency from pyramidal neruons external to model

% Initialise state matrix
% ~~~~~~~~~~~~~~~~~~~

X(1:Ds,:,1) = Gauss_state; % Intialise all parameters for the state estimate

if Dp >0                                    % Check whether parameters need to be estimated, if so alter storage folder
    Estimation_type = 'ParameterEstimation'; % Set folder into which images will be sved if they are printed
    X(Ds+Dk+1) = Initial_excitability;     % Set the intial guess for the A to be the initial value specified.
    if Dp >1                                % Check whether more than one parameter needs to be estimated
        X(Ds+Dk+2) = Initial_inhibition;    % Set the intial guess for the B to be the initial value specified.
        if Dp==3                            % Check if parameter G needs to be estimated
            X(Ds+Dk+3) = Initial_Finhibition;% Set the intial guess for the G to be the initial value specified.
        end
    end
else
    Estimation_type = 'StateEstimation'; %Set folder into which images will be sved if they are printed
end


% Covariance matrix Description
% ~~~~~~~~~~~~~~~~~~~

Input_uncertainty = Variable_input_uncertainty*stochastic+Base_input_uncertainty; % Define the uncertainty of the model to the stochastic input Base 1
Input_std_deviation = (Input_mean - Min_frequency)/number_of_sigma_input; % Define the variance of the input to the model Base 1e-2

if Dk==1
    X(Ds+1) = Input_mean;
    Input_variance = Input_std_deviation.^2.*variance_adjustment;
    Input_uncertainty = Input_uncertainty.^2.*variance_adjustment;
else
    Input_variance =[];
    Input_uncertainty =[];
end

State_covariance_matrix = eye(Ds).*State_std_deviation.^2.*variance_adjustment; % State covariance matrix

Parameter_covariance_matrix = eye(Dp).*Parameter_std_deviationF.^2.*variance_adjustment; % State Parameter matrix

State_uncertainty_matrix = eye(Ds).*State_uncertaintyF.^2.*variance_adjustment;

Parameter_uncertainty_matrix = eye(Dp).*Parameter_uncertaintyF.^2.*variance_adjustment;


Pxx(:,:,1) = blkdiag(State_covariance_matrix,Input_variance,Parameter_covariance_matrix); %Covariance of model states and parameters

R = Measurement_noise^2;

Q = blkdiag(State_uncertainty_matrix,Input_uncertainty,Parameter_uncertainty_matrix);