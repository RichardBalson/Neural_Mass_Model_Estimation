% script created by Richard Balson 28/01/2013

% description
% ~~~~~~~~~~~
% Print setting for EEG

% last edit
% ~~~~~~~~~

% Code structure edited, static and dynamic variables created

% next edit
% ~~~~~~~~~

% adjust standard deviation on state covariance matrix, may need to reduce
% sigmoid range in order to allow for computation to be correct, standard
% deviation currently using dt multiplier, develop method to calculate
% standard deviation for input and model parameters, use parameters from
% simulation, dont redefine parameters if they are already defined.

% Beginning of script
% ~~~~~~~~~~~~~~~~~~~~~


scale = 14.5;
label_fontsize = 10;            % point
tick_fontsize = 8;              % point
fig_left_pos = 5;               % cms
fig_bottom_pos = 5;             % cms
fig_width = scale*1;                % cms
fig_height = 3;                 % cms
fig_dirname = 'c:\';              % default directory for figure files
fig_name = 'Comparison of estimated and simulated signal.fig';
fig_dirandname = [fig_dirname fig_name];
legend_fontsize = 8;
font_type = 'Arial';