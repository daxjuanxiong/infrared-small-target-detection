% A Local Contrast Method for Infrared Small-Target Detection Utilizing a Tri-Layer Window
% tllcm:
% 目标框是4个不同的尺度 3 5 7 9
% 使用每个框前9个值计算平均值
% RLCM:
% 目标框的尺度为 9
% 使用每个框的前面的值计算平均值（多尺度）
function re = tllcm(img)
img = double(img);
gs  = [1/16, 1/8, 1/16;
    1/8, 1/4, 1/8;
    1/16, 1/8, 1/16];
gsimg = imfilter(img, gs, 'symmetric');
%% the scale is 3
out3 = subfunc(img, gsimg, 3);
%% the scale is 5
out5 = subfunc(img, gsimg, 5);
%% the scale is 7
out7 = subfunc(img, gsimg, 7);
%%  the scale is 9
out9 = subfunc(img, gsimg, 9);
%%
out = cat(3, out3, out5, out7, out9);
re = max(out, [], 3);
re(re<0) = 0;
if 0
    figure; imshow(out3, []);  title('scale 3x3');
    figure; surf(out3); title('scale 3x3');
    figure; imshow(out5, []);   title('scale 5x5');
    figure; surf(out5); title('scale 5x5');
    figure; imshow(out7, []);   title('scale 7x7');
    figure; surf(out7); title('scale 7x7');
    figure; imshow(out9, []);   title('scale 9x9');
    figure; surf(out9); title('scale 9x9');
    figure; imshow(re, []); title('re');
    figure; surf(re);
end
end
function re = subfunc(img, gsimg, len)
op31 = zeros(len*3); op31(1:len, 1:len) = 1/(len*len);
op32 = zeros(len*3); op32(1:len, len+1:2*len) = 1/(len*len);
op33 = zeros(len*3); op33(1:len, 2*len+1:3*len) = 1/(len*len);
op34 = zeros(len*3); op34(len+1:2*len, 1:len) = 1/(len*len);
op36 = zeros(len*3); op36(len+1:2*len, 2*len+1:3*len) = 1/(len*len);
op37 = zeros(len*3); op37(2*len+1:3*len, 1:len) = 1/(len*len);
op38 = zeros(len*3); op38(2*len+1:3*len, len+1:2*len) = 1/(len*len);
op39 = zeros(len*3); op39(2*len+1:3*len, 2*len+1:3*len) = 1/(len*len);
m31 = kmaxave(double(img), op31, 9);
m32 = kmaxave(double(img), op32, 9);
m33 = kmaxave(double(img), op33, 9);
m34 = kmaxave(double(img), op34, 9);
m36 = kmaxave(double(img), op36, 9);
m37 = kmaxave(double(img), op37, 9);
m38 = kmaxave(double(img), op38, 9);
m39 = kmaxave(double(img), op39, 9);
m3b = cat(3, m31, m32, m33, m34, m36, m37, m38, m39);
m3b = max(m3b, [], 3);
re = (gsimg./m3b-1).*gsimg; % 类似于rlcm，可能会出现负数
end
function ave = kmaxave(img, op, k)
[row, col] = size(img);
tt = zeros(row, col, k);
num = nnz(op);
jj = 1;
for ii = num:-1:num-k+1
    tt(:,:, jj) = ordfilt2(img, ii, op); % 排序
    jj = jj + 1;
end
ave = mean(tt, 3);
end
