%  Tiny and Dim Infrared Target Detection Based on Weighted Local Contrast
% 1 目标与背景的对比度
% 2 目标与背景边缘的不连续性
function re = amwlcmfunc(img)
%% scale 1 3x3
ry1 = 3;
rx1 = 3;
re1 = awlcmsub(img, ry1, rx1);
%% scale 2 3x4
ry2 = 3;
rx2 = 4;
re2 = awlcmsub(img, ry2, rx2);
%% scale 3 4x3
ry3 = 4;
rx3 = 3;
re3 = awlcmsub(img, ry3, rx3);
%% scale 4 4x4
ry4 = 4;
rx4 = 4;
re4 = awlcmsub(img, ry4, rx4);
if 1
    temp = cat(3, re1, re2, re3, re4);
    re = max(temp, [], 3);
else
    %% scale 5 4x5
    ry5 = 4;
    rx5 = 5;
    re5 = awlcmsub(img, ry5, rx5);
    %% scale 6 3x5
    ry6 = 3;
    rx6 = 5;
    re6 = awlcmsub(img, ry6, rx6);
    %% scale 7 5x3
    ry7 = 5;
    rx7 = 3;
    re7 = awlcmsub(img, ry7, rx7);
    %% scale 8 5x4
    ry8 = 5;
    rx8 = 4;
    re8 = awlcmsub(img, ry8, rx8);
    %% scale 9 5x5
    ry9 = 5;
    rx9 = 5;
    re9 = awlcmsub(img, ry9, rx9);
    temp =cat(3, re1, re2, re3, re4, re5, re6, re7, re8, re9);
    re = max(temp, [], 3);
end
end

function re = awlcmsub(img, ry, rx)
img = double(img);
[row, col] = size(img);
if mod(ry, 2) ==1
    ylen1 =  floor( ry/2);
    ylen2 = floor( ry/2);
else
    ylen1 =  floor( ry/2) - 1;
    ylen2 = floor( ry/2);
end
if mod(rx, 2) ==1
    xlen1 =  floor( rx/2);
    xlen2 = floor( rx/2);
else
    xlen1 =  floor( rx/2) - 1;
    xlen2 = floor( rx/2);
end
pad = padarray(img, [ylen1, xlen1], 'symmetric', 'pre');
pad = padarray(pad, [ylen2, xlen2], 'symmetric', 'post');
opin = zeros(ry, rx);
opin(2:end-1,2:end-1) = 1;
opin = opin/sum(opin(:));
opout = ones(ry, rx);
opout(2:end-1,2:end-1) = 0;
opout = opout/sum(opout(:));
ain = imfilter(img, opin, 'symmetric');
aout = imfilter(img, opout, 'symmetric');
%% 计算目标与背景的对比度
D = abs(ain - aout); 
Dmax = max(D(:));
Dave = mean2(D);
beta = 0.8;
Td = beta*Dave + (1 - beta)*Dmax;
re = zeros(row, col);
W = zeros(row, col);
for ii = 1:row
    for jj = 1:col
        ii1 = ii + ylen1;
        jj1 = jj + xlen1;
        %% 计算目标与背景的交界处的灰度变化
        block = pad(ii1- ylen1:ii1+ylen2, jj1-xlen1:jj1+xlen2);
        d1 = block(1, 2:end-1) - block(2, 2:end-1);
        d2 = block(end, 2:end-1) - block(end-1, 2:end-1);
        d3 = block(2:end-1, 1) - block(2:end-1, 2);
        d4 = block(2:end-1, end) - block(2:end-1, end-1) ;
        k = sum(d1>=0) + sum(d2>=0) + sum(d3>=0)+sum(d4>=0);
        W(ii, jj) = 1/(1+k^2);
        if D(ii, jj) >= Td
            re(ii, jj) = D(ii, jj)*W(ii,jj);
        else
            re(ii, jj) = D(ii, jj);
        end
    end
end
end
