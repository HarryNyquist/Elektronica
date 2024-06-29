%Bandpass trials
clc, clearvars;
[y,Fs] = audioread("Noise_Removal.wav");
Y = fftshift(fft(y));
N = length(y);
freq = (-N/2:N/2-1)*(Fs/N);

subplot(2,1,1);
plot(freq,abs(Y),"Linewidth",3);
title('UF');
xlabel('f');
ylabel('X(f)');

Wp = [400,2000]/(Fs/2); %Passband
Ws = [300,2200]/(Fs/2); %Stopband
Rp = 0.5;%Passband attenuation
Rs = 30; %Stopband attenuation

[n,Wn] = buttord(Wp,Ws,Rp,Rs);
[z,p,k] = butter(n,Wn,'bandpass');

[sos,g] = zp2sos(z,p,k);
filtered_output = filtfilt(sos,g,y);
gain = db2mag(10);
filtered_output = filtered_output * gain;
audiowrite("Z_Bandpass_Output.wav",filtered_output,Fs);

subplot(2,1,2)
plot(freq, abs(fftshift(fft(filtered_output))),"Linewidth",3);
title = ("Bandpass Filtering");
xlabel("f");
ylabel("X(f)");
