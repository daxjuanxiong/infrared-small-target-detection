% 2016 Small Infrared Target Detection Based on Weighted Local Difference Measure
% 与mgdwe类似，同一个人的论文，框架是一样的，
% 不同的是计算对比度和熵的方法
function re = wldmfunc(img)
%%  计算对比度的方法效果差
img = double(img);
[row, col]=size(img);
L = 9;
opb = ones(L);
opb = opb/sum(opb(:));
AL = imfilter(double(img), opb, 'replicate');
kmax = (L-1)/2;
D = zeros(row, col, kmax-1);
Ak = zeros(row, col, kmax);
Ak(:, :, end) = AL;
for ii=1:kmax-1;  % ii为半径
    k1=2*ii+1;
    opk =  ones(k1);
    opk = opk/sum(opk(:));
    Ak(:, :, ii) =imfilter(double(img), opk, 'replicate');
    D(:, :, ii) = (Ak(:,:,ii) - AL).^2;
end
Dmin = min(Ak, [], 3);
Dmax = max(Ak, [], 3);
tt = (Dmax - Dmin).^2; % tt有效果
tt = repmat(tt, 1, 1, 3);
C = D./tt;
C =max(C, [], 3); % 效果不行
%%  计算局部熵有效果（框内灰度级的种类越多，局部熵的值越大）
r = 2;
pad = padarray(img, [r, r], 'replicate', 'both');
pad = double(pad);
E = zeros(row, col);
for ii=1:row
    for jj=1:col
        u = ii + r;
        v = jj + r;
        block = pad(u-r:u+r, v-r:v+r);
        bh = hist(block(:), 0:255);
        bh = bh/sum(bh);
        ind = find(bh);
        g= 0:255;
        fxy = pad(u, v);
        val = sum( (g(ind) - fxy).^2.*bh(ind) .* log2(1./bh(ind)) );
        E(ii, jj) = val;
    end
end
re= C.*E;
if 0
    figure; imshow(C, []);  
	title('Multiscale gray difference');
    figure; imshow(E, []);
    [y, x] = find(E == max(E(:)) );
    hold on;
    plot(x, y, 'rs');
    hold off;
    figure; imshow(re,[]);
end
end