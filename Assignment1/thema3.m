%% Thema 1
% Fibonacci method
% 1) Call method for various values of tolerance set arbitrarily and plot 
% the number of calls to the function vs tolerance.
% 2) Solve the minimization problem for some values of tolerance and plot 
% the intervals over iterations.
clear all; close all; clc
dir = [pwd '\PlotsThema3\']; 
%% Functions 2 Test
syms x
f1 = (x-2)^2 - sin(x+3);
f2 = exp(-5*x) + (x+2)*cos(0.5*x)^2;
f3 = (x^2)*sin(x+2) - (x+1)^2;
a0 = 2;
b0 = 5;

%% Various values for Tolerance
l_arr = linspace(0.01,0.1,20);
f1_calls = [];
f2_calls = [];
f3_calls = [];
for i = 1:length(l_arr)
    l = l_arr(i);
    disp(['Iteration (Tolerance=',num2str(l),') No. ',num2str(i)]);
    [~,~,calls] = myFibonacci(f1,a0,b0,l);
    f1_calls = [f1_calls calls];
    
    [~,~,calls] = myFibonacci(f2,a0,b0,l);
    f2_calls = [f2_calls calls];
    
    [~,~,calls] = myFibonacci(f3,a0,b0,l);
    f3_calls = [f3_calls calls];
end

figure(1)
subplot(3,1,1)
plot(l_arr, f1_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_1(x)');
subplot(3,1,2)
plot(l_arr, f2_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_2(x)');
subplot(3,1,3)
plot(l_arr, f3_calls); xlabel('Tolerance'); ylabel('# of Iteration');
legend('Calls of f_3(x)');
suptitle('Fibonacci Method: Calls')
saveas(gcf,[dir 'VariousTolerance.png'])
%% [ak,bk] from values of Tolerance l=[0.01,0.1,0.3]
l_arr = [0.01 0.1 0.3];
for i = 1:length(l_arr)
    l = l_arr(i);
    disp(['Iteration No. ',num2str(i)]);
    figure(2)
    suptitle('Fibonacci Method for f_1(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myFibonacci(f1,a0,b0,l);
    plot_intervals(a,b,3,['Tolerance=',num2str(l)])
    
    figure(3)
    suptitle('Fibonacci Method for f_2(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myFibonacci(f2,a0,b0,l);
    plot_intervals(a,b,4,['Tolerance=',num2str(l)])
   
    figure(4)
    suptitle('Fibonacci Method for f_3(x) ')
    subplot(length(l_arr),1,i)
    [a,b,~] = myFibonacci(f3,a0,b0,l);
    plot_intervals(a,b,5,['Tolerance=',num2str(l)])
end
saveas(2,[dir 'f1_over_iter'],'png')
saveas(3,[dir 'f2_over_iter.png'])
saveas(4,[dir 'f3_over_iter.png'])