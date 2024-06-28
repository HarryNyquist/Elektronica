clc, clearvars;
[y,Fs] = audioread("Noise_Removal.wav");
%t = (0:length(y)-1)/Fs; 
L = length(y);
%plot(t,y);
Y = fft(y);
%Filtering

Fc1 = 700;
Fc2 = 1700;
n = 7; %let us just try a 4th order filter
Wn = [Fc1,Fc2]/(Fs/2);
[b,a] = butter(n,Wn,'bandpass');
filtered_output = filter(b,a,y);

filtered_fft = fft(filtered_output);
N = length(filtered_output);

subplot(2,1,1);
plot(Fs/L *(0:L-1),abs(Y),"Linewidth",3);
title('UF');
xlabel('f');
ylabel('X(f)');


subplot(2,1,2);
plot(Fs/N*(0:N-1),abs(filtered_fft),"Linewidth",3);
title('Filtered');
xlabel('f');
ylabel('X(f)');
audiowrite("Z_Filtered_output.wav", filtered_output, Fs);
