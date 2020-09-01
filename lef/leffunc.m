% Infrared Small Target Detection Based on Multiscale Local Contrast Measure Using Local Energy Factor
function re = leffunc(img)
alfa = 0.5;
h = 0.2;
%% scale 1
len = 1;
[s1, d1] = lefsub(img, len);
%% scale 3
len = 3;
[s3, d3] = lefsub(img, len);
%% scale 5
len = 5;
[s5, d5] = lefsub(img, len);
%% scale 7
len = 7;
[s7, d7] = lefsub(img, len);
%% scale 9
len = 9;
[s9, d9] = lefsub(img, len);
%%
sarr = cat(3, s1, s3, s5, s7, s9);
smin = min(sarr(:));
smax = max(sarr(:));

s1 = (s1 - smin)/(smax - smin);
s3 = (s3 - smin)/(smax - smin);
s5 = (s5 - smin)/(smax - smin);
s7 = (s7 - smin)/(smax - smin);
s9 = (s9 - smin)/(smax - smin);
%%
darr = cat(3, d1, d3, d5, d7, d9);
dmin = min(darr(:));
dmax = max(darr(:));
d1 = (d1 - dmin)/(dmax - dmin);
d3 = (d3 - dmin)/(dmax - dmin);
d5 = (d5 - dmin)/(dmax - dmin);
d7 = (d7 - dmin)/(dmax - dmin);
d9 = (d9 - dmin)/(dmax - dmin);

if 0
figure; imshow(s1, []);
figure; imshow(s3, []);
figure; imshow(s5, []);
figure; imshow(s7, []);
figure; imshow(s9, []);

figure; imshow(d1, []);
figure; imshow(d3, []);
figure; imshow(d5, []);
figure; imshow(d7, []);
figure; imshow(d9, []);
end
%%
re1 = exp( (alfa*(s1-1).^2 + (1-alfa)*(d1-1).^2) / (-2*h^2) );
re3 = exp( (alfa*(s3-1).^2 + (1-alfa)*(d3-1).^2) / (-2*h^2) );
re5 = exp( (alfa*(s5-1).^2 + (1-alfa)*(d5-1).^2) / (-2*h^2) );
re7 = exp( (alfa*(s7-1).^2 + (1-alfa)*(d7-1).^2) / (-2*h^2) );
re9 = exp( (alfa*(s9-1).^2 + (1-alfa)*(d9-1).^2) / (-2*h^2) );
re = max(cat(3, re1, re3, re5, re7, re9), [], 3);
end
function [s, d] = lefsub(img, len)
img = double(img);
[row, col] = size(img);
%% d 计算像素点与8个背景块的灰度均值的差 （公式5）
lenx = floor(len/2) ;
leny = floor(len/2) ;
cx = len + lenx+ 1;
cy = len + leny + 1;
op = ones(3*len, 3*len);
op(cy -leny:cy+leny, cx-lenx:cx+lenx ) = 0;
op = op/sum(op(:));
imgm = imfilter(img, op, 'symmetric');
d = img - imgm;
%% s
s = zeros(row, col);
pad = padarray(img, [len + leny, len + lenx], 'symmetric');
for ii = 1:row
    for jj =1:col
        ii1 = ii + len + leny;
        jj1 = jj + len + lenx;
        block = pad(ii1 - len-leny: ii1 +  len +leny, jj1 - len-lenx: jj1 +  len +lenx);
        s(ii, jj) = blockfunc(block, len);
    end
end
end
function  s= blockfunc(block, len)
x1 = block(1:len, 1:len); x1 = x1(:);
x2 = block(1:len, len+1:len*2); x2 = x2(:);
x3 = block(1:len, len*2+1:len*3); x3 = x3(:);
x8 = block(len+1:len*2, 1:len); x8 = x8(:);
x0 = block(len+1:len*2, len+1:len*2); x0 = x0(:);
x4 = block(len+1:len*2, len*2+1:len*3); x4 = x4(:);
x7 = block(len*2+1:len*3, 1:len); x7 = x7(:);
x6 = block(len*2+1:len*3, len+1:len*2); x6 = x6(:);
x5 = block(len*2+1:len*3, len*2+1:len*3); x5 = x5(:);
X = [x0, x1, x2, x3, x4, x5, x6, x7, x8];
X = X - repmat(mean(X, 2), 1, 9);
E = norm(X,'fro')^2;
X1 =  [x1, x2, x3, x4, x5, x6, x7, x8];
X1 = X1 - repmat(mean(X1, 2), 1, 8);
E1 = norm(X1,'fro')^2;
s = (E/9 - E1/8)/(E/9); % 公式4 当区域的灰度级完全相同时，会出现0除以0
end
