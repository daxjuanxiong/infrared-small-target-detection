% High-Boost-Based Multiscale Local Contrast Measure for Infrared Small Target Detection
% 1 先使用背景估计法增强目标，抑制背景
% 2 计算目标框与背景框的对比度
% 3 多尺度下，最大对比度值与最小对比度值的差的平方
function re = hbmlcmfunc(img)
img = double(img);
op = fspecial('average', 9); % improved high boost filter 的大小论文并没有给出
Im = imfilter(double(img), op, 'symmetric');
Ihp = img - Im;
Ihp(Ihp<0) = 0;
ihbf = img.*Ihp;
%% scae 3
d3 = subfunc(ihbf, 3);
%% scae 5
d5 = subfunc(ihbf, 5);
%% scae 7
d7 = subfunc(ihbf, 7);
%% scae 9
d9 = subfunc(ihbf, 9);
%%
out = cat(3, d3, d5, d7, d9);
dmin = min(abs(out), [], 3);
dmax = max(abs(out), [], 3);
re = (dmax - dmin).^2;
end
function d = subfunc(ihbf, len)
top = ones(len)/(len*len) ;
r = floor(len/2);
bop = ones(15); % the size of the external window is fixed and it is set to 15 × 15 pixels in experiments
bop(8-r:8+r, 8-r:8+r) = 0;
bop = bop/sum(bop(:));
mt = imfilter(double(ihbf), top, 'symmetric');
mb =  imfilter(double(ihbf), bop, 'symmetric');
d = mt - mb;
end

