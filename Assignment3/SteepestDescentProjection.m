function [x, y, F] = SteepestDescentProjection(f, e, x0, y0, g, s, constraints, KMAX)
% [x, y, F] = SteepestDescentProjection(f, e, x0, y0, ALGORITHM, g, KMAX)
% STEEPESTDESCENTPROJECTION
%
% Inputs:
% f         : 2-D function f(xx,yy)
% e         : Accuracy
% x0        : x-coordinate of initial point
% y0        : y-coordinate of initial point
% g         : Step of method (projection)
% s         : Step of method
% KMAX      : Maximum number of iterations
%
% Outputs:
% x         : x-coordinate over over iterations
% y         : y-coordinate over iterations
% F         : local min over iterations (F(end)=local min)

if nargin == 7
    KMAX = inf;
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

fprintf('Iteration: '); 
lineLength = fprintf('%2.0f',1);
while (norm(subs(gradf,{xx,yy}, [x(k),y(k)])) > e && k<KMAX)
    if mod(k,10)==0
        fprintf(repmat('\b',1,lineLength))
        lineLength = fprintf('%2.0f',k);
    end
    % Projection x and y
    if x(k) < constraints(1,1)
        x(k) = constraints(1,1);
    elseif x(k) > constraints(1,2)
        x(k) = 10;
    end
    if y(k) < constraints(2,1) 
        y(k) = constraints(2,1); 
    elseif y(k) > constraints(2,2)
        y(k) = constraints(2,2);
    end
    
    grad = double(subs(gradf,{xx,yy}, [x(k),y(k)]));     
    xbar = x(k) - s*grad(1);
    ybar = y(k) - s*grad(2);
    
    % Projection of xbar and ybar
    if xbar < constraints(1,1) 
        xbar = -20;
    elseif xbar > constraints(1,2)
        xbar = constraints(1,2);
    end
    if ybar < constraints(2,1)
        ybar = constraints(2,1);
    elseif ybar > constraints(2,2) 
        ybar = constraints(2,2);
    end
        
    x(k+1) = x(k) + g*(xbar-x(k));
    y(k+1) = y(k) + g*(ybar-y(k));
    F(k+1) = double(subs(f, {xx, yy}, [x(k+1),y(k+1)]));
    k = k+1;        
end
fprintf(repmat('\b',1,lineLength))
lineLength = fprintf('%2.0f',k);
fprintf('\n');


end
    
