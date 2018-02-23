%PLOT_MITTAG_LEFFLER This file is to plot the E(S_T) and E(S^2_T), with the
%variable T.
mus=[0.2,0.5,0.8];
nu=5;
step_time=0.1;
MAX_T=1000;
x=0:step_time:MAX_T;
ys=zeros(length(mus),length(x));
y2s=zeros(length(mus),length(x));
for t=1:floor(MAX_T/step_time)
    for ind=1:length(mus)
        ys(ind,t+1)=ys(ind,t)+integral(@(x)ml(-nu*power(x,mus(ind)),mus(ind),1,1),t*step_time-step_time,t*step_time);
        y2s(ind,t+1)=y2s(ind,t)+2*integral(@(x)x.*ml(-nu*power(x,mus(ind)),mus(ind),1,1),t*step_time-step_time,t*step_time);
    end
end
for ind =1:length(mus)
    figure;plot(x,ys(ind,:));
end