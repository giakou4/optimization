function plot_intervals2(a,b,myfig,mytitle)
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

figure(myfig)
for i=1: length(a)
    line([i,i],[a(i),b(i)],'LineStyle','-','LineWidth',1.5,'Marker','x',...
        'MarkerSize',10,'Color',[0.1 0.4 1],'MarkerEdgeColor',[0 0 1])
    hold on
end
title([mytitle ' - Interval found: [',num2str(a(end)),' , ',num2str(b(end)),']'],'interpreter','latex'); 
xlabel('# of iterations'); 
ylabel('Interval [a_k,b_k]'); 
legend('a_k','b_k')

end

