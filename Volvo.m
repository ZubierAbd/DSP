
if indice1<length(x1)/2 
    q1 = 1:(indice1 -1);
    p1 = indice1 + length(q1): -1 : indice1 + 1;
    length(p1);
    length(q1);
    x1_left = x1(q1);
    min(x1_left);
    x1_right = x1(p1);
    min(x1_right);
    error1 = mean((abs(x1_right - x1_left)).^2)
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
    error2 = mean((abs(x2_right - x2_left)).^2)
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
    error3 = mean((abs(x3_right - x3_left)).^2)
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
    error4 = mean((abs(x4_right - x4_left)).^2)
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
    error4 = mean((abs(x5_right - x5_left)).^2)
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