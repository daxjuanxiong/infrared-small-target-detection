% 2020 A Novel and High-Speed Local Contrast Method for Infrared Small-Target Detection
%% hbmlcmfunc.m  High-boost-based multiscale local contrast measure for infrared small target detection
% 1：高通滤波
% 2：目标均值^2*背景均值^2*（目标均值-背景均值)^2
function C = nhbf_ilcmfunc(img)
flag = 0;
img = double(img);
op = fspecial('average', 9); % improved high boost filter 的大小论文并没有给出
Im = imfilter(double(img), op, 'replicate');
Ihp = img - Im;
if flag
    figure; imshow(Ihp, []);
end
Ihp(Ihp<=0) = 0;
if flag
    figure; imshow(Ihp, []);
end
ihbf = Ihp*1.2;
%%  a main way of average filter to
% implement preprocessing
%%
sz = 3;
opt = ones(sz) ;
opb = ones(sz*3);
opb(sz+1:2*sz, sz+1:2*sz) = 0;
opb = opb/sum(opb(:));
L3 = imdilate(ihbf, opt);
mt = imfilter(ihbf, opt, 'replicate');
mb =  imfilter(ihbf, opb, 'replicate');
d = mt - mb;
C = (L3.*mb).^2.*d.^2;
if flag
    figure; imshow(L3, []);
    figure; imshow(mb, []);
    figure; imshow(d, []);
end
end