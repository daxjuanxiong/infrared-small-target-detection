% 2013 A Robust Directional Saliency-Based Method for Infrared Small-Target Detection Under Various Complex Backgrounds
% directional saliencybased method (DSBM)
function re = dsbmfunc(img) % 效果好
img = double(img);
%% 1 Select appropriate orthogonal direction groups according to actual requirements.
%  channel 1 (α = 0 β = 90) and channel 2 (α = 90 β = 0),
%  channel 3 (α = 45 β = 45) and channel 4 (α = 135 β = 45)
%% 2 Do convolutions between weight kernels (3) and the
% original infrared image to compute fitting coefficients
W4 = [2 2 2 2 2;
    -1 -1 -1 -1 -1;
    -2 -2 -2 -2 -2;
    -1 -1 -1 -1 -1;
    2 2 2 2 2]/70;
W5 = [4 2 0 -2 -4;
    2 1 0 -1 -2;
    0 0 0 0 0;
    -2 -1 0 1 2;
    -4 -2 0 2 4]/100;
W6 = W4';
K4 = imfilter(img, W4, 'symmetric');
K5 = imfilter(img, W5, 'symmetric');
K6 = imfilter(img, W6, 'symmetric');
%% 3 Compute SODD maps for each directional channel using designed SODD
%  α 为射线 l 与图像 Y 轴的夹角; β 为射线 l 与图像 X 轴的夹角
alfa1 = 0; beta1 = pi/2;
fl1 = soddsub(K4, K5, K6, alfa1, beta1);
alfa2 = pi/2; beta2 = 0;
fl2 = soddsub(K4, K5, K6, alfa2, beta2);
alfa3 = pi/4; beta3 = pi/4;
fl3 = soddsub(K4, K5, K6, alfa3, beta3);
alfa4 = 3*pi/4; beta4 = pi/4;
fl4 = soddsub(K4, K5, K6, alfa4, beta4);
%% 4 Compute directional saliency maps for each channel using the PFT method
sm1 = pftsub(fl1);
sm2 = pftsub(fl2);
sm3 = pftsub(fl3);
sm4 = pftsub(fl4);
%% 5 Fuse directional saliency maps of all channels using the designed saliency fusing method
nm1 = normsub(sm1);
nm2 = normsub(sm2);
nm3 = normsub(sm3);
nm4 = normsub(sm4);
re = nm1.*nm2 + nm3.*nm4;
if 0
    figure;
    subplot(221); imshow(K4, []);
    subplot(222); imshow(K5, []);
    subplot(223); imshow(K6, []);
    figure; % alfa1 = 0; beta1 = pi/2;
    subplot(221); imshow(fl1, []);
    subplot(222); imshow(sm1, []);
    subplot(223); imshow(nm1, []);
    subplot(224); imshow(re, []);
    figure; % alfa2 = pi/2; beta2 = 0;
    subplot(221); imshow(fl2, []);
    subplot(222); imshow(sm2, []);
    subplot(223); imshow(nm2, []);
    subplot(224); imshow(re, []);
    figure; % alfa3 = pi/4; beta3 = pi/4;
    subplot(221); imshow(fl3, []);
    subplot(222); imshow(sm3, []);
    subplot(223); imshow(nm3, []);
    subplot(224); imshow(re, []);
    figure; % alfa4 = 3*pi/4; beta4 = pi/4;
    subplot(221); imshow(fl4, []);
    subplot(222); imshow(sm4, []);
    subplot(223); imshow(nm4, []);
    subplot(224); imshow(re, []);
end
end

function re = soddsub(K4, K5, K6, alfa, beta)
% 2次方向导数
fl = 2*K4*cos(alfa)^2 + 2*K5*cos(alfa)*cos(beta) + 2*K6*cos(beta)^2;
fl(fl>0) = 0;
fl = mat2gray(fl);
fl = 1- fl;
op = fspecial('average', [3 , 3]);
re = imfilter(fl, op, 'symmetric');
end

function s = pftsub(img)
% PFT: 高斯滤波器
% pftsub： disk滤波器
f = fft2(img);
p = angle(f);
t1 = exp(1i.*p);
t2 = ifft2(t1);
t3 = abs(t2).^2;
t3 = removeBorder(t3);
g = fspecial('gaussian', [3, 3], 2.5);
s = imfilter(t3, g, 'symmetric');
end
function re = normsub(img)
M = 1;
img = mat2gray(img)*M;
ind = imdilate(img, ones(3, 3)) == img; % 寻找局部最大值
val = img(ind);
val(val ==M) = []; % 寻找局部最大值（不包括全局最大值）
num = length(val);
if (num >= 1)
    m = mean(val);
    re = img * (M - m)^2;
    if 0
        figure; imshow(img, []);
        figure; imshow(re, []);
    end
else
    re = img;
end
end



