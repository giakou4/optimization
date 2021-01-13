function [a,b,calls,x1,x2] = myFibonacci(f,a0,b0,l)
% function [a,b,x1,x2] = MyFibonacci(f,a0,b0,l)
% MYFIBONACCI finds the minimum of a function inside an interval. The 
% method consists of repeatedly finding 2 interior points based on the
% Fibonacci sequence and then selecting the subinterval based on Theorem 
% 5.1.1 , which must contain the minimum.
% Inputs
% f      : Strictly semi convex fuction
% a0     : Left interval
% b0     : Right interval
% l      : Tolerance
% Outputs
% a      : Left interval over iterations
% b      : Right interval over iterations
% calls  : Number of calls to subs
% x1     : Interior point #1 (left) over iterations
% x2     : Interior point #2 (right) over iterations

if (l <= 0 || b0 <= a0) 
    msg='ERROR!';
    error(msg)
end 

% Calculate Fibonacci Numbers
Fn=(b0-a0)/l;
fib=[];
fib(1)=1;
fib(2)=1;
n=2; % how many fibonacci numbers will be needed
while Fn > fib(end)                 % efficient way to calculate 
    fib(end+1)=fib(end)+fib(end-1); % Fibonacci numbers 
    n=n+1;                          % w/out recursion
end
fib(end+1) = fib(end)+fib(end-1); % calculate 2 extras for the recursion
fib(end+1) = fib(end)+fib(end-1);

k = 1; 
a = [a0]; 
b = [b0];
calls = 0;

x1 = []; x2 = []; fx1 = []; fx2 = [];
x1(k) = a(k) + (fib(n-k-1)/fib(n-k+1) )*(b(k) - a(k));
x2(k) = a(k) + (fib(n-k)/fib(n-k+1) )*(b(k) - a(k));
fx1(k) = subs(f,x1(k));
fx2(k) = subs(f,x2(k));
calls = calls + 2;

for k = 1:n-1 % if run for k=1:n, fib(0) will occur and MATLAB starts indexing at 1 :(
    if x1(k) == x2(k)
        a(k) = x1(k);
        b(k) = x2(l);
        return
    end
    if fx1(end) <= fx2(end)
        a(k+1) = a(k);
        b(k+1) = x2(k);
        x1(k+1) = a(k+1) + (fib(n-k+1-1)/fib(n-k+1+1)) * (b(k+1)-a(k+1));
        x2(k+1) = x1(k);
        fx1(k+1) = subs(f,x1(k+1));
        calls = calls + 1;
    else
        a(k+1) = x1(k);
        b(k+1) = b(k); 
        x1(k+1) = x2(k); 
        x2(k+1) =  a(k+1) + (fib(n-k+1)/fib(n-k-1+1)) * (b(k+1)-a(k+1));
        fx2(k+1) = subs(f,x2(k+1));
        calls = calls + 1;
    end  
end

end

%{
for k = 1:n
    if x1(k) == x2(k)
        a(k) = x1(k);
        b(k) = x2(l);
        return
    end
    if subs(f,x1(k)) <= subs(f,x2(k))
        a(k+1) = a(k);
        b(k+1) = x2(k);  
        x1(k+1) = a(k+1) + (fib(n-k-1+1)/fib(n-k+1+1)) * (b(k+1)-a(k+1));
        x2(k+1) = x1(k);
    else
        a(k+1) = x1(k);
        b(k+1) = b(k); 
        x1(k+1) = x2(k); 
        x2(k+1) =  a(k+1) + (fib(n-k+1)/fib(n-k+1+1)) * (b(k+1)-a(k+1));
    end  
end


        if (n-k) == 0 % how to deal with fib(0) = 1
            temp = 0;
        else
            temp = fib(n-k-1+1);
        end
%}