% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
% 1 多尺度： 目标框的尺度3x3 - 9x9，背景框的尺度19x19，计算对比度 （置零）
% 2 计算4个方向目标区域与背景区域的梯度 （置零）
% 3 对比度与梯度相乘
function re = aadcddfunc(img)
img = double(img);
%% scale 3
out3 = subfunc(img, 3);
%% scale 5
out5 = subfunc(img, 5);
%% scale 7
out7 = subfunc(img, 7);
%%  scale 9
out9 = subfunc(img, 9);
%%
out = cat(3, out3, out5, out7, out9);
re = max(out, [], 3);
if 0
    figure; imshow(out3, []);  title('scale 3x3');
    figure; imshow(out5, []);   title('scale 5x5');
    figure; imshow(out7, []);   title('scale 7x7');
    figure; imshow(out9, []);   title('scale 9x9');
    figure; imshow(uint8(img));
    figure; imshow(re, []);
end
end
function re = subfunc(img, len)
top = ones(len)/(len*len);
mt = imfilter(double(img), top, 'replicate');
bop = ones(19 , 19);
r = floor(len/2);
bop(10-r:10+r, 10-r:10+r) = 0;
bop = bop/sum(bop(:));
mb = imfilter(double(img), bop, 'replicate');
D1 = (mt - mb ).^2.*(mt - mb >=0);
%%
op1 = zeros(len+2, len+2);
op2 = op1;
op3 = op1;
op4 = op1; 
op1(r+2, r+2:end-1) = 1;
op1(r+2, end) = -(r+1);
op2(r+2, 2:r+2) = 1;
op2(r+2, 1) = -(r+1);
op3(r+2:end-1, r+2) = 1;
op3(end, r+2) = -(r+1);
op4(2:r+2, r+2) = 1;
op4(1, r+2) = -(r+1);

g1 = imfilter(img, op1, 'replicate');
g1 = g1.*(g1>=0);
g2 = imfilter(img, op2, 'replicate');
g2 = g2.*(g2>=0);
g3 = imfilter(img, op3, 'replicate');
g3 = g3.*(g3>=0);
g4= imfilter(img, op4, 'replicate');
g4 = g4.*(g4>=0);
temp =cat(3, g1, g2, g3, g4);
D2 = min(temp, [], 3);
re = D1.*D2;
end