% Calculate the position of a one-dimensional vehicle and plot the results
% clean up workspace and windows (for common practice)clear all 
% clears the workspace%
close all;
% close all windows
clc;
% clear the workspace screen% define step size
h = 1; % in seconds% define initial position
p0 = 1; % in meters% define length of data
N = 40;% define reference
p_star = 0;
% define the proportional gain K
K = 0.5;
% check for stability criterion 
if abs(1 - h * K) < 1  
    % check if parameters are chosen properly    
    % calculate p1, p2, p3, ... pN    
    P(1) = p0; % define initial position as a vector    
    % and time    
    T(1) = 0; % define initial time in s    
    for k = 1:N        
        v(k) = K * (p_star - P(k));        
        P(k+1) = P(k) + h * v(k); 
        % calculate p_new in m/s        
        T(k+1) = T(k) + h; 
        % calculate new time in seconds    
    end
    figure(1); % start a brand new figure for the plot using vectors
    %clf    
    plot(T,P) 
    % plot data points plus interpolation    
    hold on    
    plot(T,P,'*g') % plots data points only    
    xlabel('t [s]') % creates label for horizontal axis    
    ylabel('p [m]') % creates label for vertical axis    
    title('Position (p) vs time (t)') % creates titleelse    
else    
    DISP('Wrong choice of parameters')
end