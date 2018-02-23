%calculate avg queue length using Pollaczek-Khintchine formula.
%nu=5, mu=0.5, T=5
es=0.466637031400487;
es2=0.832431327732974;
lambda=[2,2.1];
W=zeros(1,length(lambda));
L=zeros(1,length(lambda));
for i=1:length(lambda)
    W(i)=lambda(i)*es2/(2*(1-lambda(i)*es))+es;
    L(i)=lambda(i)*W(i);
end