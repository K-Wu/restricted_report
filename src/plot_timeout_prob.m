%This is to print the figure indicating the timeout probability in the same
%setting as plot_mittag_leffler.m
mus=[0.2,0.5,0.8, 1.0];
nu=5;
step_time=0.1;
MAX_T=160;
x=0:step_time:MAX_T;
fail_rate=zeros(length(mus),length(x));
for t=1:floor(MAX_T/step_time)
    for ind=1:length(mus)
        fail_rate(ind,t+1)=ml(-nu*power(t*step_time,mus(ind)),mus(ind),1,1);
    end
end
figure;
for ind =1:length(mus)
    plot(x,fail_rate(ind,:));hold on;
end
title('timeout probability with \nu = 5');xlabel('T');axis([-0.1,15,0,0.8]);legend('\mu=0.2','\mu=0.5','\mu=0.8','\mu=1');