vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
vrep.simxFinish(-1); % just in case, close all opened connections

clientID=vrep.simxStart('127.0.0.1',20001,true,true,5000,5);

targeting = 0; 
avoidance = 1;

k = 0.975; % gain

danger_zone = 0.5;
safe_zone = 1.5*danger_zone;


if (clientID >= -1)
    disp('connected')
    
    
    %body
    [ret, move_target] = vrep.simxGetObjectHandle(clientID, 'Quadricopter_target', vrep.simx_opmode_blocking);
    [~, quadricopter] = vrep.simxGetObjectHandle(clientID, 'Quadricopter', vrep.simx_opmode_blocking);
    [~, target] = vrep.simxGetObjectHandle(clientID, 'Target', vrep.simx_opmode_blocking);
    [~, obstacle] = vrep.simxGetObjectHandle(clientID, 'Obstacle', vrep.simx_opmode_blocking);
    mode = targeting;
    
    pause('on')
    while (ret == vrep.simx_return_ok)
        [ret, move_target] = vrep.simxGetObjectHandle(clientID, 'Quadricopter_target', vrep.simx_opmode_blocking);
        [~, quadricopter] = vrep.simxGetObjectHandle(clientID, 'Quadricopter', vrep.simx_opmode_blocking);
        [~,position] = vrep.simxGetObjectPosition(clientID, quadricopter, target, vrep.simx_opmode_oneshot_wait);
        [~,obstacle_position] = vrep.simxGetObjectPosition(clientID, obstacle, target, vrep.simx_opmode_oneshot_wait);
        x = position(1);
        y = position(2);
        if mode == targeting
            new_x = k * x;
            new_y = k * y;
            if mydistance(new_x, new_y, obstacle_position(1), obstacle_position(2)) <= danger_zone
                mode = avoidance;
                delta_x = -(new_x - x);
                delta_y = new_y - y;
            else
                target_array = [new_x, new_y, 0.000];
                [~] = vrep.simxSetObjectPosition(clientID, move_target, target, target_array, vrep.simx_opmode_oneshot);
            end
        end
        if mode == avoidance
            new_x = (delta_x + x);
            new_y = (delta_y + y);
            away_from_obstacle = [new_x new_y 0];
            [~] = vrep.simxSetObjectPosition(clientID, move_target, target, away_from_obstacle, vrep.simx_opmode_oneshot);
            if mydistance(new_x, new_y, obstacle_position(1), obstacle_position(2)) >= safe_zone
                mode = targeting;
            end
        end
        pause(0.05)
    end
    
    vrep.simxFinish(-1); % just in case, close all opened connections
    
else
    disp("couldn't connect")
end

vrep.delete(); % call the destructor!


function z = potential_function(x, y)
    z =x^2 + y^2;
end

function d = mydistance(px,py,px_star,py_star)
% calculate the disctance between px,py and px_star,py_star
d = sqrt((px-px_star)^2+(py-py_star)^2);
end