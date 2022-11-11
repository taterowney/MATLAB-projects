clear;
close all;
clf;


p_k = 1;
h = 1;
gain1 = 2;
%gain2 = -0.1;
%gain3 = 0;

p_star = 4;

for k = 1:20
    v = (p_star - p_k) * gain1;
    p_k1 = p_k + h*v;
    plot (k, p_k1, '.r', 'MarkerSize', 10)
    hold ON
    p_k = p_k1;
end

%p_k = 1;
%h = 1;

%for k = 1:100
%    p_k1 = p_k + h*(p_k*gain2);
%    plot (k, p_k1, '.g', 'MarkerSize', 10)
%    hold ON
%    p_k = p_k1;
%end

p_k = -3;
h = 1;

%for k = 1:100
%    p_k1 = p_k + h*(p_k*gain3);
%    plot (k, p_k1, '.b', 'MarkerSize', 10)
%    hold ON
%    p_k = p_k1;
%end

%legend('0.01', '-0.1', '0');

ylim([-5, 5]);
xlabel('Time (s)');
ylabel('Position (m)');
title('Position vs. Time (incremental)');
grid ON;