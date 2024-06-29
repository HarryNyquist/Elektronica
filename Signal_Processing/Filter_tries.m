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

[n1,Wn1] = buttord(1500/(Fs/2),1000/(Fs/2),1,50); 
[b,a] = butter(n1,Wn1,'high');
filtered_output = filtfilt(b,a,y);

[n2,Wn2] = buttord(2000/(Fs/2), 2400/(Fs/2),0.25,100);
[b1,a1] = butter(n2,Wn2,'low');
LPF_output = filtfilt(b1,a1,filtered_output);
gain = db2mag(10);
%HPF_output*gain
%[b_l, a_l

%penultimate = abs(HPF_output - filtered_output);
%final = filter(b1,a1,penultimate);


audiowrite("ZZ_Filtered_output.wav",LPF_output,Fs);
%plot


subplot(2,2,2);
Filtered_fft = fftshift(fft(LPF_output));
plot(freq,abs(Filtered_fft),"Linewidth",3);
title('LPF');
xlabel('f');
ylabel('X(f)');


subplot(2,2,3);
filtered_hpf_fft = fftshift(fft(filtered_output));
plot(freq,abs(filtered_hpf_fft),"Linewidth",3);
title('HPF');
xlabel('f');
ylabel('X(f)');


Fc1 = 400;
Fc2 = 900;
Wn = [Fc1,Fc2]/(Fs/2);
[b2,a2] = butter(7,Wn,'bandpass');
BPF_output = filter(b2,a2,y);


subplot(2,2,4)
final_fft = fftshift(fft(BPF_output));
plot(freq, abs(final_fft), "Linewidth",3);
title('Final');
xlabel('f');
ylabel('X(f)');

audiowrite("Z_BPF_Filtered_output.wav",BPF_output,Fs);

%H = double(abs(freq) <= Fc);
%Filtered_fft = Y.*H;

