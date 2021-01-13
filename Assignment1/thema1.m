%% Thema 1
% Bisection method
% 1) Call method for fixed tolerance and various values of distances from
% bisector and plot the number of calls to the function vs distance from 
% bisector.
% 2) Call method for fixed distances from bisector and various values of
% tolerance and plot the number of calls to the function vs tolerance.
% 3) Solve the minimization problem for some values of tolerance and plot 
% the intervals over iterations.
clear all; close all; clc
dir = [pwd '\PlotsThema1\']; 
%% Functions 2 Test
syms x
f1 = (x-2)^2 - sin(x+3);
f2 = exp(-5*x) + (x+2)*cos(0.5*x)^2;
f3 = (x^2)*sin(x+2) - (x+1)^2;
a0 = 2;
b0 = 5;
%% Tolerance = ct
l = 0.01;
e_arr = linspace(0.001,0.004,20);
f1_calls = [];
f2_calls = [];
f3_calls = [];
for i = 1:length(e_arr)
    e = e_arr(i);
    disp(['Iteration (Tolerance=ct) No. ',num2str(i)]);
    [~,~,calls] = myBisection(f1,a0,b0,e,l,inf);
    f1_calls = [f1_calls calls];
    
    [~,~,calls] = myBisection(f2,a0,b0,e,l,inf);
    f2_calls = [f2_calls calls];
    
    [~,~,calls] = myBisection(f3,a0,b0,e,l,inf);
    f3_calls = [f3_calls calls];
end

figure(1)
subplot(3,1,1)
plot(e_arr, f1_calls); xlabel('Distance from Bisector'); ylabel('# of Iteration');
legend('Calls of f_1(x)');
subplot(3,1,2)
plot(e_arr, f2_calls); xlabel('Distance from Bisector'); ylabel('# of Iteration');
legend('Calls of f_2(x)');
subplot(3,1,3)
plot(e_arr, f3_calls); xlabel('Distance from Bisector'); ylabel('# of Iteration');
legend('Calls of f_3(x)');
suptitle('Bisection Method (Tolerance=ct)')
saveas(gcf,[dir 'ToleranceFixed.png'])
%% Distance from Bisector = ct
e = 0.001;
l_arr = linspace(0.01,0.1,20);
f1_calls = [];
f2_calls = [];
f3_calls = [];
for i = 1:length(l_arr)
    l = l_arr(i);
    disp(['Iteration (Distance from bisector=ct) No. ',num2str(i)]);
    [~,~,calls] = myBisection(f1,a0,b0,e,l,inf);
    f1_calls = [f1_calls calls];
    
    [~,~,calls] = myBisection(f2,a0,b0,e,l,inf);
    f2_calls = [f2_calls calls];
    
    [~,~,calls] = myBisection(f3,a0,b0,e,l,inf);;
    f3_calls = [f3_calls calls];
end

figure(2)
subplot(3,1,1)
plot(l_arr, f1_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_1(x)');
subplot(3,1,2)
plot(l_arr, f2_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_2(x)');;
subplot(3,1,3)
plot(l_arr, f3_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_3(x)');
suptitle('Bisection Method (Distance from Bisector=ct)')
saveas(gcf,[dir 'DistanceFromBisectorFixed.png'])
%% [ak,bk] from values of Tolerance l=[0.01,0.1,0.3] and e=0.001
e = 0.001;
l_arr = [0.01 0.1 0.3];
for i = 1:length(l_arr)
    l = l_arr(i);
    figure(3)
    suptitle('Bisection Method for f_1(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myBisection(f1,a0,b0,e,l,inf);
    plot_intervals(a,b,3,['e=0.001, Tolerance=',num2str(l)])
    
    figure(4)
    suptitle('Bisection Method for f_2(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myBisection(f2,a0,b0,e,l,inf);
    plot_intervals(a,b,4,['e=0.001, Tolerance=',num2str(l)])
   
    figure(5)
    suptitle('Bisection Method for f_3(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myBisection(f3,a0,b0,e,l,inf);
    plot_intervals(a,b,5,['e=0.001, Tolerance=',num2str(l)])
end
saveas(3,[dir 'f1_over_iter'],'png')
saveas(4,[dir 'f2_over_iter.png'])
saveas(5,[dir 'f3_over_iter.png'])



