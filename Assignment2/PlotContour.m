function [] = PlotContour(f,x,y,F)
% function [] = myPlot(x,y,F)
% PLOTCONTOUR plots the function f along with the (x,y)
% values found during iterations in a contour plot. Also denotes the start
% point and end point with arrows. For arrows, a function was downloaded
% from maths exchange (arrow_er).
% Inputs:
% f     : 2-D function f(xx,yy)
% x     : x-coordinate over iterations
% y     : y-coordinate over iterations
% F     : value of f in (x,y) over iterations

syms xx yy
[X,Y] = meshgrid(-3:0.5:3);
Z = [];
for xxx = 1:size(X,1)
    for yyy =1:size(Y,1)
        Z(xxx,yyy) = double(subs(f,{xx,yy},[X(xxx,yyy),Y(xxx,yyy)]));
    end
end

figure
grid on
contour(X,Y,Z)
hold on
plot(x,y,'-o','Color','black')
xlabel('x'); ylabel('y');
Arrow(x(1),y(1),'Start Point',0.07,225)
Arrow(x(end),y(end),'End Point',0.07,225-180)
end

