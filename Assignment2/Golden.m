function [a,b,calls,x1,x2] = Golden(f,a0,b0,l,KMAX)
% function [a,b,x1,x2] = Golden(f,a0,b0,l,KMAX)
% GOLDEN finds the minimum of a function inside an interval. The 
% method consists of repeatedly finding 2 interior points based on the
% golden ratio and then selecting the subinterval based on Theorem 
% 5.1.1 , which must contain the minimum.
% Inputs
% f      : Strictly semi convex fuction
% a0     : Left interval
% b0     : Right interval
% l      : Tolerance
% KMAX   : Maximum Iterations (if given)
% Outputs
% a      : Left interval over iterations
% b      : Right interval over iterations
% calls  : Number of calls to subs
% x1     : Interior point #1 (left) over iterations
% x2     : Interior point #2 (right) over iterations

if (l<=0 || b0<=a0)
    msg='ERROR!';
    error(msg)
end

a = [a0];
b = [b0];
k = 1;
x1 = [];
x2 = [];
g = ((1 + sqrt(5))/2) - 1; % Golden Ratio
calls = 0;

x1(k) = a(k) + (1 - g)*(b(k) - a(k));
x2(k) = a(k) + g*(b(k) - a(k));
fx1(k) = f(x1(k));
fx2(k) = f(x2(k));
calls = calls + 2;

while b(k)-a(k)>l
    if fx1(end) > fx2(end)
        a(k+1) = x1(k);
        b(k+1) = b(k);
        x1(k+1) = x2(k);
        x2(k+1) = a(k+1) + g*(b(k+1) - a(k+1));
        fx2(k+1) = f(x2(k+1));
        calls = calls + 1;
    else
        a(k+1) = a(k);
        b(k+1) = x2(k);
        x1(k+1) = a(k+1) + (1 - g)*(b(k+1) - a(k+1));
        x2(k+1) = x1(k);
        fx1(k+1) = f(x1(k+1));
        calls = calls + 1;
    end
    k = k + 1;
    if k > KMAX
        break;
    end
end

end
