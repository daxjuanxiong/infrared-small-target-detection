% Small infrared target detection using absolute average difference weighted by cumulative directional derivatives
% 1 双框计算对比度（置零）
% 2 多尺度
function re = aadcddfunc(img)
img = double(img);
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
function re = subfubc(img, len)
lx = floor(len/2);
ly = floor(len/2);
opin = ones(len)/(len*len);
ain = imfilter(double(img), opin, 'symmetric');
opout = ones(19 , 19);
opout(10-ly:10+ly, 10-lx:10+lx) = 0;
opout = opout/sum(opout(:));
aout = imfilter(double(img), opout, 'symmetric');
D1 = (ain - aout ).^2.*(ain - aout >=0);
%%
op1 = zeros(len+2, len+2);
op2 = op1;
op3 = op1;
op4 = op1; 
op1(ly+2, lx+2:end-1) = 1;
op1(ly+2, end) = -(lx+1);
op2(ly+2, 2:lx+2) = 1;
op2(ly+2, 1) = -(lx+1);
op3(ly+2:end-1, lx+2) = 1;
op3(end, lx+2) = -(ly+1);
op4(2:ly+2, lx+2) = 1;
op4(1, lx+2) = -(ly+1);

g1 = imfilter(img, op1, 'symmetric');
g1 = g1.*(g1>=0);
g2 = imfilter(img, op2, 'symmetric');
g2 = g2.*(g2>=0);
g3 = imfilter(img, op3, 'symmetric');
g3 = g3.*(g3>=0);
g4= imfilter(img, op4, 'symmetric');
g4 = g4.*(g4>=0);
temp =cat(3, g1, g2, g3, g4);
D2 = min(temp, [], 3);
re = D1.*D2;
end