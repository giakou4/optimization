clear all; close all; clc;

dir = [pwd '\PlotsThema2\']; 

syms xx yy
f = 0.5*xx^2 + 0.5*yy^2;

x0 = 8;
y0 = 3;
e = 0.01;
g = 0.1;
s = 15;
MAX_ITER = 10000;
constraints = [-20 10; -12 15];

[x, y, F] = SteepestDescentProjection(f, e, x0, y0, g, s,constraints, 1000);
PlotStem3(f,x,y,F); title(['Steepest Descent Projection'])
saveas(gcf,[dir 'SteepestDescent_Stem.png'])
PlotContour(f,x,y,F); title(['Steepest Descent Projection'])
hold on; xline(constraints(1,1)); hold on; xline(constraints(1,2)); 
hold on; yline(constraints(2,1)); hold on; yline(constraints(2,2));
saveas(gcf,[dir 'SteepestDescent_Contour.png'])

