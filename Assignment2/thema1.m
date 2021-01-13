% Plot function f(x,y) = (x^3)*exp(-x^2-y^4) and save result
syms x y
f = (x^3)*exp(-x^2-y^4);

figure
title('Function f(x,y)');
fsurf(f)
xlabel('x'); 
ylabel('y');
zlabel('f(x,y)');
saveas(gcf,[pwd '\function.png'])

clear all; clc;
% min at (x,y) = (1.22,0)
% max at (x,y) = (-1.22,0)