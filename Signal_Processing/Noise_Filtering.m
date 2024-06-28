clc, clearvars;
[y,Fs] = audioread("Noise_Removal.wav");
%t = (0:length(y)-1)/Fs; 
L = length(y);
%plot(t,y);
Y = fft(y);


%Filtering
n = 4; %let us just try a 4th order filter
HPF_cutoff = 1500;
Wn_2 = HPF_cutoff/(Fs/2);
[b1,a1] = butter(n,Wn_2,'high');
HPF_filtered_output = filter(b1,a1,y);

HPF_filtered_fft = fft(HPF_filtered_output);
N1 = length(HPF_filtered_fft);


LPF_cutoff = 2000;
Wn = LPF_cutoff/(Fs/2);
[b,a] = butter(n,Wn,'low');
LPF_filtered_output = filter(b,a,HPF_filtered_output);

LPF_filtered_fft = fft(LPF_filtered_output);
N = length(LPF_filtered_output);


BPF_cutoff_1 = 1500;
BPF_cutoff_2 = 2000;
Wn_BPF = [BPF_cutoff_1, BPF_cutoff_2]/(Fs/2);
[b2,a2] = butter(n,Wn_BPF,'bandpass');
BPF_filtered_output = filter(b2,a2,y);

BPF_filtered_fft = fft(BPF_filtered_output);
N_BPF = length(BPF_filtered_fft);



subplot(2,2,1);
plot(Fs/L *(0:L-1),abs(Y),"Linewidth",3);
title('UF');
xlabel('f');
ylabel('X(f)');


subplot(2,2,2);
plot(Fs/N*(0:N-1),abs(LPF_filtered_fft),"Linewidth",3);
title('LPF');
xlabel('f');
ylabel('X(f)');

subplot(2,2,3);
plot(Fs/N1*(0:N1-1),abs(BPF_filtered_fft),"Linewidth",3);
title('BPF');
xlabel('f');
ylabel('X(f)');

subplot(2,2,4);
plot(Fs/N_BPF*(0:N_BPF-1),abs(HPF_filtered_fft),"Linewidth",3);
title('HPF');
xlabel('f');
ylabel('X(f)');


audiowrite("Z_Filtered_output.wav", BPF_filtered_output, Fs);
audiowrite("Z_LPF_HPF_filtered_output.wav",LPF_filtered_output,Fs);
