result=zeros(1,50000);
for i=1:50000
    result(i)=gen_S_T(0.5,5,10);
    %result(i)=exprnd(5);
end
histogram(result,1000);