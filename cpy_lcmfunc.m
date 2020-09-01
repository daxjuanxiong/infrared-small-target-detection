clc;
clearvars;
close all;
wflag = 0;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
    img = img(:,:,1);
    img = img(:, :, 1);
    %% MLCM_fun函数的结果和lcmfunc函数的结果完全相同
    re = MLCM_fun(img);
    re1 = lcmfunc(img);
    bw = bwfunc(re);
    figure; imshow(re, []);
    figure; imshow(re1, []);
end