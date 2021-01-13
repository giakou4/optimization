% Minimize f(x,y) = 0.5*x^2 + 0.5*y^2 using Steepest Descent method with
% a random initial point different than (0,0)
% Step gamma is chosen as given
% g = 0.1
% g = 1
% g = 2
% g = 10
% Accuracy is e = 0.01

clear all; close all; clc;

dir = [pwd '\PlotsThema1\']; 

syms xx yy
f = 0.5*xx^2 + 0.5*yy^2;

x0 = 1;
y0 = 1;
e = 0.01;
g = [0.1, 1, 2, 10];
MAX_ITER = 10000;

for i=1:length(g)
    [x, y, F] = SteepestDescent(f, e, x0, y0, g(i), MAX_ITER);
    disp(['Number of Iteration: ',num2str(length(x))]);
    if i == 4  % diverges to infinity, cannot plot 
        x = x(1:10); y = y(1:10); F = F(1:10);
    end
    PlotStem3(f,x,y,F); title(['Steepest Descent \gamma = ',num2str(g(i))])
    saveas(gcf,[dir 'SteepestDescent_g_',num2str(g(i)),'_Stem.png'])
    PlotContour(f,x,y,F); title(['Steepest Descent \gamma = ',num2str(g(i))])
    saveas(gcf,[dir 'SteepestDescent_g_',num2str(g(i)),'_Contour.png'])
end 
