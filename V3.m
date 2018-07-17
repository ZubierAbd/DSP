%% 
clc 

clear all 

close all 

%the system will identify what word was said from a group of reference
%words


[Hello1,Fs1] = audioread('Hello_4.wav');
[Girl1,Fs2] = audioread('Girl.wav') ;
[Test1,Fs3] = audioread('Cat2.wav');
[House1,Fs4] = audioread('House_1.wav');
[Cat1,Fs5] = audioread('Cat.wav');
[Boy1,Fs6] = audioread('Boy.wav');

sound(Hello1,Fs1)
% pause
sound(Girl1,Fs1)
% pause
sound(Test1,Fs1)
% pause
% sound(House1,Fs1)
% pause
% sound(Cat1,Fs1)
% pause
% sound(Boy1,Fs1)
% pause
% sound(Hello1,Fs1)

%% 
% Test2 = Test1;

Test1 = awgn(Test1,-3); 

%This is where we add AWGN to the test word
% Test3 = awgn(Test2,10);
% Test4 = awgn(Test2,1);
% Test5 = awgn(Test2,0.1);

%since the Girl sound file is mono, we do not need to convert it. 
% sound(Hello1)
% pause
% sound(Hello1,Fs1)
% pause
% sound(Girl1,Fs2)
%% 

H1 = Hello1 - mean(Hello1);
G1 = Girl1 - mean(Girl1);
Ho1 = House1 - mean(House1);
T1 = Test1 - mean(Test1);
C1 = Cat1 - mean(Cat1);
B1 = Boy1 - mean(Boy1);
%% 
% T1 = awgn(T1,0)

%sound(Hello1) %Removal of the dc component changes the quality of the voice sample 
%% 

s1 = spectrogram(H1,hanning(512),380);
s2 = spectrogram(G1,hanning(512),380);
s3 = spectrogram(T1,hanning(512),380); %THIS IS TEST WORD
s4 = spectrogram(Ho1,hanning(512),380);
s5 = spectrogram(Cat1,hanning(512),380);
s6 = spectrogram(B1,hanning(512),380);

ar1 = transpose(abs(s1));
ar2 = transpose(abs(s2));
ar3 = transpose(abs(s3));
ar4 = transpose(abs(s4));
ar5 = transpose(abs(s5));
ar6 = transpose(abs(s6));

a11 = sum(ar1);
a21 = sum(ar2);
a31 = sum(ar3);
a41 = sum(ar4);
a51 = sum(ar5);
a61 = sum(ar6);

a1_norm = (a11-min(a11))/(max(a11)-min(a11));

a2_norm = (a21-min(a21))/(max(a21)-min(a21));

a3_norm = (a31-min(a31))/(max(a31)-min(a31));

a4_norm = (a41-min(41))/(max(a41)-min(a41));

a5_norm = (a51-min(a51))/(max(a51)-min(a51));

a6_norm = (a61-min(a61))/(max(a61)-min(a61));

FA1 = transpose(a1_norm); %Reference signal 1
FA2 = transpose(a2_norm);%Reference signal 2 
FA3 = transpose(a3_norm); %Test signal
FA4 = transpose(a4_norm);
FA5 = transpose(a5_norm);
FA6 = transpose(a6_norm);
%% 

[x1,lag1] = xcorr(FA3,FA1); %This is for s1 and s3
[mx1,indice1] = max(x1);
Frequency_shift1 = lag1(indice1);


[x2,lag2] = xcorr(FA3,FA2); %This is for s2 and s3
[mx2,indice2] = max(x2);
Frequency_shift2 = lag2(indice2);

[x3,lag3] = xcorr(FA3,FA4); %This is for s3 and s4
[mx3,indice3] = max(x3);
Frequency_shift3 = lag3(indice3);

[x4,lag4] = xcorr(FA3,FA5); %This is for s3 and s5
[mx4,indice4] = max(x4);
Frequency_shift4 = lag4(indice4);

[x5,lag5] = xcorr(FA3,FA6); %This is for s5 and s3
[mx5,indice5] = max(x5);
Frequency_shift5 = lag5(indice5);

%At this point we have all of the words cross correlated with the test word
%as well as their freqeuency shifts 

figure(1)
subplot(2,3,1)
plot(abs(s1))
grid on 
xlim([0 150])
title(' spectrum for Reference Word - Hello')
subplot(2,3,2)
plot(abs(s2))
grid on 
xlim([0 150])
title(' spectrum for Reference word - Girl')
subplot(2,3,3)
plot(abs(s3))
grid on 
xlim([0 150])
title(' spectrum for Test word') 

subplot(2,3,4)
plot(abs(s4))
grid on 
xlim([0 150])
title(' spectrum for Reference word - House')

subplot(2,3,5)
plot(abs(s5))
grid on 
xlim([0 150])
title(' spectrum for Reference word - Cat ') 

subplot(2,3,6)

grid on 
plot(abs(s6))
xlim([0 150])
title(' spectrum for Reference word - Boy')


figure (2); 
subplot(2,3,1)
plot(FA1)
grid on 
xlim([0 150])
title('Normalized spectrum for Reference Word - Hello')
subplot(2,3,2)

plot(FA2)
grid on 
xlim([0 150])
title('Normalized spectrum for Reference word - Girl')
subplot(2,3,3)
plot(FA3)
grid on 
xlim([0 150])
title('Normalized spectrum for Test word') 

subplot(2,3,4)
plot(FA4)
grid on 
xlim([0 150])
title('Normalized spectrum for Reference word - House')

subplot(2,3,5)
plot(FA5)
grid on 
xlim([0 150])
title('Normalized spectrum for Reference word - Cat ') 

subplot(2,3,6)
grid on 
plot(FA6)
xlim([0 150])
title(' Normalized spectrum for Reference word - Boy')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure (3); 
subplot(2,1,1)
plot(x1)
title('Xcorr of Test word and Hello')
grid on 
subplot(2,1,2)
plot(x2)
title('Xcorr of Test word and Girl')
grid on 
figure(4)

subplot(2,1,1)
plot(x3)
title('Xcorr of Test word and House')
grid on 

subplot(2,1,2)
plot(x4)
title('Xcorr of Test word and Cat') 
grid on 

figure(5)
grid on 
subplot(2,1,1)
plot(x5)
title('Xcorr of Test word and Boy')
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if abs(abs(Frequency_shift1) -  abs(Frequency_shift2)) >= 2 
%     if abs(Frequency_shift1) > abs(Frequency_shift2)
%         off = off + 1;
%     else 
%         on = on + 1
%         test = 1; 
%     end 
%     Frequency_shift1;
%     Frequency_shift2 ;
%     test ;
%     if on>off
%         display('the test word is the first word')
%     else 
%         display('The test word is the second word')
%     end
%     
% else 


if indice1<length(x1)/2 
    q1 = 1:(indice1 -1);
    p1 = indice1 + length(q1): -1 : indice1 + 1;
    length(p1);
    length(q1);
    x1_left = x1(q1);
    min(x1_left);
    x1_right = x1(p1);
    min(x1_right);
    error1 = mean((abs(x1_right - x1_left)).^2);
else 
    q1 = 1 + Frequency_shift1*2: indice1 - 1;
    p1 = length(x1): -1: indice1 +1; 
    length(p1);
    length(q1);
    x1_left = x1(q1);
    x1_right = x1(p1);
    error1 = mean((abs(x1_right - x1_left)).^2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if indice2<length(x2)/2 
    q2 = 1:(indice2 -1);
    p2 = indice2 + length(q2): -1 : indice2 + 1;
    length(p2);
    length(q2);
    x2_left = x2(q2);
    min(x2_left);
    x2_right = x2(p2);
    min(x2_right);
    error2 = mean((abs(x2_right - x2_left)).^2);
else 
    q2 = 1 + Frequency_shift2*2: indice2 - 1;
    p2 = length(x2): -1: indice2 +1; 
    length(p2);
    length(q2);
    x2_left = x2(q2);
    x2_right = x2(p2);
    error2 = mean((abs(x2_right - x2_left)).^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if indice3<length(x3)/2 
    q3 = 1:(indice3 -1);
    p3 = indice3 + length(q3): -1 : indice3 + 1;
    length(p3);
    length(q3);
    x3_left = x3(q3);
    min(x3_left);
    x3_right = x3(p3);
    min(x3_right);
    error3 = mean((abs(x3_right - x3_left)).^2);
else 
    q3 = 1 + Frequency_shift3*2: indice3 - 1;
    p3 = length(x3): -1: indice3 +1; 
    length(p3);
    length(q3);
    x3_left = x3(q3);
    x3_right = x3(p3);
    error3 = mean((abs(x3_right - x3_left)).^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if indice4<length(x4)/2 
    q4 = 1:(indice4 -1);
    p4 = indice4 + length(q4): -1 : indice4 + 1;
    length(p4);
    length(q4);
    x4_left = x4(q4);
    min(x4_left);
    x4_right = x4(p4);
    min(x4_right);
    error4 = mean((abs(x4_right - x4_left)).^2);
else 
    q4 = 1 + Frequency_shift4*2: indice4 - 1;
    p4 = length(x4): -1: indice4 +1; 
    length(p4);
    length(q4);
    x4_left = x4(q4);
    x4_right = x4(p4);
    error4 = mean((abs(x4_right - x4_left)).^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if indice5<length(x5)/2 
    q5 = 1:(indice5 -1);
    p5 = indice5 + length(q5): -1 : indice5 + 1;
    length(p5);
    length(q5);
    x5_left = x5(q5);
    min(x5_left);
    x5_right = x5(p5);
    min(x5_right);
    error5 = mean((abs(x5_right - x5_left)).^2);
else 
    q5 = 1 + Frequency_shift5*2: indice5 - 1;
    p5 = length(x5): -1: indice5 +1; 
    length(p5);
    length(q5);
    x5_left = x5(q5);
    x5_right = x5(p5);
    error5 = mean((abs(x5_right - x5_left)).^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ans = min([error1,error2,error3,error4,error5]);
errormat = [error1,error2,error3,error4,error5]

if ans == error1
    display('the test word is the closest match to the first word - Hello')
elseif ans == error2
    display('The test word is the closest match to the  word - Girl')
elseif ans == error3
    display('The test word is the closest match to the  word - House')
elseif ans == error4
    display('The test word is the closest match to the  word - Cat')
elseif ans == error5
    display('The test word is the closest match to the  word - Boy')
end


    
% figure(6)
% subplot(5,1,1)
% plot(Test1)
% title('SNR 50')
% grid on
% subplot(5,1,2)
% plot(Test2)
% title('No AWGN')
% grid on
% subplot(5,1,3)
% plot(Test3)
% title('SNR 10')
% grid on
% subplot(5,1,4)
% plot(Test4)
% title('SNR 1')
% subplot(5,1,5)
% grid on
% plot(Test5)
% title('SNR 0.1')
% grid on



