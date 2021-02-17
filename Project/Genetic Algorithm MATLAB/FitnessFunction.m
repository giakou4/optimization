function out = FitnessFunction(x)

kp1 = x(1);
kp2 = x(2);
ki1 = x(3);
ki2 = x(4); 
kd1 = x(5);
kd2 = x(6);

T = 20;

yd1 = @(t) 90*pi/180 + (30*pi/180)*cos(t);
yd2 = @(t) 90*pi/180 + (30*pi/180)*sin(t);

[x,t,u] = simclosedloop(kp1,kp2,ki1,ki2,kd1,kd2,T);
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
x4 = x(:,4);
u1 = u(:,1);
u2 = u(:,2);
y1 = x1;
y2 = x3;

out = 0;

l = T*10/2:T*10; % steady state?
err1 = abs(y1-yd1(t)); % tracking error 1
err2 = abs(y2-yd2(t)); % tracking error 2
temp1 = find(err1>pi/180);
temp2 = find(err2>pi/180);

J1 = max(max(err1(l)), max(err2(l))); 
J2 = max(max(err1), max(err2));
J3 = max(max(temp1(2:end)-temp1(1:end-1)),max(temp2(2:end)-temp2(1:end-1))); % max time to get error to [-pi/180, pi/180]
J4 = max(max(abs(u1)), max(abs(u2)));
J5 = max(max(abs(u1(6:end)-u1(1:end-5))),max(abs(u2(6:end)-u2(1:end-5))));
J6 = max(max(u1)-min(u1),max(u2)-min(u2));

f = @(x,b) -100*exp(-b*abs(x))+100;

if J1 > pi/180
    out = out + f(J1,0.1)/6;
end

if J2 > pi/180
    out = out + f(J2,0.1)/6;
end

if J3 > 1
    out = out + f(J3,0.1)/6;
end

out = out + f(J4,0.005)/6;
out = out + f(J5,0.005)/6;
out = out + f(J6,0.005)/6;

end

