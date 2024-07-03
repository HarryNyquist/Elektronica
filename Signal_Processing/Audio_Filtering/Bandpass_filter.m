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


Wp_notch =  [1320,1480]/(Fs/2);
Ws_notch = [1380,1420]/(Fs/2);
[n_notch,Wn_notch] = buttord(Wp_notch,Ws_notch,Rp,Rs);
[z_n, p_n, k_n] = butter(n_notch, Wn_notch, 'stop');
[sos_n,g_n] = zp2sos(z_n, p_n, k_n);
penultimate_output = filtfilt(sos_n,g_n,filtered_output);

Wp_bs = [820,980]/(Fs/2);
Ws_bs = [880,920]/(Fs/2);
[n_bs, Wn_bs] = buttord(Wp_bs,Ws_bs,Rp,Rs);
[z_bs,p_bs,k_bs] = butter(n_bs,Wn_bs,'stop');
[sos_bs,g_bs] = zp2sos(z_bs,p_bs,k_bs);
final_output = filtfilt(sos_bs, g_bs, penultimate_output);
audiowrite("Filtered_output.wav",final_output,Fs);

subplot(2,1,2);
plot(freq,abs(fftshift(fft(final_output))),"Linewidth",3);
title('Final');
xlabel('f');
ylabel('X(f)');

%{
subplot(4,1,3);
plot(freq,abs(fftshift(fft(penultimate_output))),"Linewidth",3);
title('BPF + Notch');
xlabel('f');
ylabel('X(f)');

subplot(4,1,2)
plot(freq, abs(fftshift(fft(filtered_output))),"Linewidth",3);
title = ('BP');
xlabel('freq');
ylabel('B(f)');
%}



