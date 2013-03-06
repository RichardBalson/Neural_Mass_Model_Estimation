% script created by Richard Balson 06/09/2012

% description
% ~~~~~~~~~~~
% This function describes tthe calculation of expected values and covariances using sigma
% points ( Note variances that are described initailly may ned to be added
% to the variances determined using this fucntion

% last edit
% ~~~~~~~~~

% next edit
% ~~~~~~~~~

% Beginning of function
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function [ExpX ExpY PxxF PxyF PyyF] = Exp_CoV(X, Dx, Y, Dy,kappa)

if nargin == 4
    kappa =0;
end

if kappa > 0
    Weights = [kappa/(Dx+kappa) ones(1,size(X,2)-1)*1/(2*(kappa+Dx))];
    Number_sigma = 2*Dx+1;
else
    Weights = ones(1,size(X,2))*1/(2*(kappa+Dx));
    Number_sigma = 2*Dx;
end

if size(Y,1) == Dy          % Determine how Y matrix orientated
    SummY = sum(Weights'.*Y')';        % Sum components of each state
else
    SummY = sum(Weights'.*Y)';
end
WeightX = repmat(Weights,size(X,1),1);
if size(X,1) == Dx         % Determine how x matrix orientated
    SummX = sum(WeightX'.*X')';
else
    SummX = sum(WeightX'.*X)';
end

              % Calculate expected value of observation
ExpY = SummY;


            % Calculate expected value of states
    ExpX = SummX;


for i = 1:Number_sigma
    if size(X,1) == Dx          % Determine how X matrix orientated
        Px(:,i) =  X(:,i) -ExpX;
    else 
        Px(:,i) = X(i,:)' - ExpX;
    end
    if size(Y,1) == Dy          % Determine how X matrix orientated
        Py(:,i) =  Y(:,i) -ExpY;
    else 
        Py(:,i) = Y(i,:)' - ExpY;
    end
end

Px1 = WeightX.*Px;
Py1 = Weights.*Py;

PxxF = Px1*Px';
PxyF = Px1*Py';
PyyF = Py1*Py';

% if kappa > 0
% Pxx0 = kappa/(2*(Dx+kappa))*SumPxx(1,:);
% Pxy0 = kappa/(2*(Dx+kappa))*SumPxy(1,:);
% Pyy0 = kappa/(2*(Dx+kappa))*SumPyy(1,:);
% Pxx = 1/(2*(Dx+kappa))*SumPxx(2:length(SumPxx),:);
% Pxy = 1/(2*(Dx+kappa))*SumPxy(2:length(SumPxy),:);
% Pyy = 1/(2*(Dx+kappa))*SumPyy(2:length(SumPyy),:);
% PxxF = cat(1,Pxx0,Pxx);
% PyyF = cat(1,Pyy0,Pyy);
% PxyF = cat(1,Pxy0,Pxy);
% else
% PxxF = 1/(2*(Dx+kappa))*SumPxx;
% PxyF = 1/(2*(Dx+kappa))*SumPxy;
% PyyF = 1/(2*(Dx+kappa))*SumPyy;
% end

% Parameter specifiction
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% Units
% ~~~~~~~~

% Equations
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% End of function description
