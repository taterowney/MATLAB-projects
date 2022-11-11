clear;
close all;
clf;

v_x = 1;
v_y = 1;

graph_min = 0;
graph_max = 10;

%p_zeros = [7, 3; 1, 2; 4, 9; 10, 10];
p_zero = [10, 4];
target_point = [5, 5];

colors = ['.r', '.g', '.b', '.c'];



current_pos = p_zero;
reached_x = 0;
reached_y = 0;
color = '.r';
plot(current_pos(1), current_pos(2), color, 'MarkerSize', 10);
hold ON;
while reached_x == 0 || reached_y == 0
    if current_pos(1) > target_point(1)
        current_pos(1) = current_pos(1) - v_x;
    elseif current_pos(1) < target_point(1)
        current_pos(1) = current_pos(1) + v_x;
    else
        reached_x = 1;
    end
    
    if current_pos(2) > target_point(2)
        current_pos(2) = current_pos(2) - v_y;
    elseif current_pos(2) < target_point(2)
        current_pos(2) = current_pos(2) + v_y;
    else
        reached_y = 1;
    end
    plot(current_pos(1),current_pos(2), color, 'MarkerSize', 10);
end


xlim([graph_min, graph_max]);
ylim([graph_min, graph_max]);
xlabel('Position (m)');
ylabel('Position (m)');
title('Lookup-Table control in 2d');
grid ON;