function [a,b]=fractional_moment(mu,nu,MAX_K)
%mu=0.5;
%nu=5;
%MAX_K=100;
a=zeros(1,MAX_K*2-2);
b=zeros(1,MAX_K*2-2);
for i=1:(MAX_K-1)
    k=i+1;
    a(i)=-mu/k;
    b(i)=nu^(1/k)/gamma(mu/k)*pi/k*csc(pi/k);
end

for i=1:(MAX_K-1)
    k=i+1;
    a(i+MAX_K-1)=mu*(k-1)/k;
    b(i+MAX_K-1)=1/nu^((k-1)/k)/gamma(1-mu*(k-1)/k)*pi*(k-1)/k*csc(pi/k); 
end