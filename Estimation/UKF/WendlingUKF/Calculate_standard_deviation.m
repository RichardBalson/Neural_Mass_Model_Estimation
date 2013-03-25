% script created by Richard Balson 25/03/2013

% description
% ~~~~~~~~~~~
% Calculate the standard deviation for all fast states

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script

% ~~~~~~~~~~~~~~~~~~~~~

State_std_deviation(1:4) = mean_state(1:4)^2;
bound(1) = 1/tcon(1)*exp(-2)*nm(1)*gmax*Max(1);
for k =1:3
    bound(k+1) = 1/tcon(k)*exp(-2)*nm(k+1)*gmax*Max(k);
end
State_std_deviation(5:8) = bound(1:4)^2;