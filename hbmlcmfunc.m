% 2018 High-Boost-Based Multiscale Local Contrast Measure for Infrared Small Target Detection
% 1 先使用背景估计法增强目标，抑制背景
% 2 计算目标框与背景框的对比度
% 3 在4个尺度中，最大对比度值与最小对比度值差的平方作为对比度
function re = hbmlcmfunc(img)
img = double(img);
op = fspecial('average', 9); % improved high boost filter 的大小论文并没有给出
Im = imfilter(double(img), op, 'replicate');
Ihp = img - Im;
Ihp(Ihp<0) = 0;
ihbf = img.*Ihp;
%%
d3 = subfunc(ihbf, 3); % scae 3
d5 = subfunc(ihbf, 5); % scae 5
d7 = subfunc(ihbf, 7); % scae 7
d9 = subfunc(ihbf, 9); % scae 9
out = cat(3, d3, d5, d7, d9);
dmin = min(abs(out), [], 3);
dmax = max(abs(out), [], 3);
re = (dmax - dmin).^2;
end
function d = subfunc(ihbf, len)
opt = ones(len)/(len*len) ;
opb = ones(15); % the size of the external window is fixed and it is set to 15 × 15 pixels in experiments
r = floor(len/2);
opb(8-r:8+r, 8-r:8+r) = 0;
opb = opb/sum(opb(:));
mt = imfilter(double(ihbf), opt, 'replicate');
mb =  imfilter(double(ihbf), opb, 'replicate');
d = mt - mb;
end

