clc, clearvars;
x = [1,2,3];
h = [4;5;6];

y = convolution_sum(x,h)

x1 = [12,14,16,18,20];
h1 = [45;50;55];

y2 = convolution_sum(x1,h1)
