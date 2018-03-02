%This file is to plot the figure of E(S^s), where s is fractional in
%[-\mu,\mu], as shown in the subsection using laplace transform.
[a_1,b_1]=fractional_moment(0.2,5,100);
[a_2,b_2]=fractional_moment(0.5,5,100);
[a_3,b_3]=fractional_moment(0.8,5,100);
figure;
scatter(a_1,b_1,'.');hold on;
scatter(a_2,b_2,'o');hold on;
scatter(a_3,b_3,'+');hold on;
xlabel('s');ylabel('E(X^s)');
title('fractional moment with \nu =5');
legend('\mu=0.2','\mu=0.5','\mu=0.8');
figure;
subplot(1,3,1);scatter(a_1,b_1,'.');title('\mu=0.2');axis([-0.1,0,0,0.4]);xlabel('s');ylabel('E(X^s)');
subplot(1,3,2);scatter(a_1,b_1,'o');title('\mu=0.5');axis([-0.1,0,0,0.4]);
subplot(1,3,3);scatter(a_1,b_1,'+');title('\mu=0.8');axis([-0.1,0,0,0.4]);
%title('fractional moment with \nu =5');
%legend('\mu=0.2','\mu=0.5','\mu=0.8');