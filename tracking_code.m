% Clear the workspace
clc
clear all
close all

% Initialize Communication with CopelliaSim
[ret_status, sim, clientID] = initializeComm();

% Make sure that initialization is succesful
if (ret_status == 0)
    % Get the reference object for the green sphere (target) from the copelliaSim
    [~, target] = getObjectReference(sim, clientID, 'Quadricopter_target');
    
    
    % Get the reference object for the ground rover from the copelliaSim
    [~, ground_rover] = getObjectReference(sim, clientID, 'Pioneer_p3dx');
    
    % Get the position of the green sphere (target) from the copelliaSim
    [~, position] = getObjectPosition(sim, clientID, target, 1);
    
    % Get the position of the ground rover the copelliaSim
    
    [~, position_rover] = getObjectPosition(sim, clientID, ground_rover, 1);
    
    % Initialize the position for tracking
    pos_x = position(1);
    pos_y = position(2);
    i = 0;
    k = 0;
    while(sim.simxGetConnectionId(clientID) ~= -1)
        % Continuously obtain the position of the ground rover
        [returnCode2, position_rover] = getObjectPosition(sim, clientID, ground_rover, 0);
        
        
        %% Various options of moving the target
        % Go North and South
        % position = [ 0.2 * (-1)^i, 0, 1];
        % Go East and West
        % position =  [0, 0.2 * (-1)^i, 1];
        % Go Up and Down
        % position =  [0, 0, 1 + 0.2 * (-1)^i];
        % Go in the circle
        % position = [ 0.50*cos(k)-0.50, 0.50*sin(k), 1 ];
        
        % Follow the ground rover at height = 1 m
        
        % Instant tracking:
        pos_x = position_rover(1);
        pos_y = position_rover(2);
        
        % Fast tracking
        pos_x = 0.8*position_rover(1) + 0.2*pos_x(1);
        pos_y = 0.8*position_rover(2) + 0.2*pos_y(1);
        
        % Slow tracking
        pos_x = 0.2*position_rover(1) + 0.8*pos_x(1);
        pos_y = 0.2*position_rover(2) + 0.8*pos_y(1);
        
        % Adaptive tracking
        weight = k; % for adaptive following
        
        % if k is too large -- higher weight to the rover's position
        % if k is too small -- higher weight to the original position
        
        pos_x = k/(1+k)*position_rover(1) + 1/(1+k)*pos_x(1);
        pos_y = k/(1+k)*position_rover(2) + 1/(1+k)*pos_y(1);
        
        
        position = [pos_x pos_y 1];
        
        % we increase k so that tracking becomes better
        k = k + 0.2;
        %%
        % Set the position of the target in CoppeliaSim
        [returnCode] = setObjectPosition(sim, clientID, target, position);
        
        % Make sure to add some delay...
        pause(0.5) % This delay will be computer dependent
        i = i + 1;
        
    end
    
    % Kill the connection to CopelliaSim
    uninitializeComm(sim, clientID)
    
else
    disp('Unable to connect to CopelliaSim')
end

