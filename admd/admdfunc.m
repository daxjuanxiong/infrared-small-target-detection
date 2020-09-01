% Fast and robust small infrared target detection using absolute directional mean difference algorithm
% 1 双框计算对比度（置零）
% 2 多尺度
function re = admdfunc(img)
%% the scale is 3
out3 = subfubc(img, 3);
%% the scale is 5
out5 = subfubc(img, 5);
%% the scale is 7
out7 = subfubc(img, 7);
%%  the scale is 9
out9 = subfubc(img, 9);
%%
out = cat(3, out3, out5, out7, out9);
re = max(out, [], 3);
if 0
    figure; imshow(out3, []);  title('scale 3x3');
    figure; surf(out3); title('scale 3x3');
    figure; imshow(out5, []);   title('scale 5x5');
    figure; surf(out5); title('scale 5x5');
    figure; imshow(out7, []);   title('scale 7x7');
    figure; surf(out7); title('scale 7x7');
    figure; imshow(out9, []);   title('scale 9x9');
    figure; surf(out9); title('scale 9x9');
    figure; imshow(re, []);
    figure; surf(re);
end
end
function out3 = subfubc(img, len)
op35 = ones(len)/(len*len);
m35 = imfilter(double(img), op35, 'symmetric');
lx = floor(len/2);
ly = floor(len/2);
op = zeros(len * 3);
op(ly+1, lx+1) = 1;
op(ly+1, len + lx + 1) = 1;
op(ly+1, len*2 + lx + 1) = 1;
op(len + ly+1, lx+1) = 1;
op(len + ly+1, len + lx + 1) = 0;
op(len + ly+1, len*2 + lx + 1) = 1;
op(len*2 + ly+1, lx+1) = 1;
op(len*2 + ly+1, len + lx + 1) = 1;
op(len*2 + ly+1, len*2 + lx + 1) = 1;
m3b = imdilate(m35, op);
out3 = (m35 - m3b).^2.*(m35 - m3b>0);
end