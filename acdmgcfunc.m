% 2017 Small target detection based on difference accumulation and Gaussian curvature under complex conditions
function [re, con, K] = acdmgcfunc(img)
img = double(img);
M = 5; % 2.5
N = 9; % 4.5
t = 0.5;
%% contrast
% gaussian filtering
op = fspecial('gaussian', [3, 3]);
img = imfilter(img, op, 'replicate');
%  difference accumulation, clustering
[c21, c22, c23, c24, c25, c26, c27, c28] = gradsub(img, 3, 3, 1); % 半径为3
[c31, c32, c33, c34, c35, c36, c37, c38] = gradsub(img, 4, 4, 1); % 半径为4
d1 = c21 + c31;
d2 = c22 + c32;
d3 = c23 + c33;
d4 = c24 + c34;
d5 = c25 + c35;
d6 = c26 + c36;
d7=  c27 + c37;
d8 = c28 + c38;
con = sort(cat(3, d1, d2, d3, d4, d5, d6, d7, d8), 3); %升序排列
con = ostufunc(con, t); 
%% gaussian curvature
ii = 5;
s = ii/sqrt(2);
w = floor(3*s);
[x, y]=meshgrid(-w:w,-w:w);
dxx = 1/(2*pi*s^4).*(x.^2-s^2).*exp(-(x.^2+y.^2)/(2*s^2));
dyy = 1/(2*pi*s^4) .* (y.^2-s^2).*exp(-(x.^2+y.^2)/(2*s^2));
dxy = 1/(2*pi*s^4) .* (x.*y).*exp(-(x.^2+y.^2)/(2*s^2));
fxx=imfilter(img,dxx, 'replicate'); %fxx(fxx>=0) = 0;
fyy=imfilter(img,dyy, 'replicate'); %fyy(fyy>=0) = 0;
fxy=imfilter(img,dxy, 'replicate');
K  = fxx.*fyy-fxy.^2; 
re = con.*abs(K);
end

function con = ostufunc(in, t) % 分类
u =  mean(in, 3);
sigmaB = zeros(size(in, 1), size(in, 2), size(in, 3) -1);
u0arr =  zeros(size(in, 1), size(in, 2), size(in, 3) -1);
u1arr =   zeros(size(in, 1), size(in, 2), size(in, 3) -1);
for kk = 1:7
    u0 = mean(in(:, :, 1:kk), 3);
    u0arr(:,:,kk) = u0;
    u1 = mean(in(:,:, kk+1:end) ,3);
    u1arr(:,:,kk) = u1;
    w0 = kk/8;
    w1 = (8-kk)/8;
    sigmaB(:, :, kk) = w0*w1*(u0 - u1).^2;
end
[~, ind] = max(sigmaB, [], 3);
row = size(in, 1);
col = size(in, 2);
cc = repmat(1:col, row, 1);
rr = repmat([1:row]', 1, col);
ind1 = sub2ind([row, col, 7], rr, cc, ind);
mask = t*reshape(u1arr(ind1), row, col) > reshape(u0arr(ind1), row, col);
con = u;
con(mask) = 0;
end