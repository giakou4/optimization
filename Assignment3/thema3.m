clear all; close all; clc;

dir = [pwd '\PlotsThema3\']; 

syms xx yy
f = 0.5*xx^2 + 0.5*yy^2;

x0 = -5;
y0 = 7;
e = 0.02;
g = 0.3;
s = 20;
MAX_ITER = 10000;
constraints = [-20 10; -12 15];

[x, y, F] = SteepestDescentProjection(f, e, x0, y0, g, s,constraints, 1000);
PlotStem3(f,x,y,F); title(['Steepest Descent Projection'])
saveas(gcf,[dir 'SteepestDescent_Stem.png'])
PlotContour(f,x,y,F); title(['Steepest Descent Projection'])
hold on; xline(constraints(1,1)); hold on; xline(constraints(1,2)); 
hold on; yline(constraints(2,1)); hold on; yline(constraints(2,2));
saveas(gcf,[dir 'SteepestDescent_Contour.png'])

s = 1;
[x, y, F] = SteepestDescentProjection(f, e, x0, y0, g, s,constraints, 1000);
PlotStem3(f,x,y,F); title(['Steepest Descent Projection'])
saveas(gcf,[dir 'SteepestDescent_Stem_2.png'])
PlotContour(f,x,y,F); title(['Steepest Descent Projection'])
hold on; xline(constraints(1,1)); hold on; xline(constraints(1,2)); 
hold on; yline(constraints(2,1)); hold on; yline(constraints(2,2));
saveas(gcf,[dir 'SteepestDescent_Contour_2.png'])
