function [g] = Armijo(f,d,x,y,k)
% function [g] = Armijo(f,x,y,k)
% ARMIJO calculates g based on Armijo's rule
% Inputs:
% f         : function f(x,y)
% d         : d(k)
% x         : values of x
% y         : values of y
% k         : current iteration
% Output:
% g         : gamma/step calaculated

syms xx yy
gradf = [gradient(f,xx) gradient(f,yy)];

m = 0.01;
s = 0.1;
for a = linspace(10^(-5), 10^(-1), 30)
    for b = linspace(1/10, 1/2, 30)
        f2 = double(subs(f,{xx,yy},[x(k)+(b^m)*d(1),y(k)+(b^m)*d(2)]));
        f1 = double(subs(f,{xx,yy},[x(k),y(k)]));
        if f2-f1 <= a*s*(b^m)*double(subs(gradf,{xx,yy},[x(k),y(k)]))*d'
            g = s*b^m;
            return
        else
            m = m + 0.01;
        end
    end
end

end