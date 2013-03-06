% script created by Richard Balson 01/03/2013

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

perc =0.1; % Maximum  percentage change for prpagation os states with one time step

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

if Dk==1
    Input_uncertainty = Variable_input_uncertainty*(Input_mean_variation>0)+Base_input_uncertainty; % Define the uncertainty of the input to the model, 
    Input_std_deviation = max((Input_mean - Min_frequency),Max_frequency-Input_mean)/number_of_sigma_input; % Define the variance of the input to the model Base 1e-2
    Gauss_input_mean = Input_mean + Input_std_deviation*randn(1);
    X(Ds+1) = Gauss_input_mean;
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