% script created by Richard Balson 09/01/2013

% description
% ~~~~~~~~~~~
% this script determines numerous error results from UKF estimation of
% states and parameters

% last edit
% ~~~~~~~~~


% next edit
% ~~~~~~~~~

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~

% Determine mean square error for states
% ~~~~~~~~~~~~~~~~~~

Sample_inverse = 1/limit; % Used to normalise mean squared error

err = zeros(Dx,1); % Initlaise mean square error
Nerr = zeros(Dp+Dk,1); %  Initialse normailsed error
Nerri = zeros(Dp+Dk,1); % Initialise normalised error for initial sum

zoomend = tstart+zoom;
t = linspace(0,dt*length(check),length(check));
tz = linspace(tstart,zoomend,zoom*frequency+1);

initialz = tstart*frequency+1;
endz = zoomend*frequency+1;

initialRz = round((EstStart+tstart)*frequency)+1;
endRz =  round((EstStart+zoomend)*frequency)+1;

for k = 1:Ds
    err(k) = Sample_inverse*(z(initialRz:endRz,k)' - X(k,initialz:endz))*(z(initialRz:endRz,k)' - X(k,initialz:endz))';
end

% Determine mean square error for estimated model output
% ~~~~~~~~~~~~~~~

Oerr = Sample_inverse*(Y' - ExpY(1,:))*(Y' - ExpY(1,:))';

% Determine mean square error for parameter estimates

if (Dp)>0
    for k = 1:(Dp)
        err(Ds+k) = Sample_inverse*(MVI(initialz:endz,k)' - X(Ds+Dk+k,initialz:endz))*(MVI(initialz:endz,k)' - X(Ds+Dk+k,initialz:endz))';
    end
end

if Dk >0
    err(Ds+Dp+1) = Sample_inverse*(normalised_gaussian_input(initialRz:endRz)' - X(Ds+1,initialz:endz))*(normalised_gaussian_input(initialRz:endRz)' - X(Ds+1,initialz:endz))';
end

% Determine normalised error

if (Dp)>0
    for k = 1:(Dp)
        for l = initialz:endz
            Nerri(k) = Nerri(k)+(MVI(l,k) - X(Ds+Dk+k,l))^2/MVI(l,k);
        end
        Nerr(k) = Sample_inverse*Nerri(k);
    end
end

if Dk >0
    for l = initialz:endz
        Nerri(Dp+1) = Nerri(Dp+1)+(normalised_gaussian_input(l)-X(Ds+1,l))^2/normalised_gaussian_input(l);
    end
    Nerr(Dp+1) = Sample_inverse*Nerri(Dp+1);
end


