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

function [State_std_deviation] = initial_std_deviation_calculation_WNMv1(initial_state,C,max_sig,min_sig,lower_percentage,upper_percentage,...
    sigmoid_gradient,t_state,sigmoid_center,variance_adjustment1,Ds,dt)

% Equations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
percent = 0.1;
percentage_change = percent*sqrt(variance_adjustment1);
variance_adjustment = 1;
sigmoid_range = max_sig-min_sig;
bottom_limit = sigmoid_range*lower_percentage; % 2% limit
top_limit = sigmoid_range*upper_percentage; % 98% limit


% Equation to determine voltage input for firing rate bounds
 %firing rate = sigmoid_range/(1+exp(sigmoid_gradient*(sigmoid_center-v)));
 % let m = firing rate/sigmoid_range
 % m = 1/(1+exp(sigmoid_gradient*(sigmoid_center-v))
% m(1+exp(..)) = 1;
%     exp(..) = (1-m)/m
%     sigmoid_gradient*(sigmoid_center-v) = ln((1-m)/m)
%     sigmoid_gradient*sigmoid_center - ln((1-m)/m) = sigmoid_gradient*v
%     v = (sigmoid_gradient*sigmoid_center - ln((1-m)/m))/sigmoid_gradient

range_coeff = bottom_limit/sigmoid_range;
bottom_voltage_limit = (sigmoid_gradient*sigmoid_center- log((1-range_coeff)/range_coeff))/sigmoid_gradient; % Determine bottom voltage limit
range_coeff = top_limit/sigmoid_range; % Only the firing rate changes
top_voltage_limit = (sigmoid_gradient*sigmoid_center- log((1-range_coeff)/range_coeff))/sigmoid_gradient; % Determine top voltage limit

% Determine which limit to use for each stateand state standard deviations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



% Determine bounds for state 1

lowS1(1) = bottom_voltage_limit/C(3);
lowS1(2) = bottom_voltage_limit/C(1);
highS1(1) = top_voltage_limit/C(3);
highS1(2) = top_voltage_limit/C(1);

max_range_state(1) = initial_state(1)-lowS1(1); % Determine bottom range for state 1 state value for bottom voltage limit : state1 = voltage/(C3 or C1)
max_range_state(2) = highS1(1) -initial_state(1);
max_range_state(3) = initial_state(1)-lowS1(2);
max_range_state(4) = highS1(2) -initial_state(1);

max_rangeF(1) = (max_range_state(1)+max_range_state(3))/2;
max_rangeF(2) = (max_range_state(2)+max_range_state(4))/2;

State_std_deviation(:,1) = ones(8,1)*max(max_rangeF)/t_state*variance_adjustment;

% Determine bounds for state2

lowS2 = bottom_voltage_limit+C(4)*initial_state(3)+initial_state(4);
highS2 = top_voltage_limit+C(4)*initial_state(3)+initial_state(4);
max_range_state(1) = initial_state(2)-lowS2; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = highS2-initial_state(2);

State_std_deviation(:,2) = ones(8,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for state 3

max_range_state(1) = initial_state(3) - (bottom_voltage_limit-C(5)*initial_state(1))/C(6);
max_range_state(2) = (top_voltage_limit-C(5)*initial_state(1))/C(6)-initial_state(3);

State_std_deviation(:,3) = ones(8,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for state4

lowS4 = bottom_voltage_limit+C(4)*initial_state(3)-initial_state(2);
highS4 = top_voltage_limit+C(4)*initial_state(3)-initial_state(2);
max_range_state(1) = initial_state(4)-lowS4; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = highS4-initial_state(4);

State_std_deviation(:,4) = ones(Ds,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for State 5

low_bound_derivative = percentage_change*bottom_voltage_limit;
top_bound_derivative = percentage_change*top_voltage_limit;

max_range_state(1) = initial_state(5)-low_bound_derivative; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = top_bound_derivative-initial_state(5);

State_std_deviation(:,5) = ones(Ds,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for State 6

max_range_state(1) = initial_state(6)-low_bound_derivative; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = top_bound_derivative-initial_state(6);

State_std_deviation(:,6) = ones(Ds,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for State 7

max_range_state(1) = initial_state(7)-low_bound_derivative; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = top_bound_derivative-initial_state(7);

State_std_deviation(:,7) = ones(Ds,1)*max(max_range_state)/t_state*variance_adjustment;

% Determine bounds for State 8

max_range_state(1) = initial_state(8)-low_bound_derivative; % sigmoid voltage =  State2-C(4)*State3-State4; intial_state_guess3 = State2-State4
max_range_state(2) = top_bound_derivative-initial_state(8);

State_std_deviation(:,8) = ones(Ds,1)*max(max_range_state)/t_state*variance_adjustment;


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% End of function description

