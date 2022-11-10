%  Infrared small target detection via line-based reconstruction and entropy-induced suppression
function [re, re1, re2] = lrfunc(img)
[row,col] = size(img);
img = double(img);
sita = zeros(row, col, 12);
pad = padarray(img, [6, 6], 'replicate');
for p=1:12;
    seta=p*pi/6;
    x2 = repmat(1:col, row, 1) + 6 + 2*cos(seta);     x2 = round(x2);
    y2 = repmat([1:row]', 1, col) + 6 + 2*sin(seta);     y2 = round(y2);
    x4 = repmat(1:col, row, 1) + 6 + 4*cos(seta);     x4 = round(x4);
    y4 = repmat([1:row]', 1, col) + 6 + 4*sin(seta);     y4 = round(y4);
    x6 = repmat(1:col, row, 1) +6 + 6*cos(seta);     x6 = round(x6);
    y6 = repmat([1:row]', 1, col) +6 + 6*sin(seta);     y6 = round(y6);
    
    ind2 = sub2ind(size(pad), y2, x2);
    val2 = pad(ind2);
    ind4 = sub2ind(size(pad), y4, x4);
    val4 = pad(ind4);
    ind6 = sub2ind(size(pad), y6, x6);
    val6 = pad(ind6);
    tt = cat(3, val2, val4, val6);
    line = min(tt, [], 3);
    %% 比较耗时
    %{
    for i= 1:row
        for j= 1:col
            y = round(i + 6 +  [2:2:6]*sin(seta));
            x = round(j + 6 +  [2:2:6]*cos(seta));
            vec = [];
            for kk = 1:length(x)
                vec  =[vec; pad(y(kk), x(kk))];
            end
            line(i,j) = min(vec);
        end
    end
    %}
    sita(:, :, p) = line;
end
back=max(sita, [], 3);
re1 = double(img)-back;
re = (re1 - mean2(re1)).^2; %  论文里的结果
%%
re2 = re1;
re2(re2<0) = 0; % 论文里没有这个步骤
if 0
    figure; imshow(uint8(img)); title('original image');
    hold on;
    [y,x] = find(img == min(img(:)));
    plot(x, y, 'rs');
    hold off;
    img(y, x)
    back(y, x)
    figure; imshow(back, []);
    figure; imshow(re, []); title('re'); 
    figure; imshow(re1, []); title('re1');
    figure; imshow(re2, []); title('re2');
end
end