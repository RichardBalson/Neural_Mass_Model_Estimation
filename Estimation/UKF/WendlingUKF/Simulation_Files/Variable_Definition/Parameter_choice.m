% script created by Richard Balson 21/02/2013

% description
% ~~~~~~~~~~~
% Decide on which parameters to use for simulation purposes

% last edit
% ~~~~~~~~~

%

% Variables required
% ~~~~~~~~~~~~~~~

% Parameter_index - Specify choice of parameters

% next edit
% ~~~~~~~~~

function [AV BV GV] = Parameter_choice(Parameter_index,Max_parameters)

%%

% Model parameters(Variable parameters are to alter parameter values during
% simulation) Matrix specifies parameter values for a specified time period
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Units mV
% ~~~~~~~~~~~~

% Parameters for Wendling paper 2002
% ~~~~~~~~~~~~~~~~~~~~~~~~~~

if (Parameter_index ==1)
% 
AV =[5 5 5 5];               %Excitatory gain       %Normal activity A=3.25;
BV =[40 27 8 17];            %Slow inhibitory gain                   B=22;
GV =[20 20 20 5];            %Fast inhibitory gain                   G=10;

% Parameters for Wendling paper 2005
% ~~~~~~~~~~~~~~~

elseif (Parameter_index ==2)
AV =[3.5 4.6 7.7 8.7] ;
BV =[13.2 20.4 4.3 11.4];
GV= [10.76 11.48 15.1 2.1];

% Genral multiple parameter simulation
% ~~~~~~~~~~~~~~~

elseif (Parameter_index ==3)
AV =[3 5 5 3];               %Excitatory gain       %Normal activity A=3.25;
BV =[10 10 10 10];            %Slow inhibitory gain                   B=22;
GV =[10 10 10 10];

% Individual parameter simulation
% ~~~~~~~~~~~~~~~~

elseif (Parameter_index ==4)
AV = 5;
BV = 20;
GV = 20;

% Randon Parameter simulation

elseif (Parameter_index ==5)
 AV = 3 + 4*rand(1);
BV = 40*rand(1);
GV = 40*rand(1);   
    
else
Parameter_number = 1+round(Max_parameters*rand(1))
AV = 3 + 4*rand(1,Parameter_number);
BV = 40*rand(1,Parameter_number);
GV = 40*rand(1,Parameter_number);
end