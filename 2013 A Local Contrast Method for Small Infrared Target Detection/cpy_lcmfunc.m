clc;
clearvars;
close all;
wflag = 0;
channel = 1;
readimg;
img = img(:, :, 1);
%% MLCM_fun函数的结果和lcmfunc函数的结果完全相同
re = MLCM_fun(img);
re1 = lcmfunc(img); 
bw = bwfunc(re);
figure; imshow(re, []);
figure; imshow(re1, []);