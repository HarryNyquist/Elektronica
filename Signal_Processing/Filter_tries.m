%Filter_tries
clc, clearvars;
[y,Fs] = audioread("Noise_Removal.wav");
%t = (0:length(y)-1)/Fs; 
L = length(y);
%plot(t,y);
Y = fftshift(fft(y));
N = length(y);
freq = (-N/2:N/2-1)*(Fs/N);

subplot(2,2,1);
plot(freq,abs(Y),"Linewidth",3);
title('UF');
xlabel('f');
ylabel('X(f)');

Fc = 500;
[b,a] = butter(4,Fc/(Fs/2),'low');
filtered_output = filter(b,a,y);


Fc_high = 300;
[b1,a1] = butter(4,Fc_high/(Fs/2),'high');
HPF_output = filter(b1,a1,filtered_output);
audiowrite("ZZ_Filtered_output.wav",HPF_output,Fs);
%plot
subplot(2,2,2);
Filtered_fft = fftshift(fft(HPF_output));
plot(freq,abs(Filtered_fft),"Linewidth",3);
title('LPF');
xlabel('f');
ylabel('X(f)');


subplot(2,2,3);
filtered_hpf_fft = fftshift(fft(filtered_output));
plot(freq,abs(Filtered_fft),"Linewidth",3);
title('HPF');
xlabel('f');
ylabel('X(f)');

%H = double(abs(freq) <= Fc);
%Filtered_fft = Y.*H;

