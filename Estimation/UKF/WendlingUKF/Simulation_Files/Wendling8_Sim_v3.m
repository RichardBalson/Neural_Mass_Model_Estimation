% script created by Richard Balson 22/11/2012

% description
% ~~~~~~~~~~~
% Simulate states and output of the extended neural mass model for
% estimation purposes

% last edit
% ~~~~~~~~~

% Make strucutre easier to port

% Variables required
% ~~~~~~~~~~~~~~~

% stochastic

% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~





%%


% Parameters to be altered
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% Model parameters(Variable parameters are to alter parameter values during
% simulation) Matrix specifies parameter values for a specified time period
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units mV
% ~~~~~~~~~~~~

% Parameters for Wendling paper 2002
% ~~~~~~~~~~~~~~~~~~~~~~~~~~
% 
AV =[5 4.5 4 3.5];               %Excitatory gain       %Normal activity A=3.25;
BV =[20 15 10 5];            %Slow inhibitory gain                   B=22;
GV =[20 15 10 5];            %Fast inhibitory gain                   G=10;

% Parameters for Wendling paper 2005
% ~~~~~~~~~~~~~~~

% AV =[3.5 4.6 7.7 8.7] ;
% BV =[13.2 20.4 4.3 11.4];
% GV= [10.76 11.48 15.1 2.1];

% Genral multiple parameter simulation
% ~~~~~~~~~~~~~~~

% AV =[3 5 5 3];               %Excitatory gain       %Normal activity A=3.25;
% BV =[10 10 10 10];            %Slow inhibitory gain                   B=22;
% GV =[10 10 10 10];

% Individual parameter simulation
% ~~~~~~~~~~~~~~~~


% Model parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units NS
% ~~~~~~~~~~~~

slope_time =2.5; % Specifies the time over which the model gain should be altered


% Solver parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

simulation_changes = length(AV); % Specify the number of times the parameters change in simulation

% Units s
% ~~~~~~~~~~~~~

simulation_time =20; %Time for simulation

% Units Hz
% ~~~~~~~~

sampling_frequency = 2048; % Sampling frequency for solutions and measurements
dt = 1/sampling_frequency; % Time step between solutions

% Multiple parameter simulation

change_A = 0;      % Change to A after solver finsihed
change_B = 0;     % Change to B after solver finsihed
change_G = 0;     % Change to G after solver finsihed
number_of_changes =0;   % Specify number of simulation to perform
for k = 1:length(AV)
    changes(:,k) = [change_A; change_B; change_G];
end
MVT = [AV; BV; GV];


%%

% Stationery Parameter defintions
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Model parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units seconds^(-1)
% ~~~~~~~~~~~~

a =100;             %Excitatory time constant
b =30;              %Slow inhibitory time constant original b=50
g =350;             %Fast inhibitory time constant g =500

tcon = [a b g];

% Units NS
% ~~~~~~~~~

Con = 135; % Connectivity constant, used to specify connectivty between neuronal types

C= [Con; 0.8*Con; 0.25*Con; 0.25*Con; 0.3*Con; 0.1*Con; 0.8*Con]; % Connectivity Constants for all populations

% Input noise limits
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units Hz
% ~~~~~~~~~~~~~

min_frequency = 30; % Minimum noise firing rate

max_frequency = 150; % Maximum noise input firing rate

frequency_limits = [min_frequency max_frequency];

% Solver Parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units NS
% ~~~~~~~~~

time = 0:dt:simulation_time;  % Time frame over which solver should solve equations

solver_time = 0:dt:(simulation_time-dt); % Specifiy time parameters for solver loop, ends at simulation_time-dt so that the last solution can be determined

normalise = round((solver_time+dt)*sampling_frequency);% Normalise time for matrix use, used in for loops

no_solutions = sampling_frequency*simulation_time+1; % Specifies the number of solutions required

param_coeff = simulation_time/(simulation_changes)*sampling_frequency; % Normalised matrix time for each parameter, in solver

slope_coeff = slope_time*sampling_frequency; % Specifies matrix indices for gain change

% Noise Parameters
% ~~~~~~~~~~~~~~~~~~~~

meanf = (min_frequency+max_frequency)/2; % Noise mean

variance = (max_frequency-min_frequency)/2; % Noise variance

std_deviation = sqrt(variance); % Noise std_deviation

% Code for model gain. Model gain is changed in a linear fashion over the
% specified time interval.
% ~~~~~~~~~~~~~~~~~~~~~~~

MVI = zeros(no_solutions,3);% Initialse initial solution matrix


for k = normalise+1                 % repeat for all time parameters used in solver
    for m = 1:simulation_changes  % Iterate through the number of changes in the simulation
        if ((k >=param_coeff*(m-1)) && (k <=param_coeff*m+1)) % Determine limits for parameters space
            MVI(k,:)= [AV(m) BV(m) GV(m)]; % Define parameters for full simulation
            if ((m>=1) && (m<=length(AV)))
                if (((k <=(param_coeff*(m-1) +slope_coeff/2)) && (k >=(param_coeff*(m-1) -slope_coeff/2)))  && (m>1)) % Detemine whther time is within parameter altering space
                    MVI(k,:) = [(AV(m)-AV(m-1))/slope_coeff*(k+slope_coeff/2-param_coeff*(m-1))+AV(m-1) ...
                        (BV(m)-BV(m-1))/slope_coeff*(k+slope_coeff/2-param_coeff*(m-1))+BV(m-1)...
                        (GV(m)-GV(m-1))/slope_coeff*(k+slope_coeff/2-param_coeff*(m-1))+GV(m-1)];
                elseif (((k <=(param_coeff*m +slope_coeff/2)) && (k >=(param_coeff*m -slope_coeff/2))) && (m<length(AV)))
                    MVI(k,:) = [(AV(m+1)-AV(m))/slope_coeff*(k+slope_coeff/2-param_coeff*(m))+AV(m) ...
                        (BV(m+1)-BV(m))/slope_coeff*(k+slope_coeff/2-param_coeff*(m))+BV(m)...
                        (GV(m+1)-GV(m))/slope_coeff*(k+slope_coeff/2-param_coeff*(m))+GV(m)];
                end
            end
        end
    end
end

MVI(1,:) = MVT(:,1); % Set intial parameters to intial values set in simulation

% Initialse all parameters for multiple simulations
% ~~~~~~~~~~~~~~~~~~~~~

for k = normalise+1
    for j = 1: (number_of_changes+1)
        MV(k,:,j) = MVI(k,:) + (changes(:,1))'*(j-1);
    end
end

% Initialise solver variables
% ~~~~~~~~~~~~~~~~

z = zeros(no_solutions,8,number_of_changes+1);% Initialise Solutions for wendling paper model, where rows ...
% indicate the solution at a particular time...
% Columns solutions for specific equations...
% matrices
% the
% solutions for particular parameter changes

normalised_gaussian_input = ones(no_solutions,number_of_changes+1)*meanf;

normalised_gaussian_inputSDE = ones(no_solutions,number_of_changes+1)*meanf;% Initialise 8th order matrix


% Determine stochastic input to the model
% ~~~~~~~~~~~~~~~~~~~~~~~


for j = 1:(number_of_changes+1)         % Iteration to change parameters in function
    
    for k = normalise+1                   % Time Iterations for solver
        
        gauss = randn(1)*std_deviation*stochastic; % Determine random fluctuations in input signal with the specified standard deviation
        
        normalised_gaussian_input(k,j) = normalised_gaussian_input(k-1,j) + gauss*sqrt(dt); % Determine value of input for all time steps
        
        normalised_gaussian_inputSDE(k,j) = normalised_gaussian_input(k-1,j) + gauss*sqrt(dt)*sampling_frequency; % Determine value of input used for calculation purposes for all time steps
        
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