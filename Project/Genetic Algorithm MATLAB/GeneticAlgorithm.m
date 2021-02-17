close all; clear all; clc
dir = [pwd '\Report\'];
if ~exist(dir,'dir' )
    mkdir('Report')
end
%% Genetic Algorithm
gaoptions = optimoptions('ga','PlotFcn',{@gaplotbestf},...
    'PopulationSize',200,'MaxGenerations',50,...
    'MaxStallGenerations',inf,'FunctionTolerance',0);
lb = [0 0 0 0 0 0];
ub = [100 100 10 10 100 100];
[x, fval, ~, ~, population]=ga(@(x)FitnessFunction(x), 6, [], [], [], [], lb, ub , [], gaoptions);
clc;
disp('Optimal values of gains:');
disp(x');
%% Check results
T = 20;
yd1 = @(t) 90*pi/180 + (30*pi/180)*cos(t);
yd2 = @(t) 90*pi/180 + (30*pi/180)*sin(t);
kp1 = x(1); kp2 = x(2); ki1 = x(3); ki2 = x(4);  kd1 = x(5); kd2 = x(6);
[x,t,u] = simclosedloop(kp1,kp2,ki1,ki2,kd1,kd2,T);
x1 = x(:,1); x2 = x(:,2); x3 = x(:,3); x4 = x(:,4);
u1 = u(:,1); u2 = u(:,2);
y1 = x1; y2 = x3;
saveas(gcf,[dir 'ga.png'])
figure
plot(y1); hold on; plot(yd1(t)); legend('Plant Output','Desired Output');
title('Output y_1'); saveas(gcf,[dir 'y1.png'])
figure
plot(y2); hold on; plot(yd2(t)); legend('Plant Output','Desired Output');
title('Output y_2'); saveas(gcf,[dir 'y2.png'])