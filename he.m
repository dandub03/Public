x0 = zeros(1,15)
lambda = zeros(1,3)
v = zeros(1,5)
it = 0;
e = 10;
A1 = [0 0;0 1;-1 0];
A2 = [-1 0; 0 1; 0 0];
A3 = [0 0;-1 0;0 1];

while (abs(e) >= exp(-5))
    previous_out=p(x0);
lb = zeros(1,15);
ub = [9 9 9 9 9 9 15 15 15 15 15 15 1 1 1];
% lambda to 0 
lb(13:15) = x0(13:15);
ub(13:15) = x0(13:15);
% p1
x1 = fmincon(@p1,x0,[],[],[],[],lb,ub);
v1in = x1(1);
v1out = x1(2);
m11_optimal = x1(7);
m12_optimal = x1(8);
% p2
x2 = fmincon(@p2,x0,[],[],[],[],lb,ub);
v2in = x2(3);
v2out = x2(4);
m21_optimal = x2(9);
m22_optimal = x2(10);
% p3
x3 = fmincon(@p3,x0,[],[],[],[],lb,ub);
v3in = x3(5);
v3out = x3(6);
m31_optimal = x3(11);
m32_optimal = x3(12);

result(1)=v1in;
result(2)=v1out;
result(3)=v2in;
result(4)=v2out;
result(5)=v3in;
result(6)=v3out;
result(7)=m11_optimal;
result(8)=m12_optimal;
result(9)=m21_optimal;
result(10)=m22_optimal;
result(11)=m31_optimal;
result(12)=m31_optimal;

optimal_v = result(1:6);
c = [optimal_v(2)-optimal_v(3) optimal_v(4)-optimal_v(5) optimal_v(6)-optimal_v(1)];
x0(13:15) = x0(13:15) -1*c;
x0(1:12) = result(1:12);
new_out=p(x0);

e=abs(previous_out-new_out);
it = it+1;
end
out=p(x0)

v1in
v1out
v2in
v2out
v3in
v3out
m11_optimal
m12_optimal
m21_optimal
m22_optimal
m31_optimal
m32_optimal
lambda(1)
lambda(2)
lambda(3)
it


function x = p(vector)
    x = p1(vector)+p2(vector)+p3(vector);
end

function x = p1(vector)
    v1in = vector(1); %v31
    v1out = vector(2); %v12
    m11 = vector(7);
    m12 = vector(8);
    v = vector(1:2)';
    lambda = vector(13:15);
    A1 = [0 0;0 1;-1 0];
    x = -(-(v1in-2).*(v1in-2)-2*(v1out-3).*(v1out-3)-v1in*m12-(m11-v1out).*(m11-v1out)+m11+40)-lambda*A1*v;
end

function x = p2(vector)
    v2in = vector(3); %v12
    v2out = vector(4); %v23
    m21 = vector(9);
    m22 = vector(10);
    v = vector(3:4)';
    lambda = vector(13:15);
    A2 = [-1 0; 0 1; 0 0];
    x = -(-3*(v2in-4).*(v2in-4)-(v2out-1).*(v2out-1)+v2out*m21-(m22-v2in).*(m22-v2in)-m22+20)-lambda*A2*v;
end

function x = p3(vector)
    v3in = vector(5); %v23
    v3out = vector(6); %v31
    m31 = vector(11);
    m32 = vector(12);
    v = vector(5:6)';
    lambda = vector(13:15);
    A3 = [0 0;-1 0;0 1];
    x = -(-2*(v3in-5).*(v3in-5)-4*(v3out-1).*(v3out-1)-v3in*m31-(m32-v3out).*(m32-v3out)+m32+30)-lambda*A3*v;
end
