function [] = PlotStem3(f,x,y,F)
% function [] = PlotStem3(x,y,F)
% PLOTSTEM3 plots the function f along with the (x,y)
% values found during iterations in a 3D stem.
% Inputs:
% f     : 2-D function f(xx,yy)
% x     : x-coordinate over iterations
% y     : y-coordinate over iterations
% F     : value of f in (x,y) over iterations

syms xx yy
k = 1;
X = []; Y = []; Z = [];
step = 1;
for xxx=-25:step:25
    for yyy=-3:step:3
        X(k)=xxx;
        Y(k)=yyy;
        Z(k) = double(subs(f,{xx,yy},[xxx,yyy]));
        k = k + 1;
    end
end

figure
grid on
stem3(X,Y,Z)
hold on
plot3(x,y,F,'LineWidth',5,'Marker','o','MarkerSize',4,'Color','red')
xlabel('x'); ylabel('y'); zlabel('f(x,y)')
text(x(1),y(1),F(1),'Start Point')
text(x(end),y(end),F(end),'End Point')


end

