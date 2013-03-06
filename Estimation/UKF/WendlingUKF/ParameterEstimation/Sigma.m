% script created by Richard Balson 06/09/2012

% description
% ~~~~~~~~~~~
% This function describes the calculation for sigma points

% last edit
% ~~~~~~~~~

% next edit
% ~~~~~~~~~

% Beginning of function
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [Sigma] = Sigma(Dx,Pxx,X)

symetric = (Pxx+Pxx')/2; 
sigma_root = chol(Dx*symetric)'; % Define sigma points variation from the mean value
%Sigma points calculation
 Sigma = X*ones(1,2*Dx) + [sigma_root, -sigma_root];
 
end

% Parameter specifiction
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% Units
% ~~~~~~~~

% Equations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% End of function description
