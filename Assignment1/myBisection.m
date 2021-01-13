function [a,b,calls,x1,x2] = myBisection(f,a0,b0,e,l,KMAX)
% function [a,b,x1,x2] = myBisection(f,a0,b0,e,l,KMAX)
% MYBISECTION finds the minimum of a function inside an interval. The 
% method consists of repeatedly bisecting the interval and then selecting 
% the subinterval based on Theorem 5.1.1 , and therefore must contain the 
% minimum.
% Inputs
% f      : Strictly semi convex fuction
% a0     : Left interval
% b0     : Right interval
% e      : Distance from Bisector
% l      : Tolerance
% KMAX   : Maximum Iterations (if given)
% Outputs
% a      : Left interval over iterations
% b      : Right interval over iterations
% calls  : Number of calls to subs
% x1     : Interior point #1 (left) over iterations
% x2     : Interior point #2 (right) over iterations

if (e <= 0 || l <= 0 || b0 <= a0) 
    msg='ERROR!';
    error(msg)
end 

a = [a0];
b = [b0];
k = 1;
x1 = [];
x2 = [];
calls = 0;

while (b(k) - a(k) > l)
    x1(k) = (a(k) + b(k))/2 - e;
    x2(k) = (a(k) + b(k))/2 + e;
    if subs(f,x1(k)) < subs(f,x2(k)) 
        calls = calls + 2;
        a(k+1) = a(k);
        b(k+1) = x2(k);
    else
        calls = calls + 2;
        a(k+1) = x1(k);
        b(k+1) = b(k);
    end
    k = k + 1;
    if k > KMAX
        return;
    end
end

end