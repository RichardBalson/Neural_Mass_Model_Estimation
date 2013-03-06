% Stationery Parameter defintions
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Model parameters
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units seconds^(-1)
% ~~~~~~~~~~~~

a =100;             %Excitatory time constant
b =30;              %Slow inhibitory time constant original b=50
g =350;             %Fast inhibitory time constant g =500

tcon = [a b g]; % Specify reciprocal of the time constants for simulation

for k = 1:length(AV)
    changes(:,k) = [change_A; change_B; change_G];
end
MVT = [AV; BV; GV]; %Specifiy initial parameter values for simulations

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

dt = 1/sampling_frequency; % Time step between solutions

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
if (Input_mean_variation ==0) % Constant input mean
meanf = (min_frequency+max_frequency)/2; % Input mean
elseif (Input_mean_variation ==1) % Mean drawn from a uniform distribution
    meanf = min_frequency + (max_frequency-min_frequency)*rand(1);
else % Mean drawn from a Gaussin distribution
    meanf = (min_frequency+max_frequency)/2 + (max_frequency-min_frequency)/(2*number_of_sigma_input)*randn(1);
end
std_deviation = max((max_frequency-meanf)/(number_of_sigma_input), (meanf-min_frequency)/(number_of_sigma_input)); % Input standard deviation
 % Noise std_deviation

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