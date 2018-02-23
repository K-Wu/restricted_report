lambda=2.0;
mu=0.5;
nu=5;
T=5;
MAX_SERVED=50000;
NUM_EPOCH=10;
timeout_ratio=zeros(1,NUM_EPOCH);
avg_queue_length=zeros(1,NUM_EPOCH);
for ep=1:NUM_EPOCH
    service_times=zeros(1,MAX_SERVED);
    timeout_cnt=0;
    sum_queue_length=0;
    sum_queue_length_num_samples=0;
    for i=1:MAX_SERVED
        service_times(i)=gen_S_T(mu,nu,T);
        timeout_cnt=timeout_cnt+(service_times(i)==T);
    end
    %x=zeros(1,MAX_SERVED+1);
    %y=zeros(1,MAX_SERVED+1);
    x=[0];y=[0];
    curr_ind=1;
    for i=1:MAX_SERVED
        curr_ind=curr_ind+1;
        if y(curr_ind-1)==0 %serve immediately once some customer arrives
            x(curr_ind)=exprnd(lambda)+x(curr_ind-1);
            y(curr_ind)=1;%insert one point on the plot
            
            sum_queue_length_num_samples=sum_queue_length_num_samples+1;
            curr_ind=curr_ind+1;
        end
        x(curr_ind)=x(curr_ind-1)+service_times(i);
        y(curr_ind)=y(curr_ind-1)-1;
        num_customer_arrival=random('poiss',service_times(i)*lambda);
        y(curr_ind)=y(curr_ind)+num_customer_arrival;
        sum_queue_length_num_samples=sum_queue_length_num_samples+num_customer_arrival;
        sum_queue_length=sum_queue_length+(y(curr_ind)-1+y(curr_ind-1)-1)/2*num_customer_arrival;
    end
    plot(x,y);hold on;
    timeout_ratio(ep)=timeout_cnt/MAX_SERVED;
    avg_queue_length(ep)=sum_queue_length/sum_queue_length_num_samples;
end
title('Simulation Result with \lambda =2 \mu =0.5 \nu =5 T=5');
ylabel('# Customers in the System');