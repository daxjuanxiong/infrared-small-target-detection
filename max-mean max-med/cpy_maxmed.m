clc;
clearvars;
close all;
cy = 100;
cx = 100;
r = 1;
img = ones(500, 500)*100;
img(cy-r:cy+r, cx-r:cx+r) = 200;
img = uint8(img);
figure; imshow(img);
img = double(img);
re = maxMean(img, 2*r+1);% ??????
figure; imshow(re, []);
re1 = maxMed(img, 2*r+1);% ??????
figure; imshow(re1, []);




