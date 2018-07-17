clc

clear all 

close all 

[Hello1,Fs1] = audioread('Hello_1.wav');

[Hello2,Fs2] = audioread('Hello_2.wav'); %different speaker hello
Hello2m = (Hello2(:,1) + Hello2(:,2))/2

Hello1 = Hello1 - mean(Hello1); 
Hello2 = Hello2m - mean(Hello2m); 
% 
sound(Hello1);
sound(Hello1);

%%%%%%%%%%%%
nfft = min(1023,length(Hello1)); %there might be an issue here with the window length
s1 = spectrogram(Hello1,hanning(511),380);
s2 = s1; 
sfft = fft(s1)
plot(abs(sfft))
% plot(s1)

absolute1 = transpose(abs(s1))
absolute2 = transpose(abs(s2))
a4 = sum(absolute1)
a5 = sum(absolute2)
a_4_norm = (a4-min(a4))/(max(a4)-min(a4))
a_5_norm = (a5-min(a5))/(max(a5)-min(a5))

F4 = transpose(a_4_norm)

F5 = transpose(a_5_norm)

[x3,lag3] = xcorr(F5,F4)
[mx3,indice3] = max(x3)
frequency_on_shift = lag3(indice3)


