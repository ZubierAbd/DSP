clc 

clear all 

close all 

%the system will identify what word was said from a group of reference
%words

on = 0;
off = 0; 
test = 0; 

[Hello1,Fs1] = audioread('Hello_1.wav');
[Girl1,Fs2] = audioread('Girl.wav') ;
[Test1,Fs3] = audioread('Hello_1.wav')

%since the Girl sound file is mono, we do not need to convert it. 
% sound(Hello1)
% pause
% sound(Hello1,Fs1)
% pause
% sound(Girl1,Fs2)

H1 = Hello1 - mean(Hello1)
G1 = Girl1 - mean(Girl1)
T1 = Test1 - mean(Test1)
% T1 = awgn(T1,0)

%sound(Hello1) %Removal of the dc component changes the quality of the voice sample 

s1 = spectrogram(H1,hanning(512),380);
s2 = spectrogram(G1,hanning(512),380);
s3 = spectrogram(T1,hanning(512),380);

a1 = transpose(abs(s1))
a2 = transpose(abs(s2))
a3 = transpose(abs(s3))

a4 = sum(a1)
a5 = sum(a2)
a6 = sum(a3)

a4_norm = (a4-min(a4))/(max(a4)-min(a4))

a5_norm = (a5-min(a5))/(max(a5)-min(a5))

a6_norm = (a6-min(a6))/(max(a4)-min(a4))

F4 = transpose(a4_norm) %Reference signal 1
F5 = transpose(a5_norm) %Reference signal 2 
F6 = transpose(a6_norm) %Test signal

[x3,lag3] = xcorr(F6,F4) %x3 is the correlation of R1 and T1
[mx3,indice3] = max(x3)

Frequency_shift1 = lag3(indice3)


[x4,lag4] = xcorr(F6,F5) %X4 is the correlation of R2 and T1
[mx4,indice4] = max(x4)

Frequency_shift2 = lag4(indice4)

figure(1)
subplot(2,3,1)
plot(abs(s1))
title('Reference signal 1 - Hello')
subplot(2,3,2)
plot(abs(s2))
title('Reference Signal 2 - Girl')
subplot(2,3,3)
plot(abs(s3))
title('Test signal - Hello') 

subplot(2,3,4)
plot(F4)
title(' 1st word normalized')

subplot(2,3,5)
plot(F5)
title('second word normalized') 

subplot(2,3,6)
plot(F6)
title('test word normalized spectrum')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if abs(abs(Frequency_shift1) -  abs(Frequency_shift2)) >= 2 
    if abs(Frequency_shift1) > abs(Frequency_shift2)
        off = off + 1;
    else 
        on = on + 1
        test = 1; 
    end 
    Frequency_shift1;
    Frequency_shift2 ;
    test ;
    if on>off
        display('the test word is the first word')
    else 
        display('The test word is the second word')
    end
    
else 

if indice3<length(x3)/2 
    q = 1:(indice3 -1);
    p = indice3 + length(q): -1 : indice3 + 1;
    length(p);
    length(q);
    x3_left = x3(q);
    min(x3_left);
    x3_right = x3(p);
    min(x3_right);
    error1 = mean((abs(x3_right - x3_left)).^2)
else 
    q = 1 + Frequency_shift1*2: indice3 - 1;
    p = length(x3): -1: indice3 +1; 
    length(p);
    length(q);
    x3_left = x3(q);
    x3_right = x3(p);
    error1 = mean((abs(x3_right - x3_left)).^2);
end

if indice4 < length(x4)/2 
    q2 = 1: indice4 -1;
    p2 = indice4 + length(q2): -1 : indice4 +1;
    x4_left = x4(q2);
    length(q2);
    length(p2);
    min(x4_left);
    
    x4_right = x4(p2);
    min(x4_right);
    error2 = mean((abs(x4_right-x4_left).^2));
else 
    q2 = 1 + Frequency_shift2*2:indice4 -1
    p2 = length(x4): -1: indice4 +1;
    length(q2);
    length(p2);
    x4_left = x4(q2);
    x4_right = x4(p2);
    error2 = mean((abs(x4_right-x4_left).^2))
end
if error1>error2
    off = off +1;
    test = 0;
else 
    on = on + 1;
    test = 1;
end
end 

on 
off 
error1 %error1 is the mean squared error of the cross correlation of R1 and T1 . Since the words are identical, the error should be very small.
error2  %error 2 is the mean squared error of the cross correlation of R2 and T1. The error is larger since the words are not the same
Frequency_shift1
Frequency_shift2

test

if on>off
    display('The test word is a match for the first word') 
    if on==off
        display('The words are too close to be able to tell apart')
    end
else 
    display('the test word is a match for the second reference word') 
end 


    





