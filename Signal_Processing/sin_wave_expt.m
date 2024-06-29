clc, clearvars;
Fs = 8000;
N = 408226;
f1 = 1400;
t = (0:N-1)*(1/Fs);

A1 = 0.023;
x = A1* sin(2*pi*f1*t);
X = fft(x);
freq = (-N/2:N/2 - 1) * (Fs/N);

figure(1)
plot(freq,abs(fftshift(X)),"Linewidth",3);
title('sin wave');
xlabel('f');
ylabel('X(f)');

%{
f1 = 1400;
f2 = 900;
t = (0:N-1)*(1/Fs);
A1 = 0.023;
A2 = 0.0423;
x_transpose = A1* sin(2*pi*f1*t) + A2 * sin(2*pi*f2*t);
x = x_transpose.';
X = fft(x);
%}
