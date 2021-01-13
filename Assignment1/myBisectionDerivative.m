function [a,b,calls]= myBisectionDerivative(f,a0,b0,l)
% function [a,b] = myBisectionDerivative(f,a0,b0,l)
% MYBISECTIONDERIVATIVE finds the minimum of a function inside an interval.
% The method consists of repeatedly finding the median of the values of the
% interval and calculating the derivative in that point. Then it selects 
% the subinterval based on Theorem 5.1.1 which must contain the 
% minimum.
% Inputs
% f      : Strictly semi convex fuction of x: f(x)
% a0     : Left interval
% b0     : Right interval
% l      : Tolerance
% Outputs
% a      : Left interval over iterations
% b      : Right interval over iterations
% calls  : Number of calls to subs

if (b0 <= a0) 
    msg='ERROR!';
    error(msg)
end 

df=diff(f,'x');
k = 1; 
a = [a0]; 
b = [b0]; 

calls = 0;
while (b(k) - a(k) > l)
    x(k) = (a(k) + b(k))/2;
    value = subs(df,x(k));
    calls = calls + 1;
    if value == 0
        a(k+1) = x(k);
        b(k+1) = x(k);
        return
    elseif value > 0
        a(k+1) = a(k);
        b(k+1) = x(k);
    elseif value < 0
        a(k+1) = x(k);
        b(k+1) = b(k);
    end
    k = k + 1;
end

end