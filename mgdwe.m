% Infrared Small-Target Detection Using Multiscale Gray Difference Weighted Image Entropy
function re = mgdwe(img)
%%  计算multiscale gray difference有效果，
%%  但是灰度级变化距离的边缘会产生虚警
img = double(img);
[row, col]=size(img);
L = 7; %
opb = ones(L);
opb = opb/sum(opb(:));
Nb = imfilter(double(img), opb, 'symmetric');
kmax = (L-1)/2;
D = zeros(row, col, kmax);
for ii=1:kmax;  %k为半径
    k1=2*ii+1;
    opk =  ones(k1);
    opk = opk/sum(opk(:));
    Nk=imfilter(double(img), opk, 'symmetric');
    D(:,:,ii)=(Nk - Nb).^2;
end
D=max(D, [], 3);
%%  局部熵这个方法不行
%% 越是灰度值均匀的地方，熵的值越大
%% 越是灰度值不均匀的地方，熵的值越小。
r = 2; % 这个参数论文中并没有给出
pad = padarray(img, [r, r], 'symmetric', 'both');
E = zeros(row, col);
for ii=1:row
    for jj=1:col
        u = ii + r;
        v = jj + r;
        block = pad(u-r:u+r, v-r:v+r);
        % method 1: 不太容易理解
        bh1 = hist(block(:), 0:255);
        bh2 = (bh1>0).*[0: 255]/sum(bh1.*[0:255]); % 概率
        ind = find(bh2);
        bh3 = (bh1).*[0: 255]/sum(bh1.*[0:255]); % 概率
        val = -sum(bh3(ind) .* log2(bh2(ind)) );% Compute entropy
        % method 2: 更容易理解
        % t = double( block(:) );
        % t(t ==0) = [];
        % t = t/sum(t);
        % val = -sum(t.*log2(t));
        E(ii, jj) = val;
    end
end
re= D.*E;
if 0
    figure; imshow(D, []);
    %     set(gca,'XLim',[0,col],'YLim',[0,row]);
    %     xlabel('x');
    %     ylabel('y');
    %     title(' 3D--Multiscale gray difference ');
    %%
    figure; imshow(E, []);
    [y, x] = find(E == min(E(:)) );
    hold on;
    plot(x, y, 'rs');
    hold off;
    figure; imshow(re,[]);
end
end