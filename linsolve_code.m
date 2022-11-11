% this can be defined to include any amount of variables necessary to fit
% the equation
syms a b;
%our actual equations. must be of this form, and make a square matrix when
%put together
e1 = 2*a + 3*b == 7; 
e2 = 7*a + 20*b == 12;
[val1, val2] = equationsToMatrix([e1, e2], [a, b]);
linsolve(val1, val2)

