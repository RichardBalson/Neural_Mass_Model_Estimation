% script created by Richard Balson 25/03/2013

% description
% ~~~~~~~~~~~
% Calculate the mean for all fast states

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script

% ~~~~~~~~~~~~~~~~~~~~~

gmax = 5;
nm = [1 C(2) C(4) C(7)];

mean_state(1) = 0.25*(Max(1)-Min(1))*gmax*nm(1);
mean_state(2) = 0.25*(Max(1)-Min(1))*gmax*nm(2);
mean_state(3) = 0.25*(Max(2)-Min(2))*gmax*nm(3);
mean_state(4) = 0.25*(Max(3)-Min(3))*gmax*nm(4);
mean_state(5:8) = zeros(1,4);