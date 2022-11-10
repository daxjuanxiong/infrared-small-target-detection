%
function re = cfarfunc(img)
% img = double(img);
% img = im2double(uint8(img));
[row, col] = size(img);
%% constant false alarm rate (CFAR)
se = ones(3, 7);
re1 = imopen(img, se);
P = 10e-4;
fai = norminv(P);
m = mean(re1(:));
sigma = std(re1(:), 1);% 分母是N,不是N-1
a = 3;
Th = m - a* fai*sigma;
Th = 0;
bw = re1 >Th;
%% Calculating LSM
len = 9;
r = floor(len/2);
pad = padarray(img, [len + r, len + r], 'both');
%% matlab roi函数
[yy, xx] = find(bw);
Wpkarr = [];
Lpkarr = [];
Mpkarr = [];
for kk = 1:length(yy)
    ii = yy(kk);
    jj = xx(kk);
    ii1 = ii + len + r;
    jj1 = jj + len + r;
    block = pad(ii1-len-r:ii1+len+r, jj1-len-r:jj1+len+r);
    b0 = block(len+1:2*len, len+1:2*len);
    Lpk = max(b0(:));
    Lpkarr = [Lpkarr; Lpk];  % 最大值
    %% 背景平均值
    b1 = block(1:len, 1:len);   m1 = mean(b1(:));
    b2 = block(1:len, len+1:2*len); m2 = mean(b2(:));
    b3 = block(1:len, 2*len+1:3*len); m3 = mean(b3(:));
    b4 = block(len+1:2*len, 1:len); m4 = mean(b4(:));
    b5 = block(len+1:2*len, 2*len+1:3*len); m5 = mean(b5(:));
    b6 = block(2*len+1:3*len, 1:len); m6 = mean(b6(:));
    b7 = block(2*len+1:3*len, len+1:2*len); m7 = mean(b7(:));
    b8 = block(2*len+1:3*len, 2*len+1:3*len); m8= mean(b8(:));
    Mpk = mean([m1, m2, m3, m4, m5, m6, m7, m8]); % 8个块中值的平均值
    Mpkarr = [Mpkarr; Mpk];
    %% 目标与背景的差
    ssd1 = sum ( (b0(:) - b1(:)).^2 );
    ssd2 = sum ( (b0(:) - b2(:)).^2 );
    ssd3 = sum ( (b0(:) - b3(:)).^2 );
    ssd4 = sum ( (b0(:) - b4(:)).^2 );
    ssd5 = sum ( (b0(:) - b5(:)).^2 );
    ssd6 = sum ( (b0(:) - b6(:)).^2 );
    ssd7 = sum ( (b0(:) - b7(:)).^2 );
    ssd8 = sum ( (b0(:) - b8(:)).^2 );
    wpk = mean([ssd1, ssd2, ssd3, ssd4, ssd5, ssd6, ssd7, ssd8] );
    Wpkarr = [Wpkarr; wpk]; % 中间块和周围8个块的相似度
end
Wpkarr = mat2gray(Wpkarr);
Cpkarr = Wpkarr.*Lpkarr.^2./Mpkarr;
re = Cpkarr;
re = zeros(row, col);
for kk = 1:length(yy)
    re(yy(kk), xx(kk)) = Cpkarr(kk);
end
% g = 0.6;
end