% A Double-Neighborhood Gradient Method for Infrared Small Target Detection
% 1    2     3   4    5
% 6    7     8   9   10
% 11 12   13  14  15
% 16 17   18   19   20
% 21 22   23   24   25
function re = dgradfunc(img)
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

m2 = gimg;
m2(:,:, [1:6, 10:11, 13, 15:16, 20:25]) = [];
t2 = repmat(gimg(:, :, 13), 1,1,8) - m2;
t2(t2<=0) = 0;
d2 = min(t2, [], 3);

re = d1.*d2;
end
