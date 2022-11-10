% 2016 Effective Infrared Small Target Detection Utilizing a Novel Local Contrast Method
%% ilcm
% 1 ilcm的块分割
% 2 目标框最大值*目标框均值/ 背景框均值的最大值
%% nlcm
% 1: 背景估计,增强目标
% 2: ilcm的块分割
% 3 目标框K个最大值与目标框均值的差的平方和*目标框K个最大值的均值/ 背景框K个最大值均值的最大值
% 1 2 3
% 4    5
% 6 7 8
function re = nlcmfunc(img)
img = double(img);
%% preprocessing
g1 = [1 4 6 4 1;
    4 16 24 16 4;
    6 24 36 24 6;
    4 16 24 16 4;
    1 4 6 4 1]/256;
g2 = ones(5)/25;
dog = g1 - g2;
g = imfilter(img, dog, 'replicate');
%     figure; imshow(g, []);
%%  NLCM1
bs = 12;
K = 3;
%% NLCM2
% bs = 10;
% K = 2;
re = subfunc(g, bs, K);
end
function out1 = subfunc(img, reg_size, K)
%% 分块的方法与ilcm相同
[nrows,ncols]=size(img);
stp_size=reg_size/2;
pad_nr=mod(nrows-reg_size,stp_size);
pad_nc=mod(ncols-reg_size,stp_size);
pad_r=0;
if (pad_nr ~= 0)
    pad_r=stp_size-pad_nr;
end
pad_c=0;
if (pad_nc ~= 0)
    pad_c=stp_size-pad_nc;
end
img_pad=padarray(img,[pad_r pad_c],'replicate','post');
[nrows1,ncols1]=size(img_pad);
a=ceil((nrows1-reg_size)/(stp_size))+1;
b=ceil((ncols1-reg_size)/(stp_size))+1;
IVaru=zeros(a,b);
IMeani=zeros(a,b);
for i=1:a
    for j=1:b
        temp=img_pad(stp_size*(i-1)+1:stp_size*(i-1)+reg_size,stp_size*(j-1)+1:stp_size*(j-1)+reg_size);
        tt = sort(temp(:), 'descend');
        I0 = tt(1:K);
        m= mean(temp(:));
        IVari = sum( (I0 - m).^2 );
        IVaru(i, j) = IVari;
        IMeani(i, j) = mean(I0);
    end
end
tt=imdilate(IMeani,[1 1 1;1 0 1;1 1 1]);
out=IVaru.*IMeani./tt;
%%
out2 = zeros(nrows,ncols);
for i=1:a
    for j=1:b
        out2(stp_size*(i-1)+1:stp_size*(i-1)+reg_size,stp_size*(j-1)+1:stp_size*(j-1)+reg_size) = out(i,j);
    end
end
out1 = imresize(out, size(img), 'bilinear');
if 0 
    figure; imshow(out, []);
    figure; imshow(out1, []);
    figure; imshow(out2, []);
end
end