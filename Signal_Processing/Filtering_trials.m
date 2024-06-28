%Filtering trials
clc, clearvars;
[y,Fs] = audioread("Noise_Removal.wav");

Y = fft(y);
N = length(y);

subplot(2,2,1);
plot(Fs/N*(0:N-1),abs(Y),"Linewidth",3);
title('Unfiltered');
xlabel('f');
ylabel('X(f)');

%butterworth
LPF_cutoff = 2000;
n = 4; %let us just try a 4th order filter
Wn = LPF_cutoff/(Fs/2);
[b,a] = butter(n,Wn,'low');
LPF_filtered_output = filter(b,a,y);

LPF_filtered_fft = fft(LPF_filtered_output);
LPF_len = length(LPF_filtered_output);

subplot(2,2,2);
plot(Fs/LPF_len*(0:LPF_len-1),abs(LPF_filtered_fft),"Linewidth",3);
title('Butterworth LPF');
xlabel('f');
ylabel('X(f)');
%lowpass
LPF = 2000;
filtered = lowpass(y,LPF,Fs);
subplot(2,2,3);
plot(Fs/LPF_len*(0:LPF_len-1),abs(filtered),"Linewidth",3);
title('LPF');
xlabel('f');
ylabel('X(f)');