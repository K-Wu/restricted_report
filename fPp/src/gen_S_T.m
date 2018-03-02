%This function is to generate truncated interarrival time of fractional poisson process.
function S_T=gen_S_T(mu_,nu_,T)
u1=rand();
u2=rand();
u3=rand();
S=abs(log(u1))^(1/mu_)/(nu_^(1/mu_))*(sin(mu_*pi*u2)*(sin((1-mu_)*pi*u2))^(1/mu_-1))/((sin(pi*u2))^(1/mu_)*abs(log(u3))^(1/mu_-1));
S_T=min(T,S);
