% Minimize f(x,y) = (x^3)*exp(-x^2-y^4) using Steepest Descent method with
% the following initial points: 
% 1. (0,0)
% 2. (-1,-1)
% 3. (1,1) 
% Step gamma is chosen according to the following 3 ways: 
% 1. g = ct, 
% 2. g = argmin of f[x(k)+g(k)*d(k)]
% 3. Armijo

clear all; close all; clc;

dir = [pwd '\PlotsSteepestDescent\']; 

syms xx yy
f = (xx^3)*exp(-xx^2-yy^4);

x0 = [0,-1,1];
y0 = [0,-1,1];
e = 0.0001;

for i=1:length(x0)
    
    iter = [];
    for g=0.1:0.2:2
            [x, y, F] = SteepestDescent(f, 0.001, x0(i), y0(i), 1, g, 1000);
            disp(['Number of Iteration for Algorithm #1: ',num2str(length(x))]);
            iter = [iter, length(x)];
    end
    plot(0.1:0.2:2,iter,'o--'); title('Algoritm #1 Iterations'); xlabel('g'); ylabel('# of iterations'); ylim([0,1100])
    saveas(gcf,[dir 'Algorithm_1_Point_',num2str(i),'_Iterations_VS_Gamma.png'])

    g = 0.1; % change manually?
    [x, y, F] = SteepestDescent(f, e, x0(i), y0(i), 1, g, inf);
    disp(['Number of Iteration for Algorithm #1: ',num2str(length(x))]);
    PlotStem3(f,x,y,F); title(['Steepest Descent Algorithm #1 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_1_Point_',num2str(i),'_Stem.png'])
    PlotContour(f,x,y,F); title(['Steepest Descent Algorithm #1 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_1_Point_',num2str(i),'_Contour.png'])

    [x, y, F] = SteepestDescent(f, e, x0(i), y0(i), 2, NaN, inf);
    disp(['Number of Iteration for Algorithm #2: ',num2str(length(x))]);
    PlotStem3(f,x,y,F); title(['Steepest Descent Algorithm #2 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_2_Point_',num2str(i),'_Stem.png'])
    PlotContour(f,x,y,F); title(['Steepest Descent Algorithm #2 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_2_Point_',num2str(i),'_Contour.png'])

    [x, y, F] = SteepestDescent(f, e, x0(i), y0(i), 3, NaN, inf);
    disp(['Number of Iteration for Algorithm #3: ',num2str(length(x))]);
    PlotStem3(f,x,y,F); title(['Steepest Descent Algorithm #3 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_3_Point_',num2str(i),'_Stem.png'])
    PlotContour(f,x,y,F); title(['Steepest Descent Algorithm #3 Point #',num2str(i)])
    saveas(gcf,[dir 'Algorithm_3_Point_',num2str(i),'_Contour.png'])
    
end