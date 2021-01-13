function [x, y, F] = SteepestDescent(f, e, x0, y0, ALGORITHM, g, KMAX)
% [x, y, F] = SteepestDescent(f, e, x0, y0, ALGORITHM, g, KMAX)
% STEEPESTDESCENT is a method that tries to find the minimum value of 
% function f(x,y) by taking steps proportional to the negative of the 
% gradient of the function at the current point.
% Inputs
% f         : 2-D function f(xx,yy)
% e         : Accuracy
% x0        : x-coordinate of initial point
% y0        : y-coordinate of initial point
% ALGORITHM : 1 - g = ct
%             2 - g = argmin of f[x(k)+g(k)*d(k)]
%             3 - Armijo
% g         : Step of method (if ALGORITHM=1)
% KMAX      : Maximum number of iterations
% Outputs
% x         : x-coordinate over over iterations
% y         : y-coordinate over iterations
% F         : local min over iterations (F(end)=local min)

if nargin == 5
  KMAX = inf;
  if ALGORITHM == 2 || ALGORITHM == 3
      g = NaN;
  else
    msg='ERROR!';
    error(msg)
  end
end

if (e < 0)
    msg='ERROR!';
    error(msg)
end

syms xx yy
gradf = [gradient(f,xx) gradient(f,yy)];

k=1;
x(k)=x0;
y(k)=y0;
F(k) = double(subs(f, {xx, yy}, [x(k),y(k)]));

while (norm(subs(gradf,{xx,yy}, [x(k),y(k)])) > e && k<KMAX)
    d = -double(subs(gradf,{xx,yy}, [x(k),y(k)]));
    switch ALGORITHM
        case 1
            g = g;
        case 2
            h = @(g) double(subs(f, {xx, yy}, [x(k)+g*d(1),y(k)+g*d(2)]));
            [g1,g2] = Golden(h,0,2,0.001,inf); % new g=argmin(f(x-g*gradf(x)))
            g = (g1(end)+g2(end))/2;
        case 3
            g = Armijo(f,d,x,y,k);
    end            
    x(k+1) = x(k) + g*d(1);
    y(k+1) = y(k) + g*d(2);
    F(k+1) = double(subs(f, {xx, yy}, [x(k+1),y(k+1)]));
    k = k+1;
end


end
    
