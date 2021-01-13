function plot_intervals(a,b,myfig,mytitle)
% This function plots the intervals given as two vectors of same size a,b
% in the figure with the number denoted in the input.
% Inputs:
% a      : Left/Lower interval
% b      : Right/Upper interval
% myfig  : Number of figure

if length(a)~= length(b)
    msg='ERROR!';
    error(msg)
end 

%figure(myfig) #commented out in order to handle it in main fuction
plot(a,'xr','LineStyle','--','LineWidth',1.5,'MarkerSize',8)
hold on
plot(b,'ob','LineStyle','--','LineWidth',1.5,'MarkerSize',8)
title([mytitle ' - Interval found: [',num2str(a(end)),' , ',num2str(b(end)),']'],'interpreter','latex'); 
xlabel('# of iterations'); 
ylabel('Interval [a_k,b_k]'); 
legend('a_k','b_k')

end

