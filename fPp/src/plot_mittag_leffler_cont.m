%figure;subplot(2,1,2);plot(x,y2s(4,:));title('E(S^2) with \mu=1 \nu=5');xlabel('T');xrange(0,30);subplot(2,1,1);plot(x,ys(4,:));title('E(S) with \mu=1 \nu=5');xlabel('T');xrange(0,30);
figure;plot(x,ys(1,:));hold on;plot(x,ys(2,:));plot(x,ys(3,:));legend('\mu=0.2','\mu=0.5','\mu=0.8');xlabel('T');title('E(S) with \nu=5');
figure;plot(x,y2s(1,:));hold on;plot(x,y2s(2,:));plot(x,y2s(3,:));legend('\mu=0.2','\mu=0.5','\mu=0.8');xlabel('T');title('E(S^2) with \nu=5');
figure;plot(x,ys(1,:));hold on;plot(x,ys(2,:));plot(x,ys(3,:));legend('\mu=0.2','\mu=0.5','\mu=0.8');xlabel('T');title('E(S) with \nu=5 bigger');axis([0,100,0,6]);
figure;plot(x,y2s(1,:));hold on;plot(x,y2s(2,:));plot(x,y2s(3,:));legend('\mu=0.2','\mu=0.5','\mu=0.8');xlabel('T');title('E(S^2) with \nu=5 bigger');axis([0,100,0,250]);