% script created by Richard Balson 21/02/2013

% description
% ~~~~~~~~~~~
% Simulate states and output of the extended neural mass model for
% estimation purposes. Input mean assumed to be 90.

% last edit
% ~~~~~~~~~

%

% Variables required
% ~~~~~~~~~~~~~~~

% stochastic -  Determines level of stochasticity in input
% number_of_sigma_input - Determines the standard deviation of stochastic input
% Parameter_index - Used to decide what parameter should be simulated
% Input_mean_variation - uSed to specifiy whether the mean of the input
% should be different from its described nominal value

% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

%%

% Model parameters(Variable parameters are to alter parameter values during
% simulation) Matrix specifies parameter values for a specified time period
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units s
% ~~~~~~~~~~~~~

simulation_time =20; %Time for simulation

% Units NS
% ~~~~~~~~~~~~

slope_time =2.5; % Specifies the time over which the model gain should be altered

% Units mV
% ~~~~~~~~~~~~

Max_parameters = simulation_time/(slope_time+0.5); % Specifiy maximum number of parameters for random simulation
[AV BV GV] = Parameter_choice(Parameter_index,Max_parameters);

% Solver parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

simulation_changes = length(AV); % Specify the number of times the parameters change in simulation

% Units Hz
% ~~~~~~~~

sampling_frequency = 2048; % Sampling frequency for solutions and measurements

% Multiple parameter simulation

change_A = 0;      % Change to A after solver finsihed
change_B = 0;     % Change to B after solver finsihed
change_G = 0;     % Change to G after solver finsihed
number_of_changes =0;   % Specify number of simulation to perform



%%
% Stationery Parameter defintions
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~
Wendling_Model_Simulations_Stat_def


% e = xxxx*randn(NSamples,1);
% Determine stochastic input to the model
% ~~~~~~~~~~~~~~~~~~~~~~~
gauss = randn(1,length(normalise)+1)*std_deviation*stochastic;

for j = 1:(number_of_changes+1)         % Iteration to change parameters in function
    
    for k = normalise+1                   % Time Iterations for solver
        
%         gauss = randn(1)*std_deviation*stochastic; % Determine random fluctuations in input signal with the specified standard deviation
        
            normalised_gaussian_input(k,j) = meanf + gauss(1,k); % Determine value of input for all time steps
        
        while ((normalised_gaussian_input(k,j)>max_frequency) || (normalised_gaussian_input(k,j) <min_frequency))
            
           gauss(1,k) = randn(1)*std_deviation*stochastic;
            
            normalised_gaussian_input(k,j) = meanf + gauss(1,k);
            
        end
        
        normalised_gaussian_inputSDE(k,j) = meanf + gauss(1,k)*sqrt(dt)*sampling_frequency; % Determine value of input used for calculation purposes for all time steps
        
    end
end

%%

% Equations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% Solver
% ~~~~~~~~~~~~~~~~~~~~~~~

for j = 1:(number_of_changes+1)         % Iteration to change parameters in function
    for k = normalise
        %
        % 8th Order
        % Derivation of equation shown in pdf attached
        
        % Normalised gaussian input
        
        zs1 =  z(k,2,j)-C(4)*z(k,3,j)-z(k,4,j);
        zs2 = C(1)*z(k,1,j);
        zs3 = C(3)*z(k,1,j);
        zs4 = C(5)*z(k,1,j)-C(6)*z(k,3,j);
        [z(k+1,1,j) z(k+1,5,j)] = PSPkernel([z(k,1,j) z(k,5,j)],dt,MV(k,1,j),a,sigmoid(zs1));
        [z(k+1,2,j) z(k+1,6,j)] = PSPkernel([z(k,2,j) z(k,6,j)],dt,MV(k,1,j),a,normalised_gaussian_inputSDE(k,j) +C(2)*sigmoid(zs2));
        [z(k+1,3,j) z(k+1,7,j)] = PSPkernel([z(k,3,j) z(k,7,j)],dt,MV(k,2,j),b,sigmoid(zs3));
        [z(k+1,4,j) z(k+1,8,j)] = PSPkernel([z(k,4,j) z(k,8,j)],dt,MV(k,3,j),g,C(7)*sigmoid(zs4));
        
    end
end% End of for loop

% Determine output of model
% ~~~~~~~~~~~~~~~~~~~~~~~~
for j = 1:(number_of_changes+1)
    output8(:,j) = z(:,2,j)-C(4)*z(:,3,j) -z(:,4,j);      % 8th order output, Normalised gaussian input
end