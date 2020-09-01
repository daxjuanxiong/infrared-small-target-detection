% 2016 Multiscale patch-based contrast measure for small infrared target detection
clearvars;
close all;
clc;
flag = 1;
wflag = 1;
for kk = 1
    fold = '.\data\';% 27 images
    try
        img = imread([fold, num2str(kk), '.jpg']);
    catch
        img = imread([fold, num2str(kk), '.bmp']);
    end
img = double(img);
re = MPCM_fun(img);
bw = bwfunc(re);
if flag
    figure; imshow(re, []);
    figure; surf(re);
    xlabel('x');
    ylabel('y');
    figure; imshow(bw);
end
if wflag
    refold = '.\';
    imwrite(uint8(img), [refold, num2str(kk), '1.png']);
    imwrite(uint8( mat2gray(re) * 255), [refold, num2str(kk), '2.png']);
    imwrite(bw, [refold, num2str(kk), '3.png']);
end
end

