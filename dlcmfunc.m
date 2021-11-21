% 基于双层局部对比度的红外弱小目标检测方法
% 1    2     3   4    5
% 6    7     8   9   10
% 11 12   13  14  15
% 16 17   18   19   20
% 21 22   23   24   25
function re = dlcmfunc(img)
img = double(img);
[row, col] = size(img);
len = 3;
nr = 5;
nc = 5;
leny = len*nr;
lenx=  len*nc;
op = zeros(leny, lenx, nr*nc);
for ii = 1:nr*nc    
    temp = zeros(len*nr,  len*nc);
    [r, c]  = ind2sub([nr, nc], ii);
    temp((r-1)*len + 1:r*len, (c-1)*len+1:c*len) = 1;
    temp = temp/sum(temp(:));
    temp = temp';
    op(:, :, ii) = temp;
end
%%
gimg = zeros(row, col, nr*nc);
for ii = 1:nr*nc
    gimg(:, :, ii) = imfilter(img, op(:,:, ii), 'replicate');
end
m1 = gimg;
m1(:,:, [7:9, 12:14, 17:19]) = [];

t1 = repmat(gimg(:, :, 13), 1,1,16) - m1;
t1(t1<=0) = 0;
d1 = min(t1, [], 3);
%%
c1 = gimg(:,:,13) - gimg(:,:,7); c1(c1<=0) = 0;
c2 = gimg(:,:,13) - gimg(:,:,8); c2(c2<=0) = 0;
c3 = gimg(:,:,13) - gimg(:,:,9); c3(c3<=0) = 0;
c4 = gimg(:,:,13) - gimg(:,:,12); c4(c4<=0) = 0;
c5 = gimg(:,:,13) - gimg(:,:,14);  c5(c5<=0) = 0;
c6 = gimg(:,:,13) - gimg(:,:,17); c6(c6<=0) = 0;
c7 = gimg(:,:,13) - gimg(:,:,18); c7(c7<=0) = 0;
c8 = gimg(:,:,13) - gimg(:,:,19); c8(c8<=0) = 0;
dot1 = c1.*c8;
dot2 = c2.*c7;
dot3 = c3.*c6;
dot4 = c4.*c5;
t2 = cat(3, dot1, dot2, dot3, dot4);
d2 = min(t2, [], 3);
re = d1.*d2;
end