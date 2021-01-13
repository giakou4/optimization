% In case you want to see all demonstrations at one, run this script and
% press enter when asked.

clear all; close all; clc;

syms x
f1 = (x-2)^2 - sin(x+3);
f2 = exp(-5*x) + (x+2)*cos(0.5*x)^2;
f3 = (x^2)*sin(x+2) - (x+1)^2;
a0 = 2;
b0 = 5;

figure
subplot(3,1,1)
suptitle('Functions');
fplot(f1)
xlim([a0,b0]); xlabel('x'); ylabel('f_1(x)');
subplot(3,1,2)
fplot(f2)
xlim([a0,b0]);  xlabel('x'); ylabel('f_2(x)');
subplot(3,1,3)
fplot(f3)
title('f_3(x)');
xlim([a0,b0]); xlabel('x'); ylabel('f_3(x)');
saveas(gcf,[pwd '\functions'],'png')

disp('Running thema1.m...');
thema1.m
disp('Press Enter to continue...')
pause();

disp('Running thema2.m...');
thema2.m
disp('Press Enter to continue...')
pause();

disp('Running thema3.m...');
thema3.m
disp('Press Enter to continue...')
pause();

disp('Running thema1.m...');
thema4.m