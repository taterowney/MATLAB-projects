clear;
close all;
clf;

% define variables

system_speed = 1;
system_angle = 90; % in degrees
system_position = [0, 0];
line_angle = 90; % in degrees 
gain = 0.5; % absolute unit
tolerance_range = 1;

% if the object is outside of tolerance range of the target line, then
% steer (at gain value) towards the target

while 1
    if 
end

% if the object is within tolerance range of the target line, then
% straighten along the axis of the line

function y = potential_function(x1, x2)
    if x2 > 0
        y = x1^2 + 1/x2^2;
    elseif x2 < 0
        y = x1^2 + x2^2;
    end
end

function x1_out, x2_out = angle_to_pos(angle);
    x1_out = system_position(1) + sine(
end