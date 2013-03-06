% script created by Richard Balson 28/10/2012

% description
% ~~~~~~~~~~~
% This function describes thecaluclation of the mean values for the
% Wendling neural mass model

% last edit
% ~~~~~~~~~

% next edit
% ~~~~~~~~~

% Beginning of function
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [initial_state] = initial_mean_calculation_WNM(C,sigmoid_center,percentage,dt)

% Equations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



initial_state_guess(1)= sigmoid_center/C(3) ; % Set state 1 to be in the center of the sigmoid: sigmoid voltage = C(3)*State1;
initial_state_guess(2) =sigmoid_center/C(1); % Set state 1 to be in the center of the sigmoid: sigmoid voltage = C(1)*State1;
initial_state(1) = (initial_state_guess(1) + initial_state_guess(2))/2; % Due to their being two center values for the sigmoid in state 1 set it to the averge of the two.
initial_state(3) = (sigmoid_center-C(5)*initial_state(1))/C(6); % Set state 3 to be in the center of the sigmoid: sigmoid voltage = C(5)*State1-C(6)*State3;
initial_state_guess(3) = sigmoid_center+C(4)*initial_state(3); % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
initial_state(2) = initial_state(1)+1; %Assume voltage output of excitatory cells and input is higher than output of pyramidal neurons
initial_state(4) = initial_state(2)-initial_state_guess(3); %intial_state_guess3 = State2-State4

% Estimate initial derivative of voltage for each state
% ~~~~~~~~~~~~~~~~~~~

% Assume states 1-4 alter by 10 percent in first time step

initial_state(5) = percentage*initial_state(1)/dt; % Assume linear gradient between solutions. Therefore state5 = (state1-0.9state1)/dt
initial_state(6) = percentage*initial_state(2)/dt; % state6 = (state2-0.9state2)/dt
initial_state(7) = percentage*initial_state(3)/dt; % state7 = (state3-0.9state3)/dt
initial_state(8) = percentage*initial_state(4)/dt; % state8 = (state4-0.9state4)/dt




% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% End of function description