clear all;close all;
%original discrete signal parameter setting
N_s=2048;
N_loop=5000;
variations=zeros(1,N_loop);
failures=0;
no_print=1;
for loop=1:N_loop
    w_set=[2*pi*(0.34),2*pi*(-0.19)];
    a_set=[3,3];
    %phi_set=[0.3*pi,0.37*pi];
    phi_set=rand(1,2)*(2*pi);
    N_sample=14;
    N_harm=6;
    %generate original discrete signal
    s=zeros(1,N_s);
    for ind=1:N_s%using stupid loop in MATLAB
        s(ind)=sum(a_set.*exp(1i*w_set*(ind-1)+phi_set));

    end
    s_wo_noise=s;
    %s_wo_noise=real(s_wo_noise);
    %s=real(s);
    s=awgn(s,10);

    s_sample=s(1:N_sample);
    if N_loop<=1
        figure;plot(real(s));
    end
    %Is fft a good method in this scenario?
    N_f0=64;N_f2=256;N_f3=512;
    f=fft(s);
    f_sample=fft(s_sample,N_f0);
    f_sample0=fft(s_sample,N_f2);
    f_sample1=fft(s_sample,N_f3);
    if N_loop<=1
        figure;subplot(4,2,1);plot(f.*conj(f));title("origin spectrum vs. sample spectrum in 64 256 512 fft");
        subplot(4,2,2);plot(angle(f));
        subplot(4,2,3);plot(f_sample.*conj(f_sample));
        subplot(4,2,4);plot(angle(f_sample));
        subplot(4,2,5);plot(f_sample0.*conj(f_sample0));
        subplot(4,2,6);plot(angle(f_sample0));
        subplot(4,2,7);plot(f_sample1.*conj(f_sample1));
        subplot(4,2,8);plot(angle(f_sample1));
    end

    %pisarenko decomposition

    %calculating correlation
    cor_seq=xcorr(s_sample,'biased');
    %cor_seq=my_corr(s_sample);
    bias=ceil(length(cor_seq)/2);
    corr=zeros(N_sample-N_harm-1,N_harm+1);
    for ind_i=1:(N_sample-N_harm-1)
        for ind_j=1:(N_harm+1)
            if(ind_i<=ind_j)
               %res(i,j)=conj(corr_seq(j-i+1));
                %res(i,j)=conj(corr(seq,j-i));
                corr(ind_i,ind_j)=cor_seq(bias+ind_i-ind_j+N_harm+1);
            else
               %res(i,j)=corr_seq(i-j+1);
               %res(i,j)=corr(seq,i-j);
               corr(ind_i,ind_j)=cor_seq(bias+ind_i-ind_j+N_harm+1);
            end
        end
    end

        %corr=corr_mat(s_sample,N_harm);
        corr_big=corr_mat(s_sample,N_sample-1);
        %corr=xcorr(s_sample);
        %[V,D]=eig(corr,'nobalance');
        %eigens=sort(diag(D))
        %[M,I]=min(sort(diag(D)));%smallest eigen, to be the noise basis vector
        %fz=zeros(1,size(V,1));
        %fz(:)=flipud(V(:,I));%solve the frequency
        %fz(:)=V(:,I);%solve the frequency

    b=-corr(:,1);
    A=corr(:,2:size(corr,2));
    fz(2:(N_harm+1))=inv(A'*A)*A'*b;
    fz(1)=1;

    fw=angle(roots(fz(:)))/(2*pi);
    if ~no_print
        fw
    end
    %b=corr(1,2:size(corr,2));
    U_restore=zeros(N_sample,length(fw));
    U_restore_big=zeros(N_s,length(fw));
    for ind=1:(N_sample)
        U_restore(ind,:)=exp(1i*fw*(2*pi)*(ind-1)); %restored signal matrix
    end
    for ind=1:(N_s)
        U_restore_big(ind,:)=exp(1i*fw*(2*pi)*(ind-1)); %restored signal matrix
    end
    a=inv(U_restore'*U_restore)*U_restore'*transpose(s_sample);
    if ~no_print
        a
    end
    
    if N_loop<=1
        figure;subplot(2,1,1);plot(abs(U_restore*a));subplot(2,1,2);plot(angle(U_restore*a));
        figure;subplot(2,1,1);plot(abs(U_restore_big*a));subplot(2,1,2);plot(angle(U_restore_big*a));
    end
    %calculating SNR
    error=sum((transpose(s_sample)-U_restore*a).*conj(transpose(s_sample)-U_restore*a));
    genuine_error=sum((transpose(s_wo_noise(1:N_sample))-U_restore*a).*conj(transpose(s_wo_noise(1:N_sample))-U_restore*a));

    error_whole=sum((transpose(s)-U_restore_big*a).*conj(transpose(s)-U_restore_big*a));
    genuine_error_whole=sum((transpose(s_wo_noise)-U_restore_big*a).*conj(transpose(s_wo_noise)-U_restore_big*a));

    power=sum(s_sample.*conj(s_sample));
    SNR=10*log(power/error);
    genuine_SNR=10*log(power/genuine_error);
    power_whole=sum(s.*conj(s));
    SNR_whole=10*log(power_whole/error_whole);
    genuine_SNR_whole=10*log(power_whole/genuine_error_whole);

    if ~no_print
        SNR
        genuine_SNR
        SNR_whole
        genuine_SNR_whole
    end
    
    %calculating frequency variation
    [useless_,sortedIndex]=sort(abs(a));
    variation1=(fw(sortedIndex(N_harm-1))-w_set(1)/(2*pi))^2+(fw(sortedIndex(N_harm))-w_set(2)/(2*pi))^2;
    variation2=(fw(sortedIndex(N_harm-1))-w_set(1)/(2*pi))^2+(fw(sortedIndex(N_harm))-w_set(2)/(2*pi))^2;
    if variation1<variation2
        if ~no_print
            variation1
        end
        variations(loop)=variation1;
    else
        if ~no_print
            variation2
        end
        variations(loop)=variation2;
    if variations(loop)>0.001
        failures=failures+1;
    end
    end
end

variations
failures
variation_avg=sum(variations)/length(variations)
