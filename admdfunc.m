% Fast and robust small infrared target detection using absolute directional mean difference algorithm
% 1 多尺度： 目标框的尺度3x3 - 9x9，背景框的尺寸是目标框尺寸的3倍
%     lcm是                 目标区域最大值^2
%                                -----------------
%                    周围8个背景区域平均值的最大值
% admd是 （目标区域平均值 -  周围8个背景区域平均值的最大值）^2
function re = admdfunc(img)
img = double(img);
%% the scale is 3
out3 = subfunc(img, 3);
%% the scale is 5
out5 = subfunc(img, 5); 
%% the scale is 7
out7 = subfunc(img, 7); 
%%  the scale is 9
out9 = subfunc(img, 9); 
%%
out = cat(3, out3, out5, out7, out9);
re = max(out, [], 3);
if 0
    figure; imshow(uint8(img));
    figure; imshow(out3, []);  title('scale 3x3');
    figure; imshow(out5, []);   title('scale 5x5');
    figure; imshow(out7, []);   title('scale 7x7');
    figure; imshow(out9, []);   title('scale 9x9');
    figure; imshow(re, []);
	 figure; surf(out3); title('scale 3x3');
	   figure; surf(out5); title('scale 5x5');
	  figure; surf(out7); title('scale 7x7');
	  figure; surf(out9); title('scale 9x9');
end
end
function re = subfunc(img, len)
opt = ones(len)/(len*len);
mt = imfilter(double(img), opt, 'replicate');
r = floor(len/2);
op = zeros(len * 3);
op(r+1, r+1) = 1;
op(r+1, len + r + 1) = 1;
op(r+1, len*2 + r + 1) = 1;
op(len + r+1, r+1) = 1;
op(len + r+1, len + r + 1) = 0;
op(len + r+1, len*2 + r + 1) = 1;
op(len*2 + r+1, r+1) = 1;
op(len*2 + r+1, len + r + 1) = 1;
op(len*2 + r+1, len*2 + r + 1) = 1;
mb = imdilate(mt, op);
re = (mt - mb).^2.*(mt - mb>0);
end